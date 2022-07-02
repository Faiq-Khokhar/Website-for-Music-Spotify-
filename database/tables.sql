CREATE TABLE `user` (
 `user_id` int(11) AUTO_INCREMENT,
 `username` varchar(255) NOT NULL,
 `mobile_number` varchar(10) NOT NULL,
 `email_address` varchar(255) NOT NULL,
 `password` varchar(255) NOT NULL,
 `activation_code` varchar(255) NOT NULL DEFAULT '0',
 `confirm_status` int(1) DEFAULT '1',
 `contributions` int(11) NOT NULL DEFAULT '0',
 PRIMARY KEY (`user_id`)
);

CREATE TABLE `category` (
 `cat_id` int(11) NOT NULL,
 `cat_name` varchar(255) NOT NULL,
 primary key(`cat_id`)
);

CREATE TABLE `kannada_albums` (
 `song_id` int(100) NOT NULL AUTO_INCREMENT,
 `song_name` varchar(255) NOT NULL,
 `song_format` varchar(100) NOT NULL,
 `singer_name` varchar(100) NOT NULL,
 `movie_name` varchar(50) NOT NULL,
 `song_image` varchar(255) NOT NULL,
 `audio_file` varchar(255) NOT NULL,
 PRIMARY KEY (`song_id`)
foreign key (id) references user(user_id)
);

CREATE TABLE `english_albums` (
 `song_id` int(100) NOT NULL AUTO_INCREMENT,
 `song_name` varchar(255) NOT NULL,
 `song_format` varchar(100) NOT NULL,
 `singer_name` varchar(100) NOT NULL,
 `movie_name` varchar(50) NOT NULL,
 `song_image` varchar(255) NOT NULL,
 `audio_file` varchar(255) NOT NULL,
 PRIMARY KEY (`song_id`)
foreign key (id) references user(user_id)
);

CREATE TABLE `hindi_albums` (
 `song_id` int(100) NOT NULL AUTO_INCREMENT,
 `song_name` varchar(255) NOT NULL,
 `song_format` varchar(100) NOT NULL,
 `singer_name` varchar(100) NOT NULL,
 `movie_name` varchar(50) NOT NULL,
 `song_image` varchar(255) NOT NULL,
 `audio_file` varchar(255) NOT NULL,
 PRIMARY KEY (`song_id`)
foreign key (id) references user(user_id)
);

CREATE TABLE `upload_albums` (
 `song_id` int(100) NOT NULL AUTO_INCREMENT,
 `singer_id` int(11) NOT NULL,
 `song_name` varchar(255) NOT NULL,
 `song_format` varchar(100) NOT NULL,
 `singer_name` varchar(100) NOT NULL,
 `song_image` varchar(255) NOT NULL,
 `audio_file` varchar(255) NOT NULL,
 PRIMARY KEY (`song_id`)
foreign key (id) references user(user_id)
);

CREATE TABLE `favorite_songs` (
 `id` int(11) NOT NULL AUTO_INCREMENT,
 `cat_id` int(11) NOT NULL references category(`cat_id`) on delete cascade,
 `song_id` int(11) NOT NULL,
 `user_id` int(11) NOT NULL references user(`user_id`) on delete cascade,
 `song_name` varchar(255) NOT NULL,
 `singer_name` varchar(255) NOT NULL,
 `song_image` varchar(255) NOT NULL,
 `audio_file` varchar(255) NOT NULL,
 PRIMARY KEY (`id`)
foreign key (id) references user(user_id)
);

*trigger to keep track of user contributions*
CREATE TRIGGER `IncrementCount` AFTER INSERT ON `upload_albums`
 FOR EACH ROW update user set user.contributions = user.contributions + 1 where new.singer_id = user.user_id

 *stored procedure to upload songs*
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `uploadsongs`(IN `singer_id` INT(11), IN `song_name` VARCHAR(255), IN `song_format` VARCHAR(255), 
IN `singer_name` VARCHAR(255), IN `song_image` VARCHAR(255), IN `audio_file` VARCHAR(255))
    
NO SQL

INSERT INTO upload_albums(`singer_id`,`song_name`,`song_format`,`singer_name`,`song_image`,`audio_file`) 
VALUES(singer_id,song_name,song_format,singer_name,song_image,audio_file)$$
DELIMITER ;

/////////PROCEDURES
create procedure First_insertion
AS
BEGIN
BEGIN TRY
BEGIN TRANSACTION
INSERT INTO `user` (`user_id`,`username`,`mobile_number`,`email_address`,`password`,`confirm_status`)
VALUES(1,'Admin','9876543210', 'admin@gmail.com', '0000', 1);
INSERT INTO `user` (`user_id`,`username`,`mobile_number`,`email_address`,`password`,`confirm_status`)
VALUES(2,'Faiq','9876543211', 'BCSM-F20-402@superior.edu.pk', '1111', 1);
commit transaction
END try
BEGIN CATCH
ROLLBACK TRANSACTION
END catch
END

--Now we will execute this transaction in procedure
select * from `user`;

EXECUTE First_insertion


INSERT INTO `category` (`cat_id`, `cat_name`) VALUES 
    ('1', 'kannada_albums'),
    ('2', 'hindi_albums'),
    ('3', 'english_albums'),
    ('4', 'uploaded_albums');