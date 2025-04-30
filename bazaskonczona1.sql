-- Poprawiony skrypt MySQL
-- Model: Naprawa Systemu
-- Data: 2025-04-30
 
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
 
-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8;
USE `mydb`;
 
-- -----------------------------------------------------
-- Table `Pracownik`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pracownik` (
  `idAdmin` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(50) NOT NULL,
  `nazwisko` VARCHAR(50) NOT NULL,
  `telefon` VARCHAR(20) NOT NULL,
  `stawka` DECIMAL(10,2) NOT NULL,
  `typPracownika` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idAdmin`)
);
 
-- -----------------------------------------------------
-- Table `Zgloszenie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Zgloszenie` (
  `idZgloszenia` INT NOT NULL AUTO_INCREMENT,
  `opisZdarzenia` TEXT DEFAULT NULL,
  `status` VARCHAR(50) NOT NULL,
  `dataUtworzenia` DATE NOT NULL,
  `dataZakonczenia` DATE DEFAULT NULL,
  `idAdmin` INT NOT NULL,
  PRIMARY KEY (`idZgloszenia`),
  FOREIGN KEY (`idAdmin`) REFERENCES `Pracownik` (`idAdmin`)
    ON DELETE CASCADE ON UPDATE CASCADE
);
 
-- -----------------------------------------------------
-- Table `Klient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Klient` (
  `idKlient` INT NOT NULL AUTO_INCREMENT,
  `imie` VARCHAR(50) NOT NULL,
  `nazwisko` VARCHAR(50) NOT NULL,
  `email` VARCHAR(100) DEFAULT NULL,
  `telefon` VARCHAR(20) NOT NULL,
  `idZgloszenia` INT NOT NULL,
  PRIMARY KEY (`idKlient`),
  FOREIGN KEY (`idZgloszenia`) REFERENCES `Zgloszenie` (`idZgloszenia`)
    ON DELETE CASCADE ON UPDATE CASCADE
);
 
-- -----------------------------------------------------
-- Table `ZlecenieNaprawy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ZlecenieNaprawy` (
  `idZlecenie` INT NOT NULL AUTO_INCREMENT,
  `koszt` DECIMAL(10,2) DEFAULT NULL,
  `status` VARCHAR(50) NOT NULL,
  `idAdmin` INT NOT NULL,
  `idTechnik` INT DEFAULT NULL,
  PRIMARY KEY (`idZlecenie`),
  FOREIGN KEY (`idAdmin`) REFERENCES `Pracownik` (`idAdmin`)
    ON DELETE CASCADE ON UPDATE CASCADE
);
 
-- -----------------------------------------------------
-- Table `Faktura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Faktura` (
  `idFaktura` INT NOT NULL AUTO_INCREMENT,
  `idZlecenie` INT NOT NULL,
  `kwota` DECIMAL(10,2) DEFAULT NULL,
  `dataWystawienia` DATE DEFAULT NULL,
  PRIMARY KEY (`idFaktura`),
  FOREIGN KEY (`idZlecenie`) REFERENCES `ZlecenieNaprawy` (`idZlecenie`)
    ON DELETE CASCADE ON UPDATE CASCADE
);
 
-- -----------------------------------------------------
-- Table `System1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `System1` (
  `idSystem` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idSystem`)
);
 
-- -----------------------------------------------------
-- Table `Powiadomienia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Powiadomienia` (
  `idPowiadomienia` INT NOT NULL AUTO_INCREMENT,
  `idKlient` INT NOT NULL,
  `idZlecenie` INT NOT NULL,
  `idSystem` INT NOT NULL,
  PRIMARY KEY (`idPowiadomienia`),
  FOREIGN KEY (`idKlient`) REFERENCES `Klient` (`idKlient`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`idZlecenie`) REFERENCES `ZlecenieNaprawy` (`idZlecenie`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (`idSystem`) REFERENCES `System1` (`idSystem`)
    ON DELETE CASCADE ON UPDATE CASCADE
);
 
-- -----------------------------------------------------
-- Table `Magazyn`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Magazyn` (
  `idPrzedmiotu` INT NOT NULL AUTO_INCREMENT,
  `nazwa` VARCHAR(100) NOT NULL,
  `ilosc` INT NOT NULL,
  `idZlecenie` INT DEFAULT NULL,
  PRIMARY KEY (`idPrzedmiotu`),
  FOREIGN KEY (`idZlecenie`) REFERENCES `ZlecenieNaprawy` (`idZlecenie`)
    ON DELETE SET NULL ON UPDATE CASCADE
);
 
-- Przywracanie oryginalnych ustawień
SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;