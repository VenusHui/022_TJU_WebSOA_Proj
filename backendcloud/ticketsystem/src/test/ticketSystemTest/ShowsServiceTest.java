package ticketSystemTest;
// 引入正确的类
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.ticket.ticketsystem.mapper.HistrionicsMapper;
import com.ticket.ticketsystem.mapper.ShowsMapper;
import com.ticket.ticketsystem.mapper.TicketStallMapper;
import com.ticket.ticketsystem.pojo.Histrionics;
import com.ticket.ticketsystem.pojo.Shows;
import com.ticket.ticketsystem.service.impl.ShowsServiceImpl;
import com.ticket.ticketsystem.service.impl.utils.assembler.ShowsModelAssembler;
import java.util.ArrayList;
import java.util.List;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

// 请注意注解类型
@ExtendWith(MockitoExtension.class)
public class ShowsServiceTest {
  // 模拟Mapper类，注意注解
  @Mock
  private ShowsMapper showsMapper;

  @Mock
  private HistrionicsMapper histrionicsMapper;

  @Mock
  private TicketStallMapper ticketStallMapper;

  @Mock
  private ShowsModelAssembler showsModelAssembler;

  // 对于要测试的类，采用注入Mock的方式
  @InjectMocks
  private ShowsServiceImpl showsService;

  @BeforeEach
  public void setup() {
    // 模拟数据库响应
    Shows shows = new Shows();
    shows.setShowId(1);
    // 模拟Mapper方法
    when(showsMapper.selectOne(any(QueryWrapper.class))).thenReturn(shows);

    Histrionics histrionics = new Histrionics();
    histrionics.setShowId(1);
    histrionics.setHistrionicsId(1);

    List<Histrionics> histrionicsList = new ArrayList<>();
    histrionicsList.add(histrionics);

    when(histrionicsMapper.selectList(any(QueryWrapper.class))).thenReturn(histrionicsList);
  }

  @Test
  public void getShowDetailByShowIdTest() {

    // 测试主体，可使用更复杂的逻辑
    Map<String, Object> result = showsService.getShowDetailByShowId(1);

    // 输出测试得到的结果到控制台
    System.out.print(result);

    // 将结果与预期比较
    assertEquals("success", result.get("status"));
    assertEquals(3, result.get("message"));
  }
}
