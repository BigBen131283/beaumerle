-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema couteauxbm
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema couteauxbm
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `couteauxbm` DEFAULT CHARACTER SET utf8 ;
USE `couteauxbm` ;

-- -----------------------------------------------------
-- Table `couteauxbm`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `password` VARCHAR(128) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `role` JSON NOT NULL,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC),
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`category` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`mechanism`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`mechanism` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`knifes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`knifes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `description` LONGTEXT NOT NULL,
  `stock` INT NOT NULL,
  `wheight` INT NOT NULL,
  `length` INT NOT NULL,
  `close_length` VARCHAR(45) NOT NULL,
  `cuttingedge_length` VARCHAR(45) NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `price` DECIMAL(9999,99) NOT NULL,
  `category_idcategory` INT NOT NULL,
  `mechanism_id` INT NOT NULL,
  `users_id` INT NOT NULL,
  PRIMARY KEY (`id`, `category_idcategory`, `mechanism_id`, `users_id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `fk_knifes_category1_idx` (`category_idcategory` ASC),
  INDEX `fk_knifes_mechanism1_idx` (`mechanism_id` ASC),
  INDEX `fk_knifes_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_knifes_category1`
    FOREIGN KEY (`category_idcategory`)
    REFERENCES `couteauxbm`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_knifes_mechanism1`
    FOREIGN KEY (`mechanism_id`)
    REFERENCES `couteauxbm`.`mechanism` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_knifes_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `couteauxbm`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`newsletter`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`newsletter` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(128) NOT NULL,
  `knife` TINYINT(1) NOT NULL,
  `events` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`metals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`metals` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `metal_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`handle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`handle` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `handle` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `handle_UNIQUE` (`handle` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`knifes_has_metals`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`knifes_has_metals` (
  `knifes_id` INT NOT NULL,
  `metals_id` INT NOT NULL,
  PRIMARY KEY (`knifes_id`, `metals_id`),
  INDEX `fk_knifes_has_metals_metals1_idx` (`metals_id` ASC),
  INDEX `fk_knifes_has_metals_knifes1_idx` (`knifes_id` ASC),
  CONSTRAINT `fk_knifes_has_metals_knifes1`
    FOREIGN KEY (`knifes_id`)
    REFERENCES `couteauxbm`.`knifes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_knifes_has_metals_metals1`
    FOREIGN KEY (`metals_id`)
    REFERENCES `couteauxbm`.`metals` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`knifes_has_handle`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`knifes_has_handle` (
  `knifes_id` INT NOT NULL,
  `handle_id` INT NOT NULL,
  PRIMARY KEY (`knifes_id`, `handle_id`),
  INDEX `fk_knifes_has_handle_handle1_idx` (`handle_id` ASC),
  INDEX `fk_knifes_has_handle_knifes1_idx` (`knifes_id` ASC),
  CONSTRAINT `fk_knifes_has_handle_knifes1`
    FOREIGN KEY (`knifes_id`)
    REFERENCES `couteauxbm`.`knifes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_knifes_has_handle_handle1`
    FOREIGN KEY (`handle_id`)
    REFERENCES `couteauxbm`.`handle` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`events`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  `date` DATE NOT NULL,
  `address` VARCHAR(256) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`images`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`images` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `filename` VARCHAR(256) NOT NULL,
  `default` TINYINT NOT NULL,
  `knifes_id` INT NOT NULL,
  PRIMARY KEY (`id`, `knifes_id`),
  UNIQUE INDEX `path_UNIQUE` (`filename` ASC),
  INDEX `fk_images_knifes1_idx` (`knifes_id` ASC),
  CONSTRAINT `fk_images_knifes1`
    FOREIGN KEY (`knifes_id`)
    REFERENCES `couteauxbm`.`knifes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`accessories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`accessories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`knifes_has_accessories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`knifes_has_accessories` (
  `knifes_id` INT NOT NULL,
  `accessories_id` INT NOT NULL,
  PRIMARY KEY (`knifes_id`, `accessories_id`),
  INDEX `fk_knifes_has_accessories_accessories1_idx` (`accessories_id` ASC),
  INDEX `fk_knifes_has_accessories_knifes1_idx` (`knifes_id` ASC),
  CONSTRAINT `fk_knifes_has_accessories_knifes1`
    FOREIGN KEY (`knifes_id`)
    REFERENCES `couteauxbm`.`knifes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_knifes_has_accessories_accessories1`
    FOREIGN KEY (`accessories_id`)
    REFERENCES `couteauxbm`.`accessories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`comments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `content` VARCHAR(255) NOT NULL,
  `knifes_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `status` TINYINT NOT NULL,
  PRIMARY KEY (`id`, `knifes_id`),
  INDEX `fk_comments_knifes1_idx` (`knifes_id` ASC),
  CONSTRAINT `fk_comments_knifes1`
    FOREIGN KEY (`knifes_id`)
    REFERENCES `couteauxbm`.`knifes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `couteauxbm`.`users_has_knifes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `couteauxbm`.`users_has_knifes` (
  `users_id` INT NOT NULL,
  `knifes_id` INT NOT NULL,
  `created_at` DATETIME NOT NULL,
  `status` INT NULL,
  PRIMARY KEY (`users_id`, `knifes_id`),
  INDEX `fk_users_has_knifes_knifes1_idx` (`knifes_id` ASC),
  INDEX `fk_users_has_knifes_users1_idx` (`users_id` ASC),
  CONSTRAINT `fk_users_has_knifes_users1`
    FOREIGN KEY (`users_id`)
    REFERENCES `couteauxbm`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_users_has_knifes_knifes1`
    FOREIGN KEY (`knifes_id`)
    REFERENCES `couteauxbm`.`knifes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;