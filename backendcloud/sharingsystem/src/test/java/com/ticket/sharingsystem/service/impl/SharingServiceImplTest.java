package com.ticket.sharingsystem.service.impl;

import com.ticket.sharingsystem.pojo.Sharing;
import com.ticket.sharingsystem.repository.SharingRepository;
import com.ticket.sharingsystem.service.impl.utils.assembler.SharingModelAssembler;
import java.util.Map;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.*;

@ExtendWith(MockitoExtension.class)
class SharingServiceImplTest {

  @Mock
  private SharingRepository repository;

  @Mock
  private SharingModelAssembler assembler;

  @InjectMocks
  private SharingServiceImpl sharingService;

  @BeforeEach
  void setUp() {
    sharingService = new SharingServiceImpl(repository, assembler);
  }

  @Test
  void getSharing_test1() {
    String testSharingId1 = "63aac0f7af5500002b001ee5";
    Sharing sharing1 = new Sharing();
    when(repository.findById(testSharingId1)).thenReturn(Optional.of(sharing1));
    try {
      Map<String, Object> result = sharingService.getSharing(testSharingId1);
      assertEquals("success", result.get("status"));
      System.out.println("getSharing_test1 passed");
    } catch (Exception e) {
      fail("getSharing_test1 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void getSharing_test2() {
    String testSharingId2 = "0";
    when(repository.findById(testSharingId2)).thenReturn(Optional.empty());
    try {
      Map<String, Object> result = sharingService.getSharing(testSharingId2);
      assertEquals("error", result.get("status"));
      assertTrue(((String) result.get("message")).contains(testSharingId2));
      System.out.println("getSharing_test2 passed");
    } catch (Exception e) {
      fail("getSharing_test2 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void getSharing_test3() {
    when(repository.findById(null)).thenThrow(new IllegalArgumentException("Sharing ID is null"));
    try {
      sharingService.getSharing(null);
      fail("getSharing_test3 should have thrown an exception");
    } catch (Exception e) {
      assertEquals(IllegalArgumentException.class, e.getClass());
      System.out.println("getSharing_test3 passed");
    }
  }

  @Test
  void setSharing_test1() {
    String testContext = "真好看";
    String testImageUrl = "url";
    Integer testStars = 1;
    Integer testLikes = 1;
    String testSharingId1 = "0";
    when(repository.findById(testSharingId1)).thenReturn(Optional.empty());
    try {
      Map<String, Object> result = sharingService.setSharing(testSharingId1, testContext, testImageUrl, testStars, testLikes);
      assertEquals("error", result.get("status"));
      System.out.println("setSharing_test1 passed");
    } catch (Exception e) {
      System.out.println("setSharing_test1 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void setSharing_test2() {
    String testContext = "真好看";
    String testImageUrl = "url";
    Integer testStars = 1;
    Integer testLikes = 1;
    when(repository.findById(null)).thenThrow(new IllegalArgumentException("Sharing ID is null"));
    try {
      sharingService.setSharing(null, testContext, testImageUrl, testStars, testLikes);
      fail("setSharing_test2 should have thrown an exception");
    } catch (Exception e) {
      assertEquals(IllegalArgumentException.class, e.getClass());
      System.out.println("setSharing_test2 passed");
    }
  }

  @Test
  void setSharing_test3() {
    String testContext = "真好看";
    String testImageUrl = "url";
    Integer testStars = 1;
    Integer testLikes = 1;
    String testSharingId3 = "63aac0f7af5500002b001ee5";
    Sharing sharing3 = new Sharing();
    when(repository.findById(testSharingId3)).thenReturn(Optional.of(sharing3));
    try {
      Map<String, Object> result = sharingService.setSharing(testSharingId3, testContext, testImageUrl, testStars, testLikes);
      assertEquals("success", result.get("status"));
      System.out.println("setSharing_test3 passed");
    } catch (Exception e) {
      System.out.println("setSharing_test3 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void setSharing_test4() {
    String testContext = null;
    String testImageUrl = "url";
    Integer testStars = 1;
    Integer testLikes = 1;
    String testSharingId3 = "63aac0f7af5500002b001ee5";
    Sharing sharing3 = new Sharing();
    when(repository.findById(testSharingId3)).thenReturn(Optional.of(sharing3));
    try {
      Map<String, Object> result = sharingService.setSharing(testSharingId3, testContext, testImageUrl, testStars, testLikes);
      assertEquals("error", result.get("status"));
      System.out.println("setSharing_test4 passed");
    } catch (Exception e) {
      System.out.println("setSharing_test4 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void setSharing_test5() {
    String testContext = "真好看";
    String testImageUrl = null;
    Integer testStars = 1;
    Integer testLikes = 1;
    String testSharingId3 = "63aac0f7af5500002b001ee5";
    Sharing sharing3 = new Sharing();
    when(repository.findById(testSharingId3)).thenReturn(Optional.of(sharing3));
    try {
      Map<String, Object> result = sharingService.setSharing(testSharingId3, testContext, testImageUrl, testStars, testLikes);
      assertEquals("error", result.get("status"));
      System.out.println("setSharing_test5 passed");
    } catch (Exception e) {
      System.out.println("setSharing_test5 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void setSharing_test6() {
    String testContext = "真好看";
    String testImageUrl = "url";
    Integer testStars = null;
    Integer testLikes = 1;
    String testSharingId3 = "63aac0f7af5500002b001ee5";
    Sharing sharing3 = new Sharing();
    when(repository.findById(testSharingId3)).thenReturn(Optional.of(sharing3));
    try {
      Map<String, Object> result = sharingService.setSharing(testSharingId3, testContext, testImageUrl, testStars, testLikes);
      assertEquals("success", result.get("status"));
      System.out.println("setSharing_test6 passed");
    } catch (Exception e) {
      System.out.println("setSharing_test6 failed with exception: " + e.getMessage());
    }
  }

  @Test
  void setSharing_test7() {
    String testContext = "真好看";
    String testImageUrl = "url";
    Integer testStars = 1;
    Integer testLikes = null;
    String testSharingId3 = "63aac0f7af5500002b001ee5";
    Sharing sharing3 = new Sharing();
    when(repository.findById(testSharingId3)).thenReturn(Optional.of(sharing3));
    try {
      Map<String, Object> result = sharingService.setSharing(testSharingId3, testContext, testImageUrl, testStars, testLikes);
      assertEquals("success", result.get("status"));
      System.out.println("setSharing_test7 passed");
    } catch (Exception e) {
      System.out.println("setSharing_test7 failed with exception: " + e.getMessage());
    }
  }
}
