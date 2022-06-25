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
  `address1` VARCHAR(100) NOT NULL,
  `address2` VARCHAR(100) NULL,
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
  `role` VARCHAR(45) NULL,
  `profile_img_url` VARCHAR(2000) NULL,
  `banner_img_url` VARCHAR(2000) NULL,
  `biography` TEXT NULL,
  `address_id` INT NULL,
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
  `title` VARCHAR(200) NOT NULL,
  `capacity` INT NOT NULL,
  `purpose` VARCHAR(2000) NULL,
  `description` TEXT NOT NULL,
  `start_time` TIME NOT NULL,
  `end_time` TIME NULL,
  `cover_img_url` VARCHAR(2000) NULL,
  `address_id` INT NOT NULL,
  `active` TINYINT NOT NULL,
  `host_id` INT NOT NULL,
  `created_date` DATETIME NULL,
  `last_updated` DATETIME NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_an_event_address1_idx` (`address_id` ASC),
  INDEX `fk_an_event_user1_idx` (`host_id` ASC),
  CONSTRAINT `fk_an_event_address1`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_an_event_user1`
    FOREIGN KEY (`host_id`)
    REFERENCES `user` (`id`)
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
  `an_event_id` INT NOT NULL,
  `in_reply_to_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_comment_user1_idx` (`user_id` ASC),
  INDEX `fk_user_comment_an_event1_idx` (`an_event_id` ASC),
  INDEX `fk_user_comment_user_comment1_idx` (`in_reply_to_id` ASC),
  CONSTRAINT `fk_user_comment_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_comment_an_event1`
    FOREIGN KEY (`an_event_id`)
    REFERENCES `an_event` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_comment_user_comment1`
    FOREIGN KEY (`in_reply_to_id`)
    REFERENCES `user_comment` (`id`)
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
  `id` INT NOT NULL AUTO_INCREMENT,
  `url` VARCHAR(2000) NULL,
  `user_comment_id` INT NOT NULL,
  `caption` VARCHAR(200) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_media_user_comment1_idx` (`user_comment_id` ASC),
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
  `rating` INT NULL,
  `review_content` VARCHAR(500) NULL,
  `attendee_an_event_id` INT NOT NULL,
  `attendee_user_id` INT NOT NULL,
  `review_date` DATETIME NULL,
  PRIMARY KEY (`attendee_an_event_id`, `attendee_user_id`),
  INDEX `fk_review_attendee1_idx` (`attendee_an_event_id` ASC, `attendee_user_id` ASC),
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
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (1, '1111 Osage Street', '', 'Denver', 'CO', '80204', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (2, '4 Pennsylvania Plaza', '', 'New York', 'NY', '10001', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (3, '3400 W Girard Ave', '', 'Philadelphia', 'PA', '19104', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (4, '6399 S Santa Fe Dr', '', 'Littleton', 'CO', '80120', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (5, '2323 S Lincoln St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (6, '2365 S Sherman St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (7, '2370 S Lincoln St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (8, '2391 S Sherman St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (9, '2401 S Lincoln St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (10, '2418 S Lincoln St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (11, '2425 S Sherman St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (12, '2462 S Lincoln St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (13, '2526 S Grant St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (14, '2525 S Logan St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (15, '2560 S Grant St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (16, '2531 S Pennsylvania St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (17, '2511 S Pearl St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (18, '2511 S Washington St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (19, '2535 S Washington St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (20, '1018 S High St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (21, '996 S Williams St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (22, '1005 S High St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (23, '1037 S Williams St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (24, '1112 S Gilpin St', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (25, '6150 W 38th Ave', '', 'Wheat Ridge', 'CO', '80033', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (26, '1625 Perry St', '', 'Denver', 'CO', '80204', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (27, '145 N Broadway', '', 'Denver', 'CO', '80203', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (28, '853 E Ohio Ave', '', 'Denver', 'CO', '80209', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (29, '1298 S Broadway', '', 'Denver', 'CO', '80210', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (30, '1 Washington Square', '', 'San Jose', 'CA', '95129', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (31, '396 S 1st Street', '', 'San Jose', 'CA', '95113', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (32, '118 Paseo de San Antioniuo', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (33, '315 S First Street', '', 'San Jose', 'CA', '95113', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (34, '140 E San Carlos Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (35, '62 S Second Street', '', 'San Jose', 'CA', '95113', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (36, '87 N San Pedro Street', '', 'San Jose ', 'CA', '95110', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (37, '9 N Market Street', '', 'San Jose', 'CA', '95113', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (38, '72 N Almadan Ave', '', 'San Jose', 'CA', '95110', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (39, '173 W Santa Clara Street', '', 'San Jose', 'CA', '95110', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (40, '151 W Santa Clara Street', '', 'San Jose', 'CA', '95113', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (41, '131 W Santa Clara Street', '', 'San Jose', 'CA', '95113', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (42, '197 Jackson Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (43, '565 N 6th street', 'Suite A', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (44, '617 N 6th Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (45, '154 Jackson Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (46, '1086 N First Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (47, '1100 N FIrst Street', 'Suite C', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (48, '357 E Taylor Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (49, '470 Jackson Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (50, '856 N 13th Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (51, '674 N 13th Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (52, '211 Jackson Street', '', 'San Jose', 'CA', '95112', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (53, '1 Fordham Hill Oval', '', 'Bronx', 'NY', '10468', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (54, '10 Richman Plaza', '', 'Bronx', 'NY', '10453', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (55, '100 Elgar Pl', '', 'Bronx', 'NY', '10475', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (56, '1000 Pelham Pkwy S', '', 'Bronx', 'NY', '10461', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (57, '35 Giordan Ct', '', 'Staten Island', 'NY', '10303', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (58, '417 Annadale Rd', '', 'Staten Island', 'NY', '10312', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (59, '1617 Arden Ave', '', 'Staten Island', 'NY', '10312', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (60, '165 Brighton Ave', '', 'Staten Island', 'NY', '10301', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (61, '101 W 112th St', '', 'New York', 'NY', '10026', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (62, '454 W 22 St', '', 'New York', 'NY', '10011', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (63, '966 Lexington Ave', '', 'New York', 'NY', '10021', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (64, '675 Water St', '', 'New York', 'NY', '10002', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (65, '390 Monroe Street', '', 'Brooklyn', 'NY', '11221', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (66, '38 Hill St', '', 'Brooklyn', 'NY', '11208', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (67, '37 Centre Mall', '', 'Brooklyn', 'NY', '11231', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (68, '383 Sterling Pl', '', 'Brooklyn', 'NY', '11238', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (69, '98-07 35th Ave', '', 'Queens', 'NY', '11368', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (70, '197-06 100th Ave', '', 'Queens', 'NY', '11423', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (71, '102-01 Ascan Ave', '', 'Queens', 'NY', '11375', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (72, '32-05 21st Ave', '', 'Queens', 'NY', '11105', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (73, '481 8th Ave', '', 'New York', 'NY', '10001', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (74, '20 W 34th Street', '', 'New York', 'NY', '10001', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (75, '1 Times Square', '', 'New York', 'NY', '10036', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (76, '1410 Broadway', '', 'New York', 'NY', '10018', 'US');
INSERT INTO `address` (`id`, `address1`, `address2`, `city`, `state`, `zip_code`, `country`) VALUES (77, '695 Park Ave', '', 'New York', 'NY', '10065', 'US');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (1, 'Charli', 'Verderame', 'cverderame@neighbboringworlds.com', '000-000-0000', 'cverderame', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_ADMIN', '', '', '', 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (2, 'Paul', 'Chaffin', 'pchaffin@neighboringworlds.com', '000-000-0000', 'pchaffin', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_ADMIN', '', '', '', 2);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (3, 'Erich', 'Schindler', 'eschindler@neighboringworlds.com', '000-000-0000', 'eschindler', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_ADMIN', '', '', '', 3);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (4, 'Brian', 'Teets', 'bteets@neighboringworlds.com', '000-000-0000', 'bteets', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_ADMIN', '', '', '', 4);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (5, 'Abed', 'Nadir', 'abed@community.com', '111-111-1111', 'anadir', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/community-sitcom/images/e/e8/Abed_Season_Five.jpg/revision/latest?cb=20170802130826', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a young, emotionally reserved, Palestinian-Polish-American pop-culture enthusiast who aspires to become a director and is currently taking film directing classes at Greendale.', 5);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (6, 'Britta', 'Perry', 'britta@community.com', '111-111-1111', 'bperry', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/community-sitcom/images/8/89/Britta_Season_One_promopic.jpg/revision/latest?cb=20130227181739', '\\http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a a politically interested and socially empathetic student at Greendale, who in many cases serves as the study group\'s scapegoat.', 6);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (7, 'Jeff', 'Winger', 'jeff@community.com', '111-111-1111', 'jwinger', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.tvtropes.org/pmwiki/pub/images/community_jeffwinger_4508.jpg', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a a sardonic, charismatic, and quick-witted ex-lawyer attending Greendale Community College.', 7);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (8, 'Troy', 'Barnes', 'troy@community.com', '111-111-1111', 'tbarnes', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/community-sitcom/images/c/c0/Troy_Season_One.jpg/revision/latest?cb=20130704113554', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a former high school football star and Greendale Community College. Born and in Greendale, Colorado, and raised a Jehovah\'s Witness.', 8);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (9, 'Pierce', 'Hawthorne', 'pierce@community.com', '111-111-1111', 'phawthorne', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/community-sitcom/images/3/3c/Pierce_Season_Three.jpg/revision/latest?cb=20130619225531', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a world traveller, a toastmaster, magician, keyboardist, and self-styled hypnotherapist.', 9);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (10, 'Annie', 'Edison', 'annie@community.com', '111-111-1111', 'aedison', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://tv-fanatic-res.cloudinary.com/iu/s--nTsvGnCe--/t_full/cs_srgb,f_auto,fl_strip_profile.lossy,q_auto:420/v1371131271/alison-brie-as-annie.png', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a diligent, strait-laced, Type-A, Jewish student who is in her fifth year at Greendale Community College after graduating and then reapplying to major in my dream, forensic science.', 10);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (11, 'Ben', 'Chang', 'ben@community.com', '111-111-1111', 'bchang', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/characters/images/1/10/Ben_Chang.jpg/revision/latest?cb=20151222211545', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am a Spanish teacher with no teaching qualifications. ', 11);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (12, 'Shirley', 'Bennett', 'shirley@community.com', '111-111-1111', 'sbennett', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'http://2.bp.blogspot.com/-GNTn8X2tPas/US9ZWwVMaBI/AAAAAAAAAFg/BCsivIzMEaU/s1600/Shirley.jpg', 'http://www.nbc.com/sites/nbcunbc/files/files/2013_1210_Community_Show_KeyArt_1920x1080_CA_0.jpg', 'I am taking classes which will allow me to market my baked goods, specifically her famous brownies.I am proud to be an African American woman but appreciate not being defined by those characteristics', 12);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (13, 'Dwight', 'Schrute', 'dwight@office.com', '222-222-2222', 'dschrute', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/theoffice/images/c/c5/Dwight_.jpg/revision/latest?cb=20170701082424', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'I am the assistant to the regional manager, and run a bed and breakfast at Schrute Farms.', 13);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (14, 'Jim', 'Halmpert', 'jim@office.com', '222-222-2222', 'jhalpert', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://i0.wp.com/marvelousgeeksmedia.com/wp-content/uploads/2021/09/Screen-Shot-2021-09-07-at-8.58.27-AM.png?ssl=1', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'I am a sales person, and prank rival of Dwight. ', 14);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (15, 'Michael', 'Scott', 'michael@office.com', '222-222-2222', 'mscott', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://alleghenycampus.com/wp-content/uploads/2010/09/the-office-michael-scott.jpg', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'I am the world\'s best boss!', 15);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (16, 'Pam', 'Beesly', 'pam@office.com', '222-222-2222', 'pbeesly', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://i.pinimg.com/474x/b4/37/0b/b4370be92a23d01d414d94983c2fb925.jpg', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'I love to paint!', 16);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (17, 'Kevin', 'Malone', 'kevin@office.com', '222-222-2222', 'kmalone', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://chorus.stimg.co/23113296/baumgartner.jpg?fit=crop&crop=faces', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'Why use many word when few word do trick?', 17);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (18, 'Angela', 'Martin', 'angela@office.com', '222-222-2222', 'amartin', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://pagesix.com/wp-content/uploads/sites/3/2022/02/angela-kinsey-05.jpg?quality=75&strip=all', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'I am the head of accounting at Dunder Mifflin Scranton. I love cats.', 18);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (19, 'Stanley', 'Hudson', 'stanley@office.com', '222-222-2222', 'shudson', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://www.indiewire.com/wp-content/uploads/2020/07/Screen-Shot-2020-07-06-at-10.39.06-AM.png', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', '\"Yes, I have a dream, and it\'s not some MLK dream for equality. I want to own a decommissioned lighthouse. And I want to live at the top. And nobody knows I live there. And there\'s a button that I can press and launch that lighthouse...into space.\"', 19);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (20, 'Darryl', 'Philbin', 'darryl@office.com', '222-222-2222', 'dphilbin', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://productplacementblog.com/wp-content/uploads/2019/06/HP-Monitor-Used-by-Craig-Robinson-Darryl-Philbin-in-The-Office-4.jpg', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'I am a former warehouse worker turned co-manager.', 20);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (21, 'Kelly', 'Kapoor', 'kelly@office.com', '222-222-2222', 'kkapoor', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://media1.popsugar-assets.com/files/thumbor/cpBsKjTfaTS3FxxAiQLJ8bGSCz0/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2019/01/23/923/n/44344577/115938a45c48d82048e063.37759977_/i/Mindy-Kaling-Quotes-About-Office-Kelly-Kapoor.jpg', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'Dedicated customer service represenative. ', 21);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (22, 'Osacar', 'Martinez', 'osacar@office.com', '222-222-2222', 'omartinez', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://ocweekly.com/wp-content/uploads/2018/11/6587089_oscar.jpg', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', 'Cuban-american accounting rep', 22);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (23, 'Andy', 'Bernard', 'andy@office.com', '222-222-2222', 'abernard', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://i.pinimg.com/originals/79/54/65/795465e33d6c640c1997252905469984.jpg', 'https://flxt.tmsimg.com/assets/p185008_b_h10_ai.jpg', '', 23);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (24, 'Jack', 'Carter', 'jack@eureka.com', '333-333-3333', 'cferguson', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://hallmark.brightspotcdn.com/5a/ee/488115a4fd2e70aa6c2a7a976b62/paul-moto.jpg', 'https://images-na.ssl-images-amazon.com/images/I/81zuoEwpZrL._RI_.jpg', 'eluctantly ends up as Sheriff of Eureka. Jack is consistently dumbfounded by the wonders Eureka produces, as well as its propensity to produce things that often threaten the entire town, if not the world.', 24);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (25, 'Zoe', 'Carter', 'zoe@eureka.com', '333-333-3333', 'jdanger', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTZ_wVrDFu0HGJ-NZMVPysXsCBdwaud0OKxSZkE6yXdnAMrZrvL', 'https://images-na.ssl-images-amazon.com/images/I/81zuoEwpZrL._RI_.jpg', 'Jack\'s rebellious teenage daughter. Unlike her father, she is intelligent enough to keep up with the town\'s residents', 25);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (26, 'Jo', 'Lupo', 'jo@eureka.com', '333-333-3333', 'ecerra', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://celebswood.com/uploads/biography/2019/03/28/erica-cerra-1553767151.jpg', 'https://images-na.ssl-images-amazon.com/images/I/81zuoEwpZrL._RI_.jpg', 'a tough, no-nonsense cop with a love of firearms. From Season 2 onwards, after a brief fling with Taggart, she later develops a relationship with Zane.', 26);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (27, 'Allison', 'Blake', 'Allison@eureka.com', '333-333-3333', 'srichardson', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://ca-times.brightspotcdn.com/dims4/default/0dab1d3/2147483647/strip/true/crop/5464x8192+0+0/resize/2000x2999!/quality/90/?url=https%3A%2F%2Fcalifornia-times-brightspot.s3.amazonaws.com%2F84%2Fd4%2Ffc82ec714b1394e091fc83e82686%2F947193-la-ca-salli-richardson-whitfield-16.jpg', 'https://images-na.ssl-images-amazon.com/images/I/81zuoEwpZrL._RI_.jpg', 'a Department of Defense agent who acts as the liaison between Eureka and the Federal Government, and later becomes the director of Global Dynamics.', 27);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (28, 'Douglas', 'Fargo', 'douglas@eureka.com', '333-333-3333', 'ngrayston', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://pbs.twimg.com/profile_images/1386460866103574530/6-HNVDae_400x400.jpg', 'https://images-na.ssl-images-amazon.com/images/I/81zuoEwpZrL._RI_.jpg', 'a junior scientist who is treated somewhat dismissively by his peers. Accident prone, he more often than not ends up a victim of the disasters befalling the town.', 28);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (29, 'Henry', 'Deacon', 'henry@eureka.com', '333-333-3333', 'jmorton', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/terminator/images/2/2e/Miles.jpg/revision/latest/top-crop/width/360/height/360?cb=20071216073329', 'https://images-na.ssl-images-amazon.com/images/I/81zuoEwpZrL._RI_.jpg', 'the town psychiatrist and sometime courtesan. She secretly works for a mysterious organization known as the \"Consortium\", which has expressed a desire to exploit Eureka\'s innovations by whatever means necessary.', 29);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (30, 'Winston', 'Schmidt', 'schmidt@newgirl.com', '555-555-5555', 'wschmidt', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/newgirl/images/e/ec/Schdmidt_Season_7.jpg/revision/latest?cb=20180522150644', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'an overly confident ladies\' man who is originally from Long Island, New York.', 30);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (31, 'Nick', 'Miller', 'nick@newgirl.com', '555-555-5555', 'nmiller', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F13%2F2016%2F05%2F26%2Fnick.jpg&q=60', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'Out of everyone at the loft he is the worst with money, keeping all of his cash in a box and has never paid taxes, although ironically he is the most financially successful member of his family.', 31);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (32, 'Jess', 'Day', 'jess@newgirl.com', '555-555-5555', 'jday', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://i.pinimg.com/originals/b9/21/43/b92143bd04cf6aac6731d28ab5f223d5.jpg', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'a bubbly, offbeat teacher in her early thirties who is originally from Portland, Oregon. After discovering in the pilot episode that her live-in boyfriend, Spencer, is cheating on her, she moves into the guys\' apartment where Nick, Schmidt, and Winston (or Coach in the Pilot episode) help her move on from her break-up.', 32);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (33, 'Cece', 'Parekh', 'cece@newgirl.com', '555-555-5555', 'cparekh', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://a1cf74336522e87f135f-2f21ace9a6cf0052456644b80fa06d4f.ssl.cf2.rackcdn.com/images/characters/large/800/Cece-Parekh.New-Girl.webp', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'Jess\' best friend since childhood, a street-smart and snarky fashion model. Although she is fairly serious and cool, she does enjoy parties and has gotten drunk on occasion where she acts more wildly.', 33);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (34, 'Winston', 'Bishop', 'winston@newgirl.com', '555-555-5555', 'wbishop', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://www.indiewire.com/wp-content/uploads/2018/05/newgirl-ep601_sc8-rm_0557_hires2-copy.jpg', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'Prior to his stay, he had been a point guard for a team in the Latvian Basketball League, but has been struggling to find meaningful work.', 34);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (35, 'Aly', 'Nelson', 'aly@newgirl.com', '555-555-5555', 'anelson', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/newgirl/images/5/5f/Aly.jpeg/revision/latest?cb=20180522144021', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'Winston\'s officer partner. She is petite, which gets the guys worried that she cannot defend herself, but she quickly proves them wrong. At first, she does not want to be friends with Winston, as another cop had fallen for her before and it did not work out.', 35);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (36, 'Ernie', 'Coach', 'coach@newgirl.com', '555-555-5555', 'cwayans', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://www.cheatsheet.com/wp-content/uploads/2021/03/Damon-Wayans-Jr.-1024x631.jpg', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'a cocky and driven, yet sometimes awkward former athlete who works as a personal trainer.', 36);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (37, 'Reagan', 'Fox', 'reagan@newgirl.com', '555-555-5555', 'rfox', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/newgirl/images/f/f1/Reaganx.jpeg/revision/latest?cb=20160512000322', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'gorgeous, no-nonsense bisexual pharmaceutical sales rep who comes to town on business and shakes things up in the loft when she rents out Jess\'s room while the latter is sequestered on jury duty', 37);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (38, 'Robby', 'McFerrin', 'robby@newgirl.com', '555-555-5555', 'rmcferrin', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', '2022-06-20', 1, 'ROLE_USER', 'https://static.wikia.nocookie.net/newgirl/images/8/82/Robby.jpg/revision/latest?cb=20170206175855&path-prefix=de', 'https://archeroracle.org/wp-content/uploads/2018/04/new-girl-liz-900x499.png', 'Cece\'s new boyfriend in the season premiere. Laid-back and nice, he represents a contrast to Schmidt,[46] who sees him as a rival, but later tries to ally with him against Shivrang', 38);

COMMIT;


-- -----------------------------------------------------
-- Data for table `an_event`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (1, '2022-06-22', 'Come bake my grandma\'s famous cake recipe!', 10, 'Share my grandma recipe', 'My grandma loved to bake and would always make this one particulr cake for birthdays. In honor of her on her birthday I would to share the recipe with you all.', '17:00:00', '22:00:00', 'https://www.thedailymeal.com/sites/default/files/2020/03/03/00_hed_iStock.jpg', 1, 1, 1, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (5, '2022-07-11', 'Gjelle Night', 30, 'Eat, learn', 'Learn to cook and enjoy traditional Albanian stew', '18:00:00', '22:00:00', NULL, 42, 1, 4, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (6, '2022-06-23', 'Noche de San Juan', 50, 'Celebrate Noche de San Juan', 'Join us June 23 for a traditional Puerto Rican celebration of Noche de San Juan (St. John\'s Eve)! We will head to the beach around 11:15pm for the cleansing ceremony!', '17:00:00', '0:30:00', NULL, 46, 1, 5, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (7, '2022-07-20', 'German language exchange ', 20, 'Practice German', 'Sprechen Sie Deutsch? Our group meets every Wed night to practice our German conversational skills. ', '20:00:00', '22:00:00', NULL, 50, 1, 6, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (8, '2022-07-21', 'Italian Opera Visit', 12, 'Learn to appreciate Italian Opera', 'We will enjoy a showing of \"The Marriage of Figaro\" together.', '20:00:00', '23:00:00', NULL, 23, 1, 7, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (9, '2022-07-22', 'Chinatown shopping trip & cooking class ', 6, 'Learn to navigate your local Asian market and cook delicious Chinese dishes with us. The menu includes: handmade leek dumplings, fried water cress and oolong tea. Suggested donation is $10 / person. ', '', '10:00:00', '14:00:00', NULL, 40, 1, 35, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (10, '2022-07-23', 'Karaoke in Mandarin', 25, 'Learn Chinese through song', 'Improve your Chinese by singing your favorite Chinese pop songs with total strangers! ', '20:00:00', '', NULL, 10, 1, 23, NULL, NULL);
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (11, '2022-07-24', 'Mexican food potluck', 18, 'Enjoy delicious Mexican cuisine ', 'Hola! Do you love to cook and enjoy authentic Mexican food? Then join us for our annual potluck! No fee, just bring a dish to share. ', '18:00:00', '21:00:00', NULL, 11, 1, 11, NULL, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `user_comment` (`id`, `title`, `content`, `comment_date`, `user_id`, `an_event_id`, `in_reply_to_id`) VALUES (1, 'Great event!', 'It was so fun to learn to bake with you!', NULL, 1, 1, NULL);
INSERT INTO `user_comment` (`id`, `title`, `content`, `comment_date`, `user_id`, `an_event_id`, `in_reply_to_id`) VALUES (2, 'Agreed!', 'Thanks for sharing!', NULL, 2, 1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_tag`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `event_tag` (`id`, `keyword`) VALUES (1, 'culture');

COMMIT;


-- -----------------------------------------------------
-- Data for table `media`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `media` (`id`, `url`, `user_comment_id`, `caption`) VALUES (1, 'https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fimg1.cookinglight.timeinc.net%2Fsites%2Fdefault%2Ffiles%2Fstyles%2Fmedium_2x%2Fpublic%2F1542062283%2Fchocolate-and-cream-layer-cake-1812-cover.jpg%3Fitok%3DrEWL7AIN', 1, 'great cake');

COMMIT;


-- -----------------------------------------------------
-- Data for table `attendee`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `attendee` (`an_event_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `review`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `review` (`rating`, `review_content`, `attendee_an_event_id`, `attendee_user_id`, `review_date`) VALUES (5, 'Excellent event!', 1, 1, NULL);

COMMIT;


-- -----------------------------------------------------
-- Data for table `event_tag_has_an_event`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `event_tag_has_an_event` (`event_tag_id`, `an_event_id`) VALUES (1, 1);

COMMIT;

