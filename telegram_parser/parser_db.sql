-- MySQL dump 10.13  Distrib 8.0.33, for Win64 (x86_64)
--
-- Host: localhost    Database: telegram
-- ------------------------------------------------------
-- Server version	8.0.33

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `parent_id` int DEFAULT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES (1,'Осторожно, новости',NULL,'Новостной канал в телеграме',NULL,NULL,NULL,NULL,NULL,NULL),(2,'Новости Москвы',NULL,'Самый большой канал о Москве',NULL,NULL,NULL,NULL,NULL,NULL),(3,'Readovka',NULL,'Ридовка - реальные новости',NULL,NULL,NULL,NULL,NULL,NULL),(4,'СМИ Россия не Москва',NULL,'Эруктации информпространства России и её Окраин',NULL,NULL,NULL,NULL,NULL,NULL),(5,'Ауидо мемы',NULL,'На случай важных переговоров (используешь как стикеры)',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int NOT NULL,
  `category_id` int DEFAULT NULL,
  `main_photo` text,
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `short_text` text,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `update_at` timestamp NULL DEFAULT NULL,
  `main_news` tinyint DEFAULT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `dateofevent` datetime DEFAULT NULL,
  `organizer` varchar(255) DEFAULT NULL,
  `place` varchar(255) DEFAULT NULL,
  `created` timestamp NULL DEFAULT NULL,
  `view_count` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,1,'[]','Прямо во время парада Победы пресс-служба Евгения Пригожина опубликовала видео, где он говорит, что ЧВК “Вагнер” так и не получили боеприпасы. Что еще сказал Пригожин?','Прямо во время парада Победы пресс-служба Евгения Пригожина опубликовала видео, где он говорит, что ЧВК “Вагнер” так и не получили боеприпасы. Что еще сказал Пригожин?','— Если ЧВК уйдет с позиций, то украинцы придут в Ростов. — Сегодня одно из подразделений Минобороны сбежало с флангов, бросив позиции и оголив фронт шириной почти 2 км — Сегодня фигачат Белгородскую область. Народ не в панике, но мягко говоря озабочен. Почему государство не может защитить свою страну? — День Победы — это победа наших дедов, мы на миллиметр не заслужили этой победы. У нас все по телевизору, а украинское наступление будет на земле. Всех с праздником победы наших дедов, а че мы ее празднуем — большой вопрос. Надо про них просто вспомнить и не в******я на Красной площади. — У нас все время крутятся интриги. У нас министерство интриг вместо Минобороны. Поэтому армия бежит. Если бы ЧВК получили все, что запрашивали, то уже давно сидели бы за Славянском, Угледаром, Краматорском — Мы не уйдем из Бахмута, будем стоять еще пару дней, пободаемся. Но нам дали 10% из обещанного.','2023-05-09 08:20:28','2023-05-09 08:20:28','2023-05-09 08:20:28',14,NULL,'2023-05-09 11:20:28','Осторожно, новости','Осторожно, новости','2023-05-09 08:20:28','134.8K'),(2,2,'[https://cdn4.telegram-cdn.org/file/fjNrSXNs_5ryGTeKrezOfKfHj-OX9fu9iZR1HiCK9lWTIs1-dxsSW45E_Y2o-l6kWD2SVI8qFH1U3WGNpudgnenFJDNZjj2kEAb2Z8E48PCLehXVGK39lj7ZW0aB8rXehcBpBFuYjTez8mrwYGZLLROEIbyldYikAOo6_9j3dPqaUatiO4UBWgAWYfUHUaYRI32l4HR_Sg7AKVn8H8i57CY1te9fhwyWvLeKs8rH9eLsZsEc4whHoJ11XYATIr-iavb7NndlwKsoelwZS7EVN314w3k8OGodVd2v_puciUdfxpuw8m8Shg9MoR4IaQ7js5V6K5N0ndS0cxI3s9KHZQ.jpg]','🚁  К дронам на Красной площади повышенное внимание, работают снайперы','🚁  К дронам на Красной площади повышенное внимание, работают снайперы','','2023-05-09 07:49:09','2023-05-09 07:49:09','2023-05-09 07:49:09',17,NULL,'2023-05-09 10:49:09','Новости Москвы','Новости Москвы','2023-05-09 07:49:09','215.8K'),(3,3,'[https://cdn4.telegram-cdn.org/file/Xid4ASkDkyyziZ6KSLhc9hMzu4xP0jkxoTgA0tISyjGrAzY5I80y9RYoeSGKwhxfl7ZwCMad7c8cTWrz8W2dOHTAgKxGhno-c3rLvGQSQU8S55ZS1qlVcEau8onK0d0cjvFmKK7L-JjJqo42OQrAl5DqlpqXPNmi2tlOUriyBk90YhBtSM_bmg3wIWUQx8yHh6U2oieASP5-rp_nkmbQytLshij_X4C1hm_F59TdgS4vnu56vGDyItPwjZq3J2XXaBmwT0lpPClYgLZ2PNKiW-Oj3SHLAyA4Gxv5Y-b6eVECt34b4Dh1CctvmhG88gPNLFS0sPVPKhE_JGhH69ykVQ.jpg]','В Киеве горожане несут цветы к Вечному огню в Парк Славы, несмотря на отмену Дня Победы — всех пришедших проверяют на «русский след»','В Киеве горожане несут цветы к Вечному огню в Парк Славы, несмотря на отмену Дня Победы — всех пришедших проверяют на «русский след»','Киевляне массово несут цветы в Парк Славы к Вечному огню в центр украинской столицы. Люди приходят, чтобы почтить память героев, освободивших мир от нацизма. На входе в парк у кивелян требуют телефоны — оперативники проверяют переписки и подписки в поисках «русского следа». Президент Украины Зеленский отменил День Победы. Вместо него в незалежной 9 мая теперь проходит День Европы. Так на Банковой «чтут» память героев-освободителей — перечеркивают историю и придумывают новые праздники.','2023-05-09 08:55:56','2023-05-09 08:55:56','2023-05-09 08:55:56',20,NULL,'2023-05-09 11:55:56','Readovka','Readovka','2023-05-09 08:55:56','5.0K'),(4,4,'[https://cdn4.telegram-cdn.org/file/ifNiY58BllC25WFATDE6m20lw1bkqHBSii1tOKxWD8P31IDjoUk8Mj7x5f3eRsDie8__t8nwtOKY4qMkSGt6uprQv8LBU7ARHKOsXR6iDWSjd-4-hjKNXC65MJxINN2nh3gxxnyZyd-StLlCWZF8TBWloqdsrQehpyj1Vu80TiIdNBG9Bh9bv3-UYrBHzzk1bAV1XUugHUwl4mHwvJz_4LBWAlvFXp9rnQ-Q1J8hZi187WA2atFH4YizSb0o5b0S28nKercMN_O1VnxRySbtfeT3ZD439nBVn7zl5MuqzXmRIITGnLoFkkGeVJGapeGpO9kAMg8E4j882x6c_FIGKQ.jpg]','Росгвардейцам выдавали антидроновые ружья перед Парадом в Москве.','Росгвардейцам выдавали антидроновые ружья перед Парадом в Москве.','Подписаться на СМИ','2023-05-09 08:50:03','2023-05-09 08:50:03','2023-05-09 08:50:03',13,NULL,'2023-05-09 11:50:03','СМИ Россия не Москва','СМИ Россия не Москва','2023-05-09 08:50:03','13.4K'),(5,5,'[https://cdn4.telegram-cdn.org/file/f3333ec3d4.ogg?token=lOMHMvx3irKk2oATE1SMkY61C6NgXXNML23_tn8T9UTTBml13cRPASeNOgqdodEu9d-nv5r9n97yw8r2NJn4ORMxLHhp_jdXd3vqGk0b8uNJoyWaaYVg8vLBvXZwC_QOIZwkumxQVfP3gGDUGVvt4B-YcfTN3WyHheECnwDOywnBX6Fi3FvNfCmhB-6pxTvKvlibwONqnCKO_mrV_DmzVAJF1FUj5W0qTnL9T88_nzINiE6WRSxCc6_YjHX2NUVvcFv0PYBfRMU5vuhkMzrJtiD5UkkjineXXTD9gTzPYOt5jPBnHWRLTFofTgfeIG-pexPGsX081O_w7p8lEvK1Aw]','','','','2023-05-08 15:39:44','2023-05-08 15:39:44','2023-05-08 15:39:44',20,NULL,'2023-05-08 18:39:44','Аудио мемы','Аудио мемы','2023-05-08 15:39:44','2.3K');
/*!40000 ALTER TABLE `news` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telegram_logins`
--

DROP TABLE IF EXISTS `telegram_logins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telegram_logins` (
  `id` int NOT NULL,
  `logo` text,
  `name` varchar(191) DEFAULT NULL,
  `login` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telegram_logins`
--

LOCK TABLES `telegram_logins` WRITE;
/*!40000 ALTER TABLE `telegram_logins` DISABLE KEYS */;
INSERT INTO `telegram_logins` VALUES (1,NULL,NULL,'ostorozhno_novosti',NULL,NULL),(2,NULL,NULL,'moscowmap',NULL,NULL),(3,NULL,NULL,'readovkanews',NULL,NULL),(4,NULL,NULL,'novosti_voinaa',NULL,NULL),(5,NULL,NULL,'mp3memes',NULL,NULL);
/*!40000 ALTER TABLE `telegram_logins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'telegram'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-05-09 11:58:38
