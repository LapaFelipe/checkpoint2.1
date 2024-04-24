CREATE TABLE `tb_sugestao` (
  `id_sugestao` int NOT NULL AUTO_INCREMENT,
  `desc_sugestao` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_sugestao`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `tb_usersuges` (
  `id_userSuges` int NOT NULL AUTO_INCREMENT,
  `id_user_userSeges` int NOT NULL,
  `id_userSeges` int NOT NULL,
  PRIMARY KEY (`id_userSuges`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- -----------------------------------------------------
-- Table tb_departamento
-- -----------------------------------------------------
CREATE TABLE tb_departamento (
id_depart INT NOT NULL auto_increment,
nome_depart VARCHAR(100) NOT NULL,
PRIMARY KEY (id_depart));
-- -----------------------------------------------------
-- Table tb_nacionalidade
-- -----------------------------------------------------
CREATE TABLE tb_nacionalidade (
id_nacionalidade INT NOT NULL auto_increment,
desc_nacionalidade VARCHAR(100) NOT NULL,
PRIMARY KEY (id_nacionalidade));

-- -----------------------------------------------------
-- Table tb_CiePesq
-- -----------------------------------------------------
CREATE TABLE tb_CiePesq (
id_CiePesq INT NOT NULL auto_increment,
ciepesq_nome VARCHAR(100) NOT NULL,
dta_nasc DATE NULL,
dta_fales DATE NULL,
ciepesq_email VARCHAR(45) NULL,
CiePesq_id_depart INT NOT NULL,
CiePesq_id_nacionalidade INT NOT NULL,
PRIMARY KEY ( id_CiePesq ),
CONSTRAINT CiePesq_tb_departamento
FOREIGN KEY ( CiePesq_id_depart )
REFERENCES tb_departamento( id_depart),
CONSTRAINT CiePesq_tb_nacionalidade
FOREIGN KEY ( CiePesq_id_nacionalidade )
REFERENCES tb_nacionalidade( id_nacionalidade ));

-- -----------------------------------------------------
-- Table tb_corpo

-- -----------------------------------------------------
CREATE TABLE tb_corpo (
cod_corpo INT NOT NULL auto_increment,
dta_descoberta int NULL,
corpo_CiePesq INT NOT NULL,
PRIMARY KEY ( cod_corpo ),
CONSTRAINT corpo_tb_CiePesq
FOREIGN KEY ( corpo_CiePesq )
REFERENCES tb_CiePesq ( id_CiePesq));

-- -----------------------------------------------------
-- Table tb_componente
-- -----------------------------------------------------
CREATE TABLE tb_componente (
id_componente INT NOT NULL auto_increment,
nome_componente VARCHAR(100) NOT NULL,
PRIMARY KEY ( id_componente ));

-- -----------------------------------------------------
-- Table tb_planetaTipo
-- -----------------------------------------------------
CREATE TABLE tb_planetaTipo (
id_planetTipo INT NOT NULL auto_increment,
desc_tipo VARCHAR(100) NOT NULL,
PRIMARY KEY ( id_planetTipo ));

-- -----------------------------------------------------
-- Table tb_constelacao
-- -----------------------------------------------------
CREATE TABLE tb_constelacao (
id_constelacao INT NOT NULL auto_increment,
const_desc VARCHAR(100) NOT NULL,
PRIMARY KEY ( id_constelacao ));

-- -----------------------------------------------------
-- Table tb_categoria
-- -----------------------------------------------------
CREATE TABLE tb_categoria (
cod_categoria VARCHAR(1) NOT NULL,
categoria_nome VARCHAR(100) NOT NULL,
PRIMARY KEY ( cod_categoria ));

-- -----------------------------------------------------
-- Table db_sistemaSolar . tb_CatTempCor
-- -----------------------------------------------------
CREATE TABLE tb_CatTempCor (

id_CatCorTemp INT NOT NULL auto_increment,
tempK_ini int NOT NULL,
tempK_fim int NOT NULL,
CCT_corCat VARCHAR(1) NOT NULL,
PRIMARY KEY ( id_CatCorTemp ),
CONSTRAINT CatTempCor_tb_categoria
FOREIGN KEY ( CCT_corCat )
REFERENCES tb_categoria ( cod_categoria ));

-- -----------------------------------------------------
-- Table tb_estrela
-- -----------------------------------------------------
CREATE TABLE tb_estrela (
id_estrela INT NOT NULL auto_increment,
estr_nome VARCHAR(45) NULL,
estrela_tb_corpo INT NOT NULL,
estrela_id_constelacao INT NOT NULL,
estrela_id_catCor INT NOT NULL,
PRIMARY KEY ( id_estrela ),
CONSTRAINT estrela_tb_corpo
FOREIGN KEY ( estrela_tb_corpo )
REFERENCES tb_corpo ( cod_corpo ),
CONSTRAINT estrela_tb_constelacao
FOREIGN KEY ( estrela_id_constelacao )
REFERENCES tb_constelacao ( id_constelacao ),
CONSTRAINT estrela_tb_catCor
FOREIGN KEY ( estrela_id_catCor )
REFERENCES tb_CatTempCor ( id_CatCorTemp ));

-- -----------------------------------------------------
-- Table tb_tipoGalax
-- -----------------------------------------------------
CREATE TABLE tb_tipoGalax (
id_tipoGalax INT NOT NULL auto_increment,
desc_tipoGalax VARCHAR(45) NOT NULL,
PRIMARY KEY ( id_tipoGalax ));

-- -----------------------------------------------------
-- Table tb_galaxia
-- -----------------------------------------------------
CREATE TABLE tb_galaxia (
id_galaxia INT NOT NULL auto_increment,
galax_desc VARCHAR(45) NOT NULL,
galax_tipoGalax INT NOT NULL,
PRIMARY KEY ( id_galaxia ),
CONSTRAINT galaxia_tb_tipoGalax
FOREIGN KEY ( galax_tipoGalax )
REFERENCES tb_tipoGalax ( id_tipoGalax ));

-- -----------------------------------------------------
-- Table tb_sistema
-- -----------------------------------------------------
CREATE TABLE tb_sistema (
id_sistema INT NOT NULL auto_increment,
desc_sistema VARCHAR(100) NULL,
sist_estrPrincipal INT NOT NULL,
sist_galax INT NOT NULL,
PRIMARY KEY ( id_sistema ),
CONSTRAINT sistema_tb_estrela
FOREIGN KEY ( sist_estrPrincipal )
REFERENCES tb_estrela ( id_estrela ),
CONSTRAINT sistema_tb_galaxia
FOREIGN KEY ( sist_galax )
REFERENCES tb_galaxia ( id_galaxia ));

-- -----------------------------------------------------
-- Table tb_planeta
-- -----------------------------------------------------
CREATE TABLE tb_planeta (
id_planeta INT NOT NULL auto_increment,
desc_planeta VARCHAR(100) NOT NULL,
vel_orb_kms DECIMAL NOT NULL,
diam_equatorial DECIMAL NOT NULL,
period_rotacao float NOT NULL,
gravidade DECIMAL NOT NULL,
plan_codCorpo INT NOT NULL,
plan_planetaTipo INT NOT NULL,
plan_id_sistema INT NOT NULL,
PRIMARY KEY ( id_planeta ),
CONSTRAINT planeta_tb_corpo
FOREIGN KEY ( plan_codCorpo )
REFERENCES tb_corpo ( cod_corpo ),
CONSTRAINT planeta_tb_planetaGasoso
FOREIGN KEY ( plan_planetaTipo )
REFERENCES tb_planetaTipo ( id_planetTipo ),
CONSTRAINT planeta_tb_sistema
FOREIGN KEY ( plan_id_sistema )
REFERENCES tb_sistema ( id_sistema ));
-- -----------------------------------------------------
-- Table tb_satNatural
-- -----------------------------------------------------
CREATE TABLE tb_satNatural (
cod_satNat INT NOT NULL auto_increment,
satNat_nome VARCHAR(100) NOT NULL,
satNat_corpo INT NOT NULL,
satNat_planet INT NOT NULL,

UNIQUE INDEX cod_satNat_UNIQUE ( cod_satNat ASC),
PRIMARY KEY ( cod_satNat ),
CONSTRAINT satNaturais_tb_corpo
FOREIGN KEY ( satNat_corpo )
REFERENCES tb_corpo ( cod_corpo ),
CONSTRAINT satNaturais_tb_planeta
FOREIGN KEY ( satNat_planet )
REFERENCES tb_planeta ( id_planeta ));

-- -----------------------------------------------------
-- Table tb_composicao
-- -----------------------------------------------------
CREATE TABLE tb_compAtmosfera (
cnt_componente float NOT NULL,
compo_id_componente INT NOT NULL,
compo_cod_corpo INT NOT NULL,
PRIMARY KEY ( compo_id_componente , compo_cod_corpo ),
CONSTRAINT composicao_tb_componente
FOREIGN KEY ( compo_id_componente )
REFERENCES tb_componente ( id_componente ),
CONSTRAINT composicao_tb_corpo
FOREIGN KEY ( compo_cod_corpo )
REFERENCES tb_corpo ( cod_corpo ));
-- -----------------------------------------------------
-- Table tb_estrelaSist
-- -----------------------------------------------------
CREATE TABLE tb_estrPeriferica (
id_estrPeriferica INT NOT NULL auto_increment,
estrPeriferica_id_estrela INT NOT NULL,
estrPeriferica_id_sistema INT NOT NULL,
PRIMARY KEY ( id_estrPeriferica ),
FOREIGN KEY (estrPeriferica_id_estrela)
REFERENCES db_sistemasolar.tb_estrela (id_estrela),
FOREIGN KEY ( estrPeriferica_id_sistema )
REFERENCES db_sistemasolar.tb_sistema (id_sistema));