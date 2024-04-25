package com.exceptionhandle;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.context.request.WebRequest;

@ControllerAdvice
public class TdsExceptionHandler {

	@Autowired
	private MessageSource messageSource;


	protected ResponseEntity<Object> handleExceptionInternal(HttpMessageNotReadableException ex, 
			String string, HttpHeaders headers, HttpStatus status, WebRequest request) {
	
		String mensagemUsuario = messageSource.getMessage("mensagem.invalidai", null, LocaleContextHolder.getLocale());
		String mensagemDesenvolvedor = ex.getCause().toString();
	
		return handleExceptionInternal(ex, "Mensagem invalida", headers, HttpStatus.BAD_REQUEST, request);
	}
	
	public static class Erro {
		private String mensagemUsuario;
		private String mensagemDesenvolvedor;
	

		public Erro(String mensagemUsuario, String mensagemDesenvolvedor) {
			this.mensagemUsuario = mensagemUsuario;
			this.mensagemDesenvolvedor = mensagemDesenvolvedor;
		}
	
		public String getMensagemUsuario() {
			return mensagemUsuario;
		}
	
		public String getMensagemDesenvolvedor() {
			return mensagemDesenvolvedor;
		}
	}
	

}
