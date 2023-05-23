package userSystemTest;

import com.ticket.backend.mapper.UserMapper;
import com.ticket.backend.pojo.User;
import com.ticket.backend.service.impl.user.UserInfoServiceImpl;
import com.ticket.backend.service.impl.utils.assembler.UserModelAssembler;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;

import java.util.Map;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.*;
import static org.mockito.Mockito.when;

public class UserInfoServiceImplTest {

  @Mock
  private UserMapper userMapper;

  @Mock
  private UserModelAssembler assembler;

  @InjectMocks
  private UserInfoServiceImpl userInfoService;

  @BeforeEach
  public void setUp() {
    MockitoAnnotations.openMocks(this);
  }

  @Test
  public void testGetUser_UserExists() {
    // Prepare
    User user = new User();
    user.setUserId(1);
    user.setUserName("John Doe");
    when(userMapper.selectById(anyInt())).thenReturn(user);
    when(assembler.toModel(any(User.class))).thenReturn(null);

    // Execute
    Map<String, Object> result = userInfoService.getUser(1);

    // Verify
    assertEquals("success", result.get("status"));
    assertEquals("", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testGetUser_UserNotExists() {
    // Prepare
    when(userMapper.selectById(anyInt())).thenReturn(null);

    // Execute
    Map<String, Object> result = userInfoService.getUser(0);

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户不存在", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testGetUser_UserIdNull() {
    // Execute
    Map<String, Object> result = userInfoService.getUser(null);

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户不存在", result.get("message"));
    assertNull(result.get("data"));
  }

  @Test
  public void testPutUserCity_UserNotExists() {
    // Prepare
    when(userMapper.update(any(), any())).thenReturn(0);

    // Execute
    Map<String, Object> result = userInfoService.putUserCity(0, "New City");

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户不存在", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserCity_UserIDNull() {
    // Execute
    Map<String, Object> result = userInfoService.putUserCity(null, "New City");

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户ID不能为空", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserCity_UserCityNull() {
    // Execute
    Map<String, Object> result = userInfoService.putUserCity(1, null);

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("城市不能为空", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserCity_UserCityEmpty() {
    // Prepare
    when(userMapper.update(any(), any())).thenReturn(1);

    // Execute
    Map<String, Object> result = userInfoService.putUserCity(1, "");

    // Verify
    assertEquals("success", result.get("status"));
    assertEquals("用户修改城市成功", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserCity_Success() {
    // Prepare
    when(userMapper.update(any(), any())).thenReturn(1);

    // Execute
    Map<String, Object> result = userInfoService.putUserCity(1, "New City");

    // Verify
    assertEquals("success", result.get("status"));
    assertEquals("用户修改城市成功", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserName_UserIDNull() {
    // Execute
    Map<String, Object> result = userInfoService.putUserName(null, "New Name");

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户ID不能为空", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserName_UserNotExists() {
    // Prepare
    when(userMapper.update(any(), any())).thenReturn(0);

    // Execute
    Map<String, Object> result = userInfoService.putUserName(1, "New Name");

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户不存在", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserName_UserNameNull() {
    // Execute
    Map<String, Object> result = userInfoService.putUserName(1, null);

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户名不能为空", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserName_UserNameEmpty() {
    // Execute
    Map<String, Object> result = userInfoService.putUserName(1, "");

    // Verify
    assertEquals("error", result.get("status"));
    assertEquals("用户名不能为空", result.get("message"));
    assertEquals(null, result.get("data"));
  }

  @Test
  public void testPutUserName_Success() {
    // Prepare
    when(userMapper.update(any(), any())).thenReturn(1);

    // Execute
    Map<String, Object> result = userInfoService.putUserName(1, "New Name");

    // Verify
    assertEquals("success", result.get("status"));
    assertEquals("用户修改用户名成功", result.get("message"));
    assertEquals(null, result.get("data"));
  }
}
