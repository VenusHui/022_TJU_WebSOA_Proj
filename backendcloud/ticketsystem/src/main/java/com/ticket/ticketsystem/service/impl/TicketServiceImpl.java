package com.ticket.ticketsystem.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.*;
import com.ticket.ticketsystem.pojo.*;
import com.ticket.ticketsystem.service.TicketService;
import com.ticket.ticketsystem.service.impl.utils.assembler.TicketModelAssembler;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.utils.URIBuilder;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URISyntaxException;
import java.util.*;

@Service
public class TicketServiceImpl implements TicketService {

    @Autowired
    TicketMapper ticketMapper;
    @Autowired
    TicketStallMapper ticketStallMapper;
    @Autowired
    HistrionicsMapper histrionicsMapper;
    @Autowired
    ShowsMapper showsMapper;
    @Autowired
    OrdersMapper ordersMapper;
    @Autowired
    ResaleMapper resaleMapper;
    @Autowired
    PurchaseMapper purchaseMapper;

    private TicketModelAssembler ticketModelAssembler;

    public TicketServiceImpl(TicketModelAssembler ticketModelAssembler) {
        this.ticketModelAssembler = ticketModelAssembler;
    }

    @Override
    public Map<String, Object> getTicketDetail(Integer ticketId) {
        Map<String, Object> response = new HashMap<>();

        QueryWrapper<Ticket> ticketQueryWrapper = new QueryWrapper<>();
        ticketQueryWrapper.eq("ticket_id", ticketId);
        Ticket ticket = ticketMapper.selectOne(ticketQueryWrapper);

        QueryWrapper<TicketStall> ticketStallQueryWrapper = new QueryWrapper<>();
        ticketStallQueryWrapper.eq("ticket_stall_id", ticket.getTicketStallId());
        TicketStall ticketStall = ticketStallMapper.selectOne(ticketStallQueryWrapper);

        QueryWrapper<Histrionics> histrionicsQueryWrapper = new QueryWrapper<>();
        histrionicsQueryWrapper.eq("histrionics_id", ticketStall.getHistrionicsId());
        Histrionics histrionics = histrionicsMapper.selectOne(histrionicsQueryWrapper);

        QueryWrapper<Shows> showQueryWrapper = new QueryWrapper<>();
        showQueryWrapper.eq("show_id", histrionics.getShowId());
        Shows shows = showsMapper.selectOne(showQueryWrapper);

        Map<String, Object> data = new HashMap<>();
        data.put("ticket", ticketModelAssembler.toModel(ticket));
        data.put("ticket_stall", ticketStall);
        data.put("histrionics", histrionics);
        data.put("shows", shows);

        response.put("status", "success");
        response.put("message", data.size());
        response.put("data", data);

        return response;
    }

    @Override
    public Map<String, Object> getValidTicketByUserId(Integer userId) {
        Map<String,Object> response=new HashMap<>();
        QueryWrapper<Orders> ordersQueryWrapper=new QueryWrapper<>();
        ordersQueryWrapper.eq("user_id",userId);
        List<Orders> ordersList=ordersMapper.selectList(ordersQueryWrapper);
        List<Ticket> valid_tickets=new ArrayList<>();
        for(int i=0;i<ordersList.size();i++){
            QueryWrapper<Purchase> purchaseQueryWrapper=new QueryWrapper<>();
            purchaseQueryWrapper.eq("order_id",ordersList.get(i).getOrderId());
            List<Purchase> purchaseList=purchaseMapper.selectList(purchaseQueryWrapper);
            for(int j=0;j<purchaseList.size();j++){
                int ticketId=purchaseList.get(j).getTicketId();
                QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
                ticketQueryWrapper.eq("ticket_id",ticketId);
                ticketQueryWrapper.eq("status",1);
                Ticket ticket=ticketMapper.selectOne(ticketQueryWrapper);
                if(ticket!=null) {
                    valid_tickets.add(ticket);
                }
            }
        }

        QueryWrapper<Resale> resaleQueryWrapper=new QueryWrapper<>();
        resaleQueryWrapper.eq("buyer_id",userId);
        List<Resale> resaleList=resaleMapper.selectList(resaleQueryWrapper);
        for(int i=0;i<resaleList.size();i++){
            int ticketId=resaleList.get(i).getTicketId();
            QueryWrapper<Ticket> ticketQueryWrapper=new QueryWrapper<>();
            ticketQueryWrapper.eq("ticket_id",ticketId);
            ticketQueryWrapper.eq("status",3);
            Ticket ticket=ticketMapper.selectOne(ticketQueryWrapper);
            if(ticket!=null){
                valid_tickets.add(ticket);
            }
        }


        response.put("status","success");
        response.put("message",valid_tickets.size());
        response.put("data",valid_tickets);
        return response;
    }

    @Override
    public Map<String, Object> verifyTicket(Integer ticketId) {
        Map<String,Object> response=new HashMap<>();
        Map<String,Object> data=new HashMap<>();
        CloseableHttpClient httpClient= HttpClients.createDefault();
        Map<String,String> params=new HashMap<>();
        params.put("key","2dabbdd2e426e48f32aa89a8d61dac3d");
        params.put("text","ticket://"+ticketId+"#$Rd34645");
        CloseableHttpResponse R=null;
        try{
            URIBuilder builder=new URIBuilder("http://apis.juhe.cn/qrcode/api");
            Iterator paramsIt=params.entrySet().iterator();
            while (paramsIt.hasNext()){
                Map.Entry entry=(Map.Entry)paramsIt.next();
                builder.addParameter((String)entry.getKey(),(String)entry.getValue());
            }
            HttpGet httpGet=new HttpGet(builder.build());
            httpGet.setHeader("Content-Type","application/x-www-form-urlencoded");

            R= httpClient.execute(httpGet);
            if(R!=null&&R.getStatusLine().getStatusCode()==200){
                String resStr= EntityUtils.toString(R.getEntity());
                JSONObject jsonObject=JSONObject.parseObject(resStr);
                JSONObject jsonObject1=jsonObject.getJSONObject("result");
                //System.out.println("Debug"+jsonObject);
                resStr=jsonObject1.getString("base64_image");
                data.put("base64_image",resStr);
                response.put("status","success");
                response.put("message","验票成功");
                response.put("data",data);
                return response;
            }
        }catch (URISyntaxException e){
            e.printStackTrace();
        }catch (ClientProtocolException e){
            e.printStackTrace();
        }catch (IOException e){
            e.printStackTrace();
        }finally {
            try{
                httpClient.close();
                if(R!=null){
                    R.close();
                }
            }catch (IOException e){
                e.printStackTrace();
            }
        }
        return response;
    }

    @Override
    public Map<String, Object> getTicketByOrderId(Integer orderId) {
        Map<String, Object> response = new HashMap<>();
        QueryWrapper<Purchase> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("order_id", orderId);
        List<Purchase> purchases = purchaseMapper.selectList(queryWrapper);
        System.out.println(purchases);
        List<Ticket> tickets = new ArrayList<>();
        for (int i = 0; i < purchases.size(); i++) {
            int ticketId = purchases.get(i).getTicketId();
            QueryWrapper<Ticket> ticketQueryWrapper = new QueryWrapper<>();
            ticketQueryWrapper.eq("ticket_id", ticketId);
            tickets.add(ticketMapper.selectOne((ticketQueryWrapper)));
        }
        response.put("status", "success");
        response.put("message", tickets.size());
        response.put("data", tickets);
        return response;
    }
}
