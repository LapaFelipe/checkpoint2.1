package com.event;

import org.springframework.context.ApplicationEvent;

import jakarta.servlet.http.HttpServletResponse;

public class RecursoCriadoEvent extends ApplicationEvent {
	
	private static final long serialVersionUID = 1L;

	private HttpServletResponse response;
	private Integer codigo;

	public RecursoCriadoEvent(Object source, HttpServletResponse response, Integer integer) {
		super(source);
		this.response = response;
		this.codigo = integer;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public Integer getCodigo() {
		return codigo;
	}

}
