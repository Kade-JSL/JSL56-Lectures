package com.jslhrd.controller.portfolio;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.jslhrd.controller.TblMenu;
import com.jslhrd.dao.PortfolioDao;
import com.jslhrd.dto.PortfolioDto;
import com.jslhrd.utility.Criteria;
import com.jslhrd.utility.PageDto;

public class Portfolio extends TblMenu {

	public Portfolio(HttpServletRequest request, HttpServletResponse response) {
		super(request, response);
	}

	@Override
	public void doJavaGet() throws IOException {
		PortfolioDao pageDao = PortfolioDao.getInstance();
		int pageNum = 1, amount = 5;
		if (request.getParameter("p") != null) {
			pageNum = Integer.parseInt(request.getParameter("p"));
		}
		if (request.getParameter("a") != null) {
			amount = Integer.parseInt(request.getParameter("a"));
		}

		Criteria cri = new Criteria(pageNum, amount);
		PageDto pageDto = new PageDto(cri, pageDao.portCount());
		List<PortfolioDto> tblList = pageDao.readPortList(cri);
		for (PortfolioDto p : tblList) {
			p.setContent(p.getContent().replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", ""));
		}
		
		request.setAttribute("pagemaker", pageDto);
		request.setAttribute("list", tblList);
	}

}
