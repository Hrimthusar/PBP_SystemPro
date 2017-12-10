-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Godina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Godina` (
  `id_godine` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `godina` INT NOT NULL,
  `cena` INT NOT NULL,
  `cena_za_talentovane` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_godine`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Grupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Grupa` (
  `id_grupe` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_godine` INT UNSIGNED NOT NULL,
  `obelezje` CHAR(1) NOT NULL,
  PRIMARY KEY (`id_grupe`),
  INDEX `fk_Grupa_Godina1_idx` (`id_godine` ASC),
  CONSTRAINT `fk_Grupa_Godina1`
    FOREIGN KEY (`id_godine`)
    REFERENCES `mydb`.`Godina` (`id_godine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Nastavnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Nastavnik` (
  `id_nastavnika` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_nastavnika`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ucenik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Ucenik` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `id_grupe` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`),
  INDEX `fk_Ucenik_Grupa1_idx` (`id_grupe` ASC),
  CONSTRAINT `fk_Ucenik_Grupa1`
    FOREIGN KEY (`id_grupe`)
    REFERENCES `mydb`.`Grupa` (`id_grupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roditelj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roditelj` (
  `id_roditelja` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_roditelja`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Predaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Predaje` (
  `id_grupe` INT UNSIGNED NOT NULL,
  `id_nastavnika` INT UNSIGNED NOT NULL,
  `broj_ucionice` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_grupe`, `id_nastavnika`),
  INDEX `fk_Predaje_Grupa1_idx` (`id_grupe` ASC),
  INDEX `fk_Predaje_Nastavnik1_idx` (`id_nastavnika` ASC),
  CONSTRAINT `fk_Predaje_Grupa1`
    FOREIGN KEY (`id_grupe`)
    REFERENCES `mydb`.`Grupa` (`id_grupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Predaje_Nastavnik1`
    FOREIGN KEY (`id_nastavnika`)
    REFERENCES `mydb`.`Nastavnik` (`id_nastavnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Roditelj_Ucenik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Roditelj_Ucenik` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `id_roditelja` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`, `id_roditelja`),
  INDEX `fk_Ucenik_has_Roditelj_Roditelj1_idx` (`id_roditelja` ASC),
  INDEX `fk_Ucenik_has_Roditelj_Ucenik1_idx` (`id_ucenika` ASC),
  CONSTRAINT `fk_Ucenik_has_Roditelj_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `mydb`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ucenik_has_Roditelj_Roditelj1`
    FOREIGN KEY (`id_roditelja`)
    REFERENCES `mydb`.`Roditelj` (`id_roditelja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rata` (
  `id_rate` INT UNSIGNED NOT NULL,
  `cena` INT UNSIGNED NOT NULL,
  `id_godine` INT UNSIGNED NOT NULL,
  `id_ucenika` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_rate`),
  INDEX `fk_Rata_Godina1_idx` (`id_godine` ASC),
  INDEX `fk_Rata_Ucenik1_idx` (`id_ucenika` ASC),
  CONSTRAINT `fk_Rata_Godina1`
    FOREIGN KEY (`id_godine`)
    REFERENCES `mydb`.`Godina` (`id_godine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rata_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `mydb`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Uplatnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Uplatnica` (
  `id_rate` INT UNSIGNED NOT NULL,
  `datum_uplate` DATE NOT NULL,
  `id_roditelja` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_rate`),
  INDEX `fk_Uplatnica_Roditelj1_idx` (`id_roditelja` ASC),
  CONSTRAINT `fk_table1_Rata1`
    FOREIGN KEY (`id_rate`)
    REFERENCES `mydb`.`Rata` (`id_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Uplatnica_Roditelj1`
    FOREIGN KEY (`id_roditelja`)
    REFERENCES `mydb`.`Roditelj` (`id_roditelja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Projekat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Projekat` (
  `id_projekta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_nastavnika` INT UNSIGNED NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `opis` TINYTEXT NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_projekta`),
  INDEX `fk_Projekat_Nastavnik1_idx` (`id_nastavnika` ASC),
  CONSTRAINT `fk_Projekat_Nastavnik1`
    FOREIGN KEY (`id_nastavnika`)
    REFERENCES `mydb`.`Nastavnik` (`id_nastavnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Radi_Na_Projektu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Radi_Na_Projektu` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `id_projekta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`, `id_projekta`),
  INDEX `fk_radi_na_projektu_Projekat1_idx` (`id_projekta` ASC),
  CONSTRAINT `fk_radi_na_projektu_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `mydb`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_radi_na_projektu_Projekat1`
    FOREIGN KEY (`id_projekta`)
    REFERENCES `mydb`.`Projekat` (`id_projekta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Stipendija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Stipendija` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `broj_poena_na_testu` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`),
  CONSTRAINT `fk_Stipendija_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `mydb`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
