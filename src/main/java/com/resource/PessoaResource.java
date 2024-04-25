package com.resource;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;

import com.event.RecursoCriadoEvent;
import com.modelo.Pessoa;
import com.repository.PessoaRepository;

import jakarta.servlet.http.HttpServletResponse;

@RestController
@RequestMapping("/pessoa")
public class PessoaResource {
	
	@Autowired
	private PessoaRepository pr;
	
	@Autowired
	private ApplicationEventPublisher publisher;
	
	@GetMapping
	public List<Pessoa> listPe() {
		return pr.findAll();
	}
	
	@PostMapping
	@ResponseStatus(HttpStatus.CREATED)
	public ResponseEntity<Pessoa> criar(@RequestBody Pessoa p, HttpServletResponse response) {
		Pessoa psalva = pr.save(p);

		publisher.publishEvent(new RecursoCriadoEvent(this, response, psalva.getId()));

		return ResponseEntity.status(HttpStatus.CREATED).body(psalva);
	
	
	}
	
	@GetMapping("/{codigo}")
	public ResponseEntity <? > buscarPeloCodigo(@PathVariable Integer codigo) {
		Optional<Pessoa> p = this.pr.findById(codigo);
		return p.isPresent() ? ResponseEntity.ok(p) : ResponseEntity.notFound().build();

	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
