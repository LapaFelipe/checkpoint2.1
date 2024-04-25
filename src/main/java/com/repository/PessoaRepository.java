package com.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.modelo.Pessoa;


public interface PessoaRepository extends JpaRepository<Pessoa, Integer> {

}
