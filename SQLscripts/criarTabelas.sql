SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

DROP SCHEMA IF EXISTS `bd_rede_social` ;
CREATE SCHEMA IF NOT EXISTS `bd_rede_social` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `bd_rede_social` ;

-- -----------------------------------------------------
-- Table `Usuarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Usuarios` ;

CREATE  TABLE IF NOT EXISTS `Usuarios` (
  `idUsuario` INT NOT NULL ,
  `usuario` VARCHAR(100) NOT NULL ,
  `email` VARCHAR(100) NOT NULL ,
  `nascimento` DATE NOT NULL ,
  `foto` BLOB NOT NULL ,
  PRIMARY KEY (`idUsuario`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Postagens`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Postagens` ;

CREATE  TABLE IF NOT EXISTS `Postagens` (
  `idPostagens` INT NOT NULL ,
  `conteudo` BLOB NOT NULL ,
  `criacao` DATETIME NOT NULL ,
  `tipo` VARCHAR(30) NOT NULL ,
  `Usuarios_idUsuario` INT NOT NULL ,
  PRIMARY KEY (`idPostagens`) ,
  INDEX `fk_Postagens_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  CONSTRAINT `fk_Postagens_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Comentarios`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Comentarios` ;

CREATE  TABLE IF NOT EXISTS `Comentarios` (
  `idComentarios` INT NOT NULL ,
  `texto` VARCHAR(100) NOT NULL ,
  `Usuarios_idUsuario` INT NOT NULL ,
  `Postagens_idPostagens` INT NULL ,
  `Comentarios_idComentarios` INT NULL ,
  PRIMARY KEY (`idComentarios`) ,
  INDEX `fk_Comentarios_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  INDEX `fk_Comentarios_Postagens1_idx` (`Postagens_idPostagens` ASC) ,
  INDEX `fk_Comentarios_Comentarios1_idx` (`Comentarios_idComentarios` ASC) ,
  CONSTRAINT `fk_Comentarios_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentarios_Postagens1`
    FOREIGN KEY (`Postagens_idPostagens` )
    REFERENCES `Postagens` (`idPostagens` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Comentarios_Comentarios1`
    FOREIGN KEY (`Comentarios_idComentarios` )
    REFERENCES `Comentarios` (`idComentarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Conexao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Conexao` ;

CREATE  TABLE IF NOT EXISTS `Conexao` (
  `idUserSeguido` INT NOT NULL ,
  `idUserSeguidor` INT NOT NULL ,
  PRIMARY KEY (`idUserSeguido`, `idUserSeguidor`) ,
  INDEX `fk_Usuario_has_Usuario_Usuario1_idx` (`idUserSeguidor` ASC) ,
  INDEX `fk_Usuario_has_Usuario_Usuario_idx` (`idUserSeguido` ASC) ,
  CONSTRAINT `fk_Usuario_has_Usuario_Usuario`
    FOREIGN KEY (`idUserSeguido` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuario_has_Usuario_Usuario1`
    FOREIGN KEY (`idUserSeguidor` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Avaliacoes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Avaliacoes` ;

CREATE  TABLE IF NOT EXISTS `Avaliacoes` (
  `idAvaliacoes` INT NOT NULL ,
  `Usuarios_idUsuario` INT NOT NULL ,
  `Comentarios_idComentarios` INT NULL ,
  `Postagens_idPostagens` INT NULL ,
  `status` TINYINT(1) NOT NULL ,
  INDEX `fk_Postagens_has_Usuarios_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  INDEX `fk_AvaliacaoPostagens_Comentarios1_idx` (`Comentarios_idComentarios` ASC) ,
  INDEX `fk_Avaliacoes_Postagens1_idx` (`Postagens_idPostagens` ASC) ,
  PRIMARY KEY (`idAvaliacoes`) ,
  CONSTRAINT `fk_Postagens_has_Usuarios_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AvaliacaoPostagens_Comentarios1`
    FOREIGN KEY (`Comentarios_idComentarios` )
    REFERENCES `Comentarios` (`idComentarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Avaliacoes_Postagens1`
    FOREIGN KEY (`Postagens_idPostagens` )
    REFERENCES `Postagens` (`idPostagens` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Notificacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Notificacao` ;

CREATE  TABLE IF NOT EXISTS `Notificacao` (
  `idNotificacao` INT NOT NULL ,
  `timestamp` DATETIME NOT NULL ,
  `origem` VARCHAR(11) NOT NULL ,
  `Usuarios_idUsuario` INT NOT NULL ,
  `Comentarios_idComentarios` INT NULL ,
  `Postagens_idPostagens` INT NULL ,
  PRIMARY KEY (`idNotificacao`) ,
  INDEX `fk_Notificacao_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  INDEX `fk_Notificacao_Comentarios1_idx` (`Comentarios_idComentarios` ASC) ,
  INDEX `fk_Notificacao_Postagens1_idx` (`Postagens_idPostagens` ASC) ,
  CONSTRAINT `fk_Notificacao_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notificacao_Comentarios1`
    FOREIGN KEY (`Comentarios_idComentarios` )
    REFERENCES `Comentarios` (`idComentarios` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Notificacao_Postagens1`
    FOREIGN KEY (`Postagens_idPostagens` )
    REFERENCES `Postagens` (`idPostagens` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Grupo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Grupo` ;

CREATE  TABLE IF NOT EXISTS `Grupo` (
  `idGrupo` INT NOT NULL ,
  `nome` VARCHAR(100) NOT NULL ,
  `descricao` VARCHAR(200) NOT NULL ,
  `criacao` DATE NOT NULL ,
  PRIMARY KEY (`idGrupo`) ,
  UNIQUE INDEX `nome_UNIQUE` (`nome` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Inscric`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Inscric` ;

CREATE  TABLE IF NOT EXISTS `Inscric` (
  `Usuarios_idUsuario` INT NOT NULL ,
  `Grupo_idGrupo` INT NOT NULL ,
  `funcao` VARCHAR(15) NOT NULL ,
  PRIMARY KEY (`Usuarios_idUsuario`, `Grupo_idGrupo`) ,
  INDEX `fk_Usuarios_has_Grupo_Grupo1_idx` (`Grupo_idGrupo` ASC) ,
  INDEX `fk_Usuarios_has_Grupo_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  CONSTRAINT `fk_Usuarios_has_Grupo_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_has_Grupo_Grupo1`
    FOREIGN KEY (`Grupo_idGrupo` )
    REFERENCES `Grupo` (`idGrupo` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Mensagens_Privadas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Mensagens_Privadas` ;

CREATE  TABLE IF NOT EXISTS `Mensagens_Privadas` (
  `idMensagens_Privadas` INT NOT NULL ,
  `idRemetende` INT NOT NULL ,
  `idDestinatario` INT NOT NULL ,
  `status` VARCHAR(8) NOT NULL ,
  `timestamp` DATETIME NOT NULL ,
  PRIMARY KEY (`idMensagens_Privadas`) ,
  INDEX `fk_Mensagens_Privadas_Usuarios1_idx` (`idRemetende` ASC) ,
  INDEX `fk_Mensagens_Privadas_Usuarios2_idx` (`idDestinatario` ASC) ,
  CONSTRAINT `fk_Mensagens_Privadas_Usuarios1`
    FOREIGN KEY (`idRemetende` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mensagens_Privadas_Usuarios2`
    FOREIGN KEY (`idDestinatario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Tags`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Tags` ;

CREATE  TABLE IF NOT EXISTS `Tags` (
  `idTags` INT NOT NULL ,
  `nome` VARCHAR(50) NOT NULL ,
  PRIMARY KEY (`idTags`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Interesses`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Interesses` ;

CREATE  TABLE IF NOT EXISTS `Interesses` (
  `Tags_idTags` INT NOT NULL ,
  `Usuarios_idUsuario` INT NOT NULL ,
  PRIMARY KEY (`Tags_idTags`, `Usuarios_idUsuario`) ,
  INDEX `fk_Tags_has_Usuarios_Usuarios1_idx` (`Usuarios_idUsuario` ASC) ,
  INDEX `fk_Tags_has_Usuarios_Tags1_idx` (`Tags_idTags` ASC) ,
  CONSTRAINT `fk_Tags_has_Usuarios_Tags1`
    FOREIGN KEY (`Tags_idTags` )
    REFERENCES `Tags` (`idTags` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Tags_has_Usuarios_Usuarios1`
    FOREIGN KEY (`Usuarios_idUsuario` )
    REFERENCES `Usuarios` (`idUsuario` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `bd_rede_social` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
