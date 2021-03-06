package com.cglee079.changoos.controller;

import static org.mockito.Matchers.any;
import static org.mockito.Matchers.eq;
import static org.mockito.Matchers.same;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.delete;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.fileUpload;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.put;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.redirectedUrl;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.view;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.json.JSONObject;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.springframework.mock.web.MockHttpSession;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;

import com.cglee079.changoos.model.BlogVo;
import com.cglee079.changoos.model.PhotoVo;
import com.cglee079.changoos.service.PhotoService;
import com.google.gson.Gson;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration({"file:src/main/webapp/WEB-INF/spring/root-context.xml", "file:src/main/webapp/WEB-INF/spring/appServlet/**-context.xml"})
public class PhotoControllerTest {

	@Mock	
	private PhotoService photoService;
	
	@InjectMocks
	private PhotoController photoController;
	
	private MockMvc mockMvc;
	
	@Before
	public void setUp() {
		MockitoAnnotations.initMocks(this);
		mockMvc = MockMvcBuilders.standaloneSetup(photoController).build();
	}
	
	@Test
	public void testPhotoList() throws Exception {
		List<PhotoVo> photos = new ArrayList<>();
		List<Integer> seqs = new ArrayList<>();
		
		when(photoService.list(null)).thenReturn(photos);
		when(photoService.seqs()).thenReturn(seqs);
		
		mockMvc.perform(get("/photos"))
			.andExpect(status().isOk())
			.andExpect(view().name("photo/photo_view"))
			.andExpect(model().attribute("photos", photos))
			.andExpect(model().attribute("seqs", seqs));
	}
	
	
	@Test
	public void testPhotoView() throws Exception {
		int seq = 3;
		PhotoVo photo = PhotoVo.builder()
				.seq(seq)
				.build();
		
		Set<Integer> likePhotos = new HashSet<>();
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("likePhotos", likePhotos);
		
		when(photoService.get((Set<Integer>)session.getAttribute("likePhotos"), seq)).thenReturn(photo);
		
		mockMvc.perform(get("/photos/" + seq)
				.session(session))
			.andExpect(status().isOk())
			.andExpect(content().json(new Gson().toJson(photo).toString()));
	}
	
	@Test
	public void testPhotoManage() throws Exception {
		mockMvc.perform(get("/mgnt/photos"))
			.andExpect(status().isOk())
			.andExpect(view().name("photo/photo_manage"));
	}
	
	@Test
	public void testPhotoManagePaging() throws Exception {
		Map<String,Object> params = new HashMap<>();
		List<PhotoVo> photos = new ArrayList<>();
		
		when(photoService.list(params)).thenReturn(photos);
		
		mockMvc.perform(get("/mgnt/photos/records"))
			.andExpect(status().isOk())
			.andExpect(content().json(new Gson().toJson(photos).toString()));
	}
	
	
	@Test
	public void testPhotoUpload() throws Exception {
		mockMvc.perform(get("/photos/post"))
			.andExpect(status().isOk())
			.andExpect(view().name("photo/photo_upload"));
	}
	
	@Test
	public void testPhotoModify() throws Exception {
		int seq = 3;
		PhotoVo photo = PhotoVo.builder()
				.seq(seq)
				.build();
		
		when(photoService.get(seq)).thenReturn(photo);
		
		mockMvc.perform(get("/photos/post/" + seq))
			.andExpect(status().isOk())
			.andExpect(view().name("photo/photo_upload"))
			.andExpect(model().attribute("photo", photo));
	}
	
	@Test
	public void testPhotoDoUpload() throws Exception {
		String tempDirId = "SAMPLE_TEMPDIR_ID";
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("tempDirId", tempDirId);
		
		mockMvc.perform(post("/photos/post")
				.session(session))
			.andExpect(redirectedUrl("/mgnt/photos"))
			.andExpect(status().isFound());
			
		verify(photoService).insert(any(PhotoVo.class), eq((String)session.getAttribute("tempDirId")));
	}
	
	@Test
	public void testPhotoDoModify() throws Exception {
		String tempDirId = "SAMPLE_TEMPDIR_ID";
		int seq = 3;
		
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("tempDirId", tempDirId);
		
		mockMvc.perform(put("/photos/post/" + seq)
				.session(session))
			.andExpect(redirectedUrl("/mgnt/photos"))
			.andExpect(status().isFound());
			
		verify(photoService).update(any(PhotoVo.class), eq((String)session.getAttribute("tempDirId")));
	}
	
	@Test
	public void testPhotoDoDelete() throws Exception {
		int seq = 3;
		boolean result = true;
		
		when(photoService.delete(seq)).thenReturn(result);
		
		mockMvc.perform(delete("/photos/post/" + seq))
			.andExpect(status().isOk())
			.andExpect(content().json(new JSONObject().put("result", result).toString()));
	}
	
	@Test
	public void testPhotoImageDoUpload() throws Exception {
		String tempDirId = "SAMPLE_TEMPDIR_ID";
		PhotoVo photo = PhotoVo.builder().build();
		MockMultipartFile imageFile = new MockMultipartFile("image", new byte[1]);
		

		MockHttpSession session = new MockHttpSession();
		session.setAttribute("tempDirId", tempDirId);
		
		when(photoService.savePhoto(imageFile, (String)session.getAttribute("tempDirId"))).thenReturn(photo);
		
		mockMvc.perform(fileUpload("/photos/post/image")
				.file(imageFile)
				.session(session))
			.andExpect(status().isOk())
			.andExpect(content().json(new Gson().toJson(photo).toString()));
	}
	
	@Test
	public void testphotoDoLike() throws Exception {
		PhotoVo photo = PhotoVo.builder().build();
		int seq = 3;
		boolean like = true;
		Set<Integer> likePhotos = new HashSet<>();
		MockHttpSession session = new MockHttpSession();
		session.setAttribute("likePhotos", likePhotos);
		
		when(photoService.doLike(likePhotos, seq, like)).thenReturn(photo);
		
		mockMvc.perform(put("/photos/" + seq + "/like")
				.session(session)
				.param("like", String.valueOf(like)))
			.andExpect(status().isOk())
			.andExpect(content().json(new Gson().toJson(photo).toString()));
	}
	
	
}
