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
INSERT INTO `categories` VALUES (1,'Осторожно, новости',NULL,'Новостной канал в телеграме',NULL,NULL,NULL,NULL,NULL,NULL),(2,'Новости Москвы',NULL,'Самый большой канал о Москве',NULL,NULL,NULL,NULL,NULL,NULL),(3,'Readovka',NULL,'Ридовка - реальные новости',NULL,NULL,NULL,NULL,NULL,NULL),(4,'СМИ Россия не Москва',NULL,'Эруктации информпространства России и её Окраин',NULL,NULL,NULL,NULL,NULL,NULL),(5,'Ауидо мемы',NULL,'На случай важных переговоров (используешь как стикеры)',NULL,NULL,NULL,NULL,NULL,NULL),(6,'OnlineDagestan',NULL,'Свежие новости о Дагестане и не только',NULL,NULL,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `news`
--

DROP TABLE IF EXISTS `news`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `news` (
  `id` int NOT NULL AUTO_INCREMENT,
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
  `view_count` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `news`
--

LOCK TABLES `news` WRITE;
/*!40000 ALTER TABLE `news` DISABLE KEYS */;
INSERT INTO `news` VALUES (1,1,'[]','QIWI ввел временные ограничения на вывод средств с электронных кошельков на банковские счета и снятие наличных.','QIWI ввел временные ограничения на вывод средств с электронных кошельков на банковские счета и снятие наличных.','Решение объяснили предписанием Центробанка, у которого появились претензии к платежной системе после проверки. QIWI ввела лимит на вывод средств и перевод на карты других банков — 1000 рублей в месяц. Также пользователя запретили переводить деньги по системе быстрых платежей, через контакты, а также снимать наличные (даже в офисах компании) и погашать кредиты, выданные микрофинансовыми организациями. Ограничения вступили в силу с вечера 25 июля. Сколько они продлятся, неизвестно. В QIWI надеется устранить недочёты в ближайшее время. Пополнение счетов мобильных операторов, оплата услуг, игр и товаров через платежную систему работает в привычном режиме.','2023-07-25 21:22:32','2023-07-25 21:22:32','2023-07-25 21:22:32',12,'https://t.me/s/ostorozhno_novosti/18204','2023-07-26 00:22:32','Осторожно, новости','Осторожно, новости','2023-07-25 21:22:32','276.1K'),(2,2,'[]','🧑🏻‍🏫','🧑🏻‍🏫','В 2024 в России появится ГОСТ на школьную форму Школьная форма должна носить светский характер, быть удобной, эстетичной, соответствовать погодным условиям. Требование ГОСТ —   гигроскопичность — способность поглощать водяные пары, воздухопроницаемость и уровень токсичности (аллергенности) материалов.','2023-07-26 05:11:53','2023-07-26 05:11:53','2023-07-26 05:11:53',18,'https://t.me/s/moscowmap/56207','2023-07-26 08:11:53','Новости Москвы','Новости Москвы','2023-07-26 05:11:53','182.7K'),(3,3,'[]','Кадры работы русской армии по ВСУ на северном фланге Бахмутского (Артемовского) направления','Кадры работы русской армии по ВСУ на северном фланге Бахмутского (Артемовского) направления','Украинские боевики планировали атаковать наши позиции в районе Раздоловки на северном фланге Бахмутского (Артемовского) направления. Однако русские «птички» все время вели за ними наблюдение и передавали координаты целей нашим бойцам. На кадрах, предоставленных Readovka, видно, как грамотно русская армия отрабатывает по бегающим боевикам. Наши бойцы нанесли множество точных артиллерийских и минометных ударов, а также применили дроны-камикадзе, уничтожив готовившихся к «наступлению» ВСУ.','2023-07-26 06:05:01','2023-07-26 06:05:01','2023-07-26 06:05:01',20,'https://t.me/s/readovkanews/63158','2023-07-26 09:05:01','Readovka','Readovka','2023-07-26 06:05:01','54.7K'),(4,4,'[https://cdn4.telegram-cdn.org/file/lV_fn66c-Jt5Jd8usl6olDLagtJQxnmtx1gDxptRQxDO8kOasvc17XtU_aiZYdBwlni23s0mgOIioFBrao5h3DOR-5IjWC0gpjgudrgsKGo52PUX0jHxtbn1HGeMu-s1XaGELRbqUrSOAkzbo6PqFzZZFrCciw6HauRSwfqryEZ54po8FcQ90r5gytAdfUA1kaQqH3syE3QP_WjC-K8vemGSq49-MMBDPMGpuSFzAJADLE2z4XxX8S7cU3VGO1tE7PtdDtg1e6mtqmCKhBiXJyz8TcsSXZG4xPVzqTjofcR92arD4U5VEA-0C0jo97XdTyCW2VUqdIuPTN4bIw2UFQ.jpg]','Смертельно опасные пауки распространяются по Крыму и Волгоградской области','Смертельно опасные пауки распространяются по Крыму и Волгоградской области','. В последней каракурт напал на подростка, мальчик в реанимации. Насекомые мигрируют благодаря аномальной жаре. Симптомы от укуса пауков каракуртов: сильная слабость, лишающая способности передвигаться, затруднённое дыхание и страх смерти. Подписаться на СМИ','2023-07-26 05:18:52','2023-07-26 05:18:52','2023-07-26 05:18:52',19,'https://t.me/s/novosti_voinaa/15477','2023-07-26 08:18:52','СМИ Россия не Москва','СМИ Россия не Москва','2023-07-26 05:18:52','51.5K');
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
INSERT INTO `telegram_logins` VALUES (1,NULL,NULL,'ostorozhno_novosti',NULL,NULL),(2,NULL,NULL,'moscowmap',NULL,NULL),(3,NULL,NULL,'readovkanews',NULL,NULL),(4,NULL,NULL,'novosti_voinaa',NULL,NULL),(5,NULL,NULL,'mp3memes',NULL,NULL),(6,NULL,NULL,'OnlineDagestan',NULL,NULL);
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

-- Dump completed on 2023-07-26  9:16:17
