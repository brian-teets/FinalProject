-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema neighboringworldsdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `neighboringworldsdb` ;

-- -----------------------------------------------------
-- Schema neighboringworldsdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `neighboringworldsdb` DEFAULT CHARACTER SET utf8 ;
USE `neighboringworldsdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `address1` VARCHAR(45) NOT NULL,
  `address2` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(20) NOT NULL,
  `country` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL,
  `last_name` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(200) NULL,
  `date_created` DATETIME NULL,
  `enabled` TINYINT NOT NULL,
  `active` TINYINT NULL,
  `role` VARCHAR(45) NULL,
  `profile_img_url` VARCHAR(2000) NULL,
  `banner_img_url` VARCHAR(2000) NULL,
  `biography` TEXT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_address1_idx` (`address_id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  CONSTRAINT `fk_user_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `an_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `an_event` ;

CREATE TABLE IF NOT EXISTS `an_event` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `event_date` DATE NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `capacity` VARCHAR(45) NOT NULL,
  `purpose` VARCHAR(45) NULL,
  `description` TEXT NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NULL,
  `cover_img_url` VARCHAR(45) NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_an_event_address1_idx` (`address_id` ASC),
  CONSTRAINT `fk_an_event_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `user_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_comment` ;

CREATE TABLE IF NOT EXISTS `user_comment` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(200) NULL,
  `content` TEXT NULL,
  `comment_date` DATETIME NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_comment_user1_idx` (`user_id` ASC),
  CONSTRAINT `fk_user_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_tag`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_tag` ;

CREATE TABLE IF NOT EXISTS `event_tag` (
  `id` INT NOT NULL,
  `keyword` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `media`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `media` ;

CREATE TABLE IF NOT EXISTS `media` (
  `id` INT NOT NULL,
  `url` VARCHAR(2000) NULL,
  `an_event_id` INT NOT NULL,
  `user_comment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_media_an_event1_idx` (`an_event_id` ASC),
  INDEX `fk_media_user_comment1_idx` (`user_comment_id` ASC),
  CONSTRAINT `fk_media_an_event1`
    FOREIGN KEY (`an_event_id`)
    REFERENCES `an_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_media_user_comment1`
    FOREIGN KEY (`user_comment_id`)
    REFERENCES `user_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `attendee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `attendee` ;

CREATE TABLE IF NOT EXISTS `attendee` (
  `an_event_id` INT NOT NULL,
  `user_id` INT NOT NULL,
  PRIMARY KEY (`an_event_id`, `user_id`),
  INDEX `fk_an_event_has_user_user1_idx` (`user_id` ASC),
  INDEX `fk_an_event_has_user_an_event_idx` (`an_event_id` ASC),
  CONSTRAINT `fk_an_event_has_user_an_event`
    FOREIGN KEY (`an_event_id`)
    REFERENCES `an_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_an_event_has_user_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `review` ;

CREATE TABLE IF NOT EXISTS `review` (
  `id` INT NOT NULL,
  `rating` INT NULL,
  `review` VARCHAR(500) NULL,
  `an_event_id` INT NOT NULL,
  `attendee_an_event_id` INT NOT NULL,
  `attendee_user_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_review_an_event1_idx` (`an_event_id` ASC),
  INDEX `fk_review_attendee1_idx` (`attendee_an_event_id` ASC, `attendee_user_id` ASC),
  CONSTRAINT `fk_review_an_event1`
    FOREIGN KEY (`an_event_id`)
    REFERENCES `an_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_attendee1`
    FOREIGN KEY (`attendee_an_event_id` , `attendee_user_id`)
    REFERENCES `attendee` (`an_event_id` , `user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `event_tag_has_an_event`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `event_tag_has_an_event` ;

CREATE TABLE IF NOT EXISTS `event_tag_has_an_event` (
  `event_tag_id` INT NOT NULL,
  `an_event_id` INT NOT NULL,
  PRIMARY KEY (`event_tag_id`, `an_event_id`),
  INDEX `fk_event_tag_has_an_event_an_event1_idx` (`an_event_id` ASC),
  INDEX `fk_event_tag_has_an_event_event_tag1_idx` (`event_tag_id` ASC),
  CONSTRAINT `fk_event_tag_has_an_event_event_tag1`
    FOREIGN KEY (`event_tag_id`)
    REFERENCES `event_tag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_tag_has_an_event_an_event1`
    FOREIGN KEY (`an_event_id`)
    REFERENCES `an_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE = '';
DROP USER IF EXISTS user@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'user'@'localhost' IDENTIFIED BY 'user';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'user'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (1, '11111', '11', 'Denver', 'CO', '80204', 'US');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `active`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (1, 'Charli', 'Verderame', 'charli@neighboringworlds.com', '000-000-0000', 'cverderame', 'cverderame', NULL, 1, NULL, 'ROLE_ADMIN', NULL, NULL, NULL, 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `active`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (2, 'Paul', 'Chaffin', 'paul@neighboringworlds.com', '000-000-0000', 'pchaffin', 'pchaffin', NULL, 1, NULL, 'ROLE_ADMIN', NULL, NULL, NULL, 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `active`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (3, 'Erich', 'Schindler', 'arich@neighboringworlds.com', '000-000-0000', 'eschindler', 'eschindler', NULL, 1, NULL, 'ROLE_ADMIN', NULL, NULL, NULL, 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `active`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (4, 'Brian', 'Teets', 'brain@neighboringworlds.com', '000-000-0000', 'bteets', 'bteets', NULL, 1, NULL, 'ROLE_ADMIN', NULL, NULL, NULL, 1);

COMMIT;

