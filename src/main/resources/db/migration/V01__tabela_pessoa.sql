CREATE TABLE tb_pessoa (
  id_usuario int NOT NULL AUTO_INCREMENT,
  email_usuario varchar(255) NOT NULL,
  nome_usuario varchar(255) NOT NULL,
  senha_usuario varchar(255) NOT NULL,
  PRIMARY KEY (id_usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;