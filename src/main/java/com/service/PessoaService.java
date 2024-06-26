package com.service;

import java.util.Optional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;

import com.modelo.Pessoa;
import com.repository.PessoaRepository;

@Service
public class PessoaService {
	
	@Autowired
	private PessoaRepository pessoaRepository;

	public Pessoa atualizar(@PathVariable Integer codigo, @RequestBody Pessoa pessoa) {

		Pessoa pessoaSalva = this.pessoaRepository.findById(codigo)
				.orElseThrow(() -> new EmptyResultDataAccessException(1));
	
		BeanUtils.copyProperties(pessoa, pessoaSalva, "codigo");
	
		return this.pessoaRepository.save(pessoaSalva);
	}

	public void atualizarPropriedadeAtivo(Integer codigo, Boolean ativo) {
			Pessoa psalva = buscarPessoaPeloCodigo(codigo);
			psalva.setAtivo(ativo);
			pessoaRepository.save(psalva);

	}

	private Pessoa buscarPessoaPeloCodigo(Integer codigo) {

		Optional<Pessoa> psalva = pessoaRepository.findById(codigo);

		if (psalva == null) {
			throw new EmptyResultDataAccessException(1);

		}
		return psalva.get();
	}
}
