-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema system_pro
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema system_pro
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `system_pro` DEFAULT CHARACTER SET utf8 ;
USE `system_pro` ;

-- -----------------------------------------------------
-- Table `system_pro`.`Godina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Godina` (
  `id_godine` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `godina` INT NOT NULL,
  `cena` INT NOT NULL,
  `cena_za_talentovane` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_godine`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Grupa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Grupa` (
  `id_grupe` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_godine` INT UNSIGNED NOT NULL,
  `obelezje` CHAR(1) NOT NULL,
  PRIMARY KEY (`id_grupe`),
  INDEX `fk_Grupa_Godina1_idx` (`id_godine` ASC),
  CONSTRAINT `fk_Grupa_Godina1`
    FOREIGN KEY (`id_godine`)
    REFERENCES `system_pro`.`Godina` (`id_godine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Nastavnik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Nastavnik` (
  `id_nastavnika` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `korisnicko_ime` VARCHAR(45) NOT NULL,
  `sifra` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id_nastavnika`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Ucenik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Ucenik` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `id_grupe` INT UNSIGNED NOT NULL,
  `korisnicko_ime` VARCHAR(45) NOT NULL,
  `sifra` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id_ucenika`),
  INDEX `fk_Ucenik_Grupa1_idx` (`id_grupe` ASC),
  CONSTRAINT `fk_Ucenik_Grupa1`
    FOREIGN KEY (`id_grupe`)
    REFERENCES `system_pro`.`Grupa` (`id_grupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Roditelj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Roditelj` (
  `id_roditelja` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `ime` VARCHAR(45) NOT NULL,
  `prezime` VARCHAR(45) NOT NULL,
  `korisnicko_ime` VARCHAR(45) NOT NULL,
  `sifra` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`id_roditelja`),
  UNIQUE INDEX `korisnicko_ime_UNIQUE` (`korisnicko_ime` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Predaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Predaje` (
  `id_grupe` INT UNSIGNED NOT NULL,
  `id_nastavnika` INT UNSIGNED NOT NULL,
  `broj_ucionice` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_grupe`, `id_nastavnika`),
  INDEX `fk_Predaje_Grupa1_idx` (`id_grupe` ASC),
  INDEX `fk_Predaje_Nastavnik1_idx` (`id_nastavnika` ASC),
  CONSTRAINT `fk_Predaje_Grupa1`
    FOREIGN KEY (`id_grupe`)
    REFERENCES `system_pro`.`Grupa` (`id_grupe`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Predaje_Nastavnik1`
    FOREIGN KEY (`id_nastavnika`)
    REFERENCES `system_pro`.`Nastavnik` (`id_nastavnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Roditelj_Ucenik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Roditelj_Ucenik` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `id_roditelja` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`, `id_roditelja`),
  INDEX `fk_Ucenik_has_Roditelj_Roditelj1_idx` (`id_roditelja` ASC),
  INDEX `fk_Ucenik_has_Roditelj_Ucenik1_idx` (`id_ucenika` ASC),
  CONSTRAINT `fk_Ucenik_has_Roditelj_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `system_pro`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ucenik_has_Roditelj_Roditelj1`
    FOREIGN KEY (`id_roditelja`)
    REFERENCES `system_pro`.`Roditelj` (`id_roditelja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Rata`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Rata` (
  `id_rate` INT UNSIGNED NOT NULL,
  `iznos` INT UNSIGNED NOT NULL,
  `id_godine` INT UNSIGNED NOT NULL,
  `id_ucenika` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_rate`),
  INDEX `fk_Rata_Godina1_idx` (`id_godine` ASC),
  INDEX `fk_Rata_Ucenik1_idx` (`id_ucenika` ASC),
  CONSTRAINT `fk_Rata_Godina1`
    FOREIGN KEY (`id_godine`)
    REFERENCES `system_pro`.`Godina` (`id_godine`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Rata_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `system_pro`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Uplatnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Uplatnica` (
  `id_rate` INT UNSIGNED NOT NULL,
  `datum_uplate` DATE NOT NULL,
  `id_roditelja` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_rate`),
  INDEX `fk_Uplatnica_Roditelj1_idx` (`id_roditelja` ASC),
  CONSTRAINT `fk_table1_Rata1`
    FOREIGN KEY (`id_rate`)
    REFERENCES `system_pro`.`Rata` (`id_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Uplatnica_Roditelj1`
    FOREIGN KEY (`id_roditelja`)
    REFERENCES `system_pro`.`Roditelj` (`id_roditelja`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Projekat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Projekat` (
  `id_projekta` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_nastavnika` INT UNSIGNED NOT NULL,
  `naziv` VARCHAR(45) NOT NULL,
  `opis` TINYTEXT NOT NULL,
  `url` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_projekta`),
  INDEX `fk_Projekat_Nastavnik1_idx` (`id_nastavnika` ASC),
  CONSTRAINT `fk_Projekat_Nastavnik1`
    FOREIGN KEY (`id_nastavnika`)
    REFERENCES `system_pro`.`Nastavnik` (`id_nastavnika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Radi_Na_Projektu`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Radi_Na_Projektu` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `id_projekta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`, `id_projekta`),
  INDEX `fk_radi_na_projektu_Projekat1_idx` (`id_projekta` ASC),
  CONSTRAINT `fk_radi_na_projektu_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `system_pro`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_radi_na_projektu_Projekat1`
    FOREIGN KEY (`id_projekta`)
    REFERENCES `system_pro`.`Projekat` (`id_projekta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Stipendija`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Stipendija` (
  `id_ucenika` INT UNSIGNED NOT NULL,
  `broj_poena_na_testu` TINYINT(1) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_ucenika`),
  CONSTRAINT `fk_Stipendija_Ucenik1`
    FOREIGN KEY (`id_ucenika`)
    REFERENCES `system_pro`.`Ucenik` (`id_ucenika`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `system_pro`.`Povracaj`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `system_pro`.`Povracaj` (
  `id_rate` INT UNSIGNED NOT NULL,
  `iznos` INT NOT NULL,
  PRIMARY KEY (`id_rate`),
  CONSTRAINT `fk_Povracaj_Uplatnica1`
    FOREIGN KEY (`id_rate`)
    REFERENCES `system_pro`.`Uplatnica` (`id_rate`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
