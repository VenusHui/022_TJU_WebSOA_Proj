import static org.junit.jupiter.api.Assertions.assertEquals;

import com.ticket.ticketsystem.mapper.OrdersMapper;
import com.ticket.ticketsystem.mapper.PurchaseMapper;
import com.ticket.ticketsystem.mapper.TicketMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Orders;
import com.ticket.ticketsystem.pojo.TicketStall;
import com.ticket.ticketsystem.service.impl.OrderServiceImpl;
import com.ticket.ticketsystem.service.impl.utils.assembler.OrdersModelAssembler;
import java.lang.reflect.Field;
import java.util.Collections;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import org.junit.jupiter.api.Test;
import org.mockito.Mockito;

class OrderServiceImplTest {

  @Test
//标注该方法为单元测试用例
  void getOrderByUserId() throws NoSuchFieldException, IllegalAccessException {

    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    Class class1 = OrderServiceImpl.class;//获取OrderServiceImpl该类
    Field field = class1.getDeclaredField("ordersMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, ordersMapper);//给私有变量ordersMapper赋值

    Orders or = new Orders();//创建Orders对象
    List<Orders> orderList = new LinkedList<>();//创建List数组
    orderList.add(or);//把or添加进数组orderList里
    Mockito.when(ordersMapper.selectList(Mockito.any()))
        .thenReturn(orderList);//当调用ordersMapper.selectList，都会返回一个orderList
    Mockito.when(ordersModelAssembler.toCollectionModel(Mockito.any()))
        .thenReturn(null);//当调用ordersModelAssembler.toCollectionModel，都会返回null
    Map<String, Object> m = o.getOrderByUserId(123);//调用getOrderByUserId进行测试
    System.out.println("status:" + m.get("status"));
    assertEquals(m.get("status"), "success");//断言，验证status字段为success


  }

  @Test
  void getOrderByUserId_emptyResult() {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    Mockito.when(ordersMapper.selectList(Mockito.any())).thenReturn(Collections.emptyList());

    Map<String, Object> m = o.getOrderByUserId(null);

    assertEquals("error", m.get("status"));

  }

 

  @Test
  void getOrderDetailByOrderId() throws NoSuchFieldException, IllegalAccessException {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    Class class1 = OrderServiceImpl.class;
    Field field = class1.getDeclaredField("ordersMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, ordersMapper);

    Orders or = new Orders();
    List<Orders> orderList = new LinkedList<>();
    ;
    orderList.add(or);
    Mockito.when(ordersMapper.selectList(Mockito.any())).thenReturn(orderList);
    Mockito.when(ordersModelAssembler.toModel(Mockito.any())).thenReturn(null);

    Map<String, Object> map = o.getOrderDetailByOrderId(123);
    System.out.println("status:" + map.get("status"));
    assertEquals(map.get("status"), "success");

  }

  @Test
  void postOrder_01() {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    Map<String, Object> map = o.postOrder(123, 123, null, null);
    System.out.println("status:" + map.get("status"));
    System.out.println("message:" + map.get("message"));
    assertEquals(map.get("status"), "error");
    assertEquals(map.get("message"), "参数不能为空");
  }

  @Test
  void postOrder_02() {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    List<String> viewers = new LinkedList<>();
    viewers.add("a");
    Map<String, Object> map = o.postOrder(123, 123, 0, viewers);
    System.out.println("status:" + map.get("status"));
    System.out.println("message:" + map.get("message"));
    assertEquals(map.get("status"), "error");
    assertEquals(map.get("message"), "购票数目必须为正整数");
  }

  @Test
  void postOrder_03() {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    List<String> viewers = new LinkedList<>();
    viewers.add("a");
    Map<String, Object> map = o.postOrder(123, 123, 2, viewers);
    System.out.println("status:" + map.get("status"));
    System.out.println("message:" + map.get("message"));
    assertEquals(map.get("status"), "error");
    assertEquals(map.get("message"), "错误的参数个数");
  }

  @Test
  void postOrder_04() throws NoSuchFieldException, IllegalAccessException {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    List<String> viewers = new LinkedList<>();
    viewers.add("a");

    TicketStall ticketStall = new TicketStall();
    ticketStall.setRemaining(0);

    Class class1 = OrderServiceImpl.class;
    Field field = class1.getDeclaredField("ticketStallMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, ticketStallMapper);

    Mockito.when(ticketStallMapper.selectOne(Mockito.any())).thenReturn(ticketStall);

    Map<String, Object> map = o.postOrder(123, 123, 1, viewers);
    System.out.println("status:" + map.get("status"));
    System.out.println("message:" + map.get("message"));
    assertEquals(map.get("status"), "error");
    assertEquals(map.get("message"), "剩余库存不足");
  }

  @Test
  void postOrder_05() throws NoSuchFieldException, IllegalAccessException {
    OrdersMapper ordersMapper = Mockito.mock(OrdersMapper.class);
    TicketStallMapper ticketStallMapper = Mockito.mock(TicketStallMapper.class);
    TicketMapper ticketMapper = Mockito.mock(TicketMapper.class);
    PurchaseMapper purchaseMapper = Mockito.mock(PurchaseMapper.class);
    OrdersModelAssembler ordersModelAssembler = Mockito.mock(OrdersModelAssembler.class);
    OrderServiceImpl o = new OrderServiceImpl(ordersMapper, ticketStallMapper, ticketMapper,
        purchaseMapper, ordersModelAssembler);

    List<String> viewers = new LinkedList<>();
    viewers.add("a");

    TicketStall ticketStall = new TicketStall();
    ticketStall.setRemaining(10);
    ticketStall.setSold(10);
    ticketStall.setPrice(1.1);

    Class class1 = OrderServiceImpl.class;
    Field field = class1.getDeclaredField("ticketStallMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, ticketStallMapper);
    Mockito.when(ticketStallMapper.selectOne(Mockito.any())).thenReturn(ticketStall);

    class1 = OrderServiceImpl.class;//获取OrderServiceImpl该类
    field = class1.getDeclaredField("ordersMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, ordersMapper);//给私有变量ordersMapper赋值
    Mockito.when(ordersMapper.insert(Mockito.any())).thenReturn(1);

    class1 = OrderServiceImpl.class;//获取OrderServiceImpl该类
    field = class1.getDeclaredField("ticketMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, ticketMapper);//给私有变量ordersMapper赋值
    Mockito.when(ticketMapper.insert(Mockito.any())).thenReturn(1);

    class1 = OrderServiceImpl.class;//获取OrderServiceImpl该类
    field = class1.getDeclaredField("purchaseMapper"); //  getDeclaredField可以获取私有的变量
    field.setAccessible(true); // 为true时可以访问私有类型变量
    field.set(o, purchaseMapper);//给私有变量ordersMapper赋值
    Mockito.when(purchaseMapper.insert(Mockito.any())).thenReturn(1);

    Map<String, Object> map = o.postOrder(123, 123, 1, viewers);
    System.out.println("status:" + map.get("status"));
    System.out.println("message:" + map.get("message"));
    assertEquals(map.get("status"), "success");
    assertEquals(map.get("message"), "订单创建成功");
  }

}