// Decompiled by Jad v1.5.8g. Copyright 2001 Pavel Kouznetsov.
// Jad home page: http://www.kpdus.com/jad.html
// Decompiler options: packimports(3) 
// Source File Name:   OpenSourceController.java

package com.exe.opensource;

import com.exe.dao.*;
import com.exe.dto.DetailsDTO;
import com.exe.dto.FinalDTO;
import com.exe.dto.ListDTO;
import com.exe.dto.LoginDTO;
import com.exe.dto.UserDTO;
import java.io.PrintStream;
import java.util.List;

import javax.servlet.http.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

@Controller
public class OpenSourceController
{

	@Autowired
	UserDAO userDao;
	@Autowired
	ListDAO listDao;
	@Autowired
	DetailsDAO detailsDao;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public  ModelAndView index(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		List<ListDTO> lists = listDao.getUserListData();
		mav.addObject("lists", lists);
		mav.setViewName("index");

		return mav;
	}

	@RequestMapping(value = "/login.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String login(HttpSession session,HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		request.getSession().setAttribute("redirectURI", referer);
		return "login";
	}

	@RequestMapping(value = "/login_ok.action", method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView login_ok(UserDTO dto,HttpServletRequest request,HttpSession session) {

		String userId = dto.getUser_id();
		String userPwd = dto.getUser_password();
		ModelAndView mav = new ModelAndView();
		UserDTO dto2 = userDao.getReadUserData(userId);

		String redirectURI = (String)session.getAttribute("redirectURI");

		System.out.println("redirect로 받아온 url: "+ redirectURI);


		if(dto2 == null || !dto2.getUser_password().equals(userPwd))
		{
			mav.setViewName("login");
			mav.addObject("message", "아이디 혹은 비밀번호를 정확히 입력하세요");
			return mav;
		} 

		LoginDTO login = new LoginDTO();
		login.setUserId(dto2.getUser_id());
		login.setUserName(dto2.getUser_name());
		session.setAttribute("login", login);

		if(redirectURI.equals("http://15.165.78.149:8080/signupOK.action")
				 || redirectURI.equals("http://15.165.78.149:8080/signup.action")) {

			List<ListDTO> lists = listDao.getUserListData();
			mav.addObject("lists", lists);

			redirectURI = "http://15.165.78.149:8080/";

			mav.setView(new RedirectView(redirectURI,true));

			return mav;

		}


		mav.setView(new RedirectView(redirectURI, true));
		return mav;

	}


	//회원가입
	@RequestMapping(value = "/signup.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String signUp() {

		return "signup";
	}

	// 데이터 인서트하고 완료되었다는 페이지로 가는거
	@RequestMapping(value = "/signup_ok.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String signup_ok(UserDTO dto, HttpServletRequest req, HttpServletResponse res)
	{
		userDao.insertUser(dto);
		return "redirect:/signupOk.action";
	}

	// 가입 완료되었다고 보여주는 메세지- 로그인버튼 있음
	@RequestMapping(value = "/signupOk.action", method = { RequestMethod.GET, RequestMethod.POST })
	public String signupOk(HttpServletRequest req, HttpServletResponse res)
	{
		return "signupOk";
	}

	//로그아웃
	@RequestMapping(value = "/logout.action", method = {RequestMethod.GET,RequestMethod.POST})
	public String logout(HttpServletRequest request, HttpSession session) {

		session.removeAttribute("login");
		return "redirect:/";
	}

	@RequestMapping(value = "/details.action", 
			method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView details(HttpServletRequest req, HttpServletResponse res)
	{
		ModelAndView mav = new ModelAndView();
		String product_id = req.getParameter("product_id");

		List<DetailsDTO> lists = detailsDao.getDetailsData(product_id);
		List<DetailsDTO> lists2 = detailsDao.getBarGraph(product_id);
		int cnt[] = new int[3];
		cnt = detailsDao.getDonutGraph(product_id);

		mav.addObject("lists", lists);
		mav.addObject("lists2", lists2);
		mav.addObject("cnt", cnt);

		mav.setViewName("details");
		return mav;
	}

	@RequestMapping(value = "/final_details.action", 
			method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView final_details(HttpServletRequest req, HttpServletResponse res)
	{
		ModelAndView mav = new ModelAndView();
		String cve_id = req.getParameter("cve_id");

		List<FinalDTO> lists = detailsDao.getReference(cve_id);
		DetailsDTO dto2 = detailsDao.getFinalDetails(cve_id);

		mav.addObject("dto2", dto2);
		mav.addObject("lists", lists);
		mav.setViewName("final_details");
		return mav;
	}

	@RequestMapping(value = "/myinfo.action", 
			method = {RequestMethod.GET,RequestMethod.POST})
	public ModelAndView myInfo(HttpServletRequest req, HttpServletResponse res)
	{
		ModelAndView mav = new ModelAndView();
		mav.setViewName("myinfo");
		return mav;
	}



}
