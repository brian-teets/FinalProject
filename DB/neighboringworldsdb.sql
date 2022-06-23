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
  `purpose` VARCHAR(200) NULL,
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
  `id` INT NOT NULL,
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

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (1, 'Charli', 'Verderame', 'charli@neighboringworlds.com', '000-000-0000', 'cverderame', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', NULL, 1, 'ROLE_ADMIN', NULL, NULL, NULL, 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (2, 'Paul', 'Chaffin', 'paul@neighboringworlds.com', '000-000-0000', 'pchaffin', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', NULL, 1, 'ROLE_ADMIN', NULL, NULL, 'music enthusiast, book collector,  crossword solver and frequent pizza maker working as a software engineer in New York.', 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (3, 'Erich', 'Schindler', 'arich@neighboringworlds.com', '000-000-0000', 'eschindler', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', NULL, 1, 'ROLE_ADMIN', NULL, NULL, NULL, 1);
INSERT INTO `user` (`id`, `first_name`, `last_name`, `email`, `phone`, `username`, `password`, `date_created`, `enabled`, `role`, `profile_img_url`, `banner_img_url`, `biography`, `address_id`) VALUES (4, 'Brian', 'Teets', 'brain@neighboringworlds.com', '000-000-0000', 'bteets', '$2a$10$0JIv115B9iSpADjRbMO6O.9z79b8ENhVzaY/kDgIQogagu5KSTQhK', NULL, 1, 'ROLE_ADMIN', NULL, NULL, NULL, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `an_event`
-- -----------------------------------------------------
START TRANSACTION;
USE `neighboringworldsdb`;
INSERT INTO `an_event` (`id`, `event_date`, `title`, `capacity`, `purpose`, `description`, `start_time`, `end_time`, `cover_img_url`, `address_id`, `active`, `host_id`, `created_date`, `last_updated`) VALUES (1, '2022-06-22', 'Come bake my grandma\'s famous cake recipe!', 10, 'Share my grandma recipe', 'My grandma loved to bake and would always make this one particulr cake for birthdays. In honor of her on her birthday I would to share the recipe with you all.', '17:00:00', '22:00:00', 'https://www.thedailymeal.com/sites/default/files/2020/03/03/00_hed_iStock.jpg', 1, 1, 1, NULL, NULL);

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

