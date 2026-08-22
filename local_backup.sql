-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Win64 (AMD64)
--
-- Host: localhost    Database: nexus_wms_local
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `auditlog`
--

DROP TABLE IF EXISTS `auditlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auditlog` (
  `id` varchar(191) NOT NULL,
  `event` varchar(191) NOT NULL,
  `userId` varchar(191) DEFAULT NULL,
  `ipAddress` varchar(191) DEFAULT NULL,
  `timestamp` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `auditlog_userId_fkey` (`userId`),
  CONSTRAINT `auditlog_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auditlog`
--

LOCK TABLES `auditlog` WRITE;
/*!40000 ALTER TABLE `auditlog` DISABLE KEYS */;
INSERT INTO `auditlog` VALUES ('015a3dd2-9def-45c5-b218-ca5eb052c7cc','PO_DELETED',NULL,'::1','2026-08-11 07:29:24.887'),('06ea2f05-66d7-434c-bf43-34017a6c7dc4','SALES_ORDER_DELETED_BY_CLIENT',NULL,'::1','2026-08-12 06:39:53.509'),('18a02f3e-2221-45f7-bb3f-39e688d56f37','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'::1','2026-08-12 05:46:27.718'),('1f0a61e6-bfe1-4446-9be7-38638aef85d5','COMPANY_DELETED',NULL,'::1','2026-08-11 07:19:21.688'),('208d5593-de5c-4a17-8ef4-d98e55c90b75','SALES_ORDER_DELETED_BY_CLIENT',NULL,'::1','2026-08-12 06:40:09.859'),('2fe5a0a2-a4c3-45bc-8aab-7231f072d564','SALES_ORDER_DELETED_BY_CLIENT',NULL,'::1','2026-08-12 06:40:41.465'),('359ec899-f3ad-426f-af19-933d60c4a33f','PO_CREATED',NULL,'::1','2026-08-11 06:24:11.724'),('362d59a8-58d6-462e-82ee-b934e16bf843','COMPANY_PROVISIONED','d69450a5-edd8-47ad-8057-c5e7a79de357','::1','2026-08-11 12:49:16.982'),('37debc9b-0990-4240-9a61-ff30663a4214','COMPANY_DELETED',NULL,'::1','2026-08-11 07:19:23.455'),('3b0b01d7-21d0-4eb2-8838-9e231c31d8bb','SALES_ORDER_REJECTED',NULL,'::1','2026-08-11 07:21:44.040'),('3d785c6d-4f05-4fb2-b734-b033db09fb7d','USER_UPDATED',NULL,'::1','2026-08-11 07:22:28.252'),('4050e0e3-f55e-462b-9d6b-dc225602147d','USER_UPDATED',NULL,'::1','2026-08-11 07:22:25.394'),('42128cc0-36d5-4c49-824b-1589d6a58afa','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'::1','2026-08-12 05:45:27.824'),('421d6324-ef79-4701-b039-82ee6a573b8b','SALES_ORDER_APPROVED','6d065f89-c2de-4086-993a-139450ccb653','::1','2026-08-12 06:44:06.956'),('44ad8d5d-b50d-458d-a173-eb5cb3a2a66e','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'::1','2026-08-12 06:11:25.339'),('480feb68-c84e-4f9b-90de-8a95ff4e153b','SALES_ORDER_APPROVED','6d065f89-c2de-4086-993a-139450ccb653','::1','2026-08-12 06:44:10.602'),('4d7864d2-b1ef-4342-b5dd-e306306ced04','CLIENT_PROVISIONED',NULL,'::1','2026-08-11 06:19:44.171'),('60e66462-122e-42b0-bad4-f18f6013b00a','CLIENT_DELETED',NULL,'::1','2026-08-11 06:19:59.231'),('6282245d-d0c2-4c12-a6f6-f0c9f9a8612d','WAREHOUSE_FACILITY_CREATED','6d065f89-c2de-4086-993a-139450ccb653','::1','2026-08-11 12:54:55.501'),('6f3f013f-84fc-4079-a858-2573119aa3b6','SHIPSTATION_LABEL_GENERATED','f28c3bdf-923c-47a6-ac3c-eeb2f28df3b5','::1','2026-08-12 07:13:49.082'),('756472b4-2d63-49d1-9ad6-de93b555740b','WAREHOUSE_FACILITY_CREATED','d69450a5-edd8-47ad-8057-c5e7a79de357','::1','2026-08-12 07:17:46.285'),('89b2ba55-1cba-4518-bd83-b98255470aa5','USER_INVITED','6d065f89-c2de-4086-993a-139450ccb653','::1','2026-08-11 13:12:32.411'),('8a7d800b-9006-41fe-8770-6aaa3b11f1f7','USER_DELETED',NULL,'::1','2026-08-11 07:23:13.502'),('8cb2fc71-f0cf-4dab-b120-c3b7cc2e568f','PO_CREATED',NULL,'::1','2026-08-11 06:43:55.689'),('991dd95f-9de0-4f21-9ccd-af6864b2469c','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'::1','2026-08-12 06:00:11.931'),('9d28cf03-c491-4a96-ad0e-d86a16d373dc','CLIENT_DELETED',NULL,'::1','2026-08-11 07:22:13.103'),('a3d4f2da-c383-4b93-8433-2013b0477d7a','SALES_ORDER_REQUESTED',NULL,'127.0.0.1','2026-08-11 13:51:05.190'),('a3f2c43f-8ba9-4dcb-a776-b3ed496a9aac','CLIENT_PROVISIONED','6d065f89-c2de-4086-993a-139450ccb653','::1','2026-08-11 13:13:10.944'),('ad083fd0-d0cd-4c6d-a879-04cda5fdb796','USER_DELETED',NULL,'::1','2026-08-11 07:29:45.545'),('bb9d00a1-0b3d-4da8-85ad-3e690c4e1f63','COMPANY_DELETED',NULL,'::1','2026-08-11 07:19:19.640'),('bd4bdf23-4518-470e-8e98-c21cfc65a9bb','SALES_ORDER_CREATED',NULL,'::1','2026-08-11 06:45:12.299'),('c7421393-ecdb-44c4-8377-7bdc85b18f7c','SALES_ORDER_REQUESTED',NULL,'::1','2026-08-12 06:41:42.149'),('c8d00947-4e05-4aa8-998a-96c5bacb144d','USER_INVITED','d69450a5-edd8-47ad-8057-c5e7a79de357','::1','2026-08-11 12:50:16.787'),('cea91c92-e789-4505-beb2-789151fe495c','PICK_LIST_COMPLETED','f28c3bdf-923c-47a6-ac3c-eeb2f28df3b5','::1','2026-08-12 07:08:24.155'),('cf5c18d3-183e-41eb-866a-95a8c1925234','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'::1','2026-08-12 05:45:10.842'),('d6012f85-6e65-449e-9ea9-13c38036978c','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'::1','2026-08-12 05:35:11.008'),('f0b776ed-ed8c-40e5-82ea-5b7bedcbde65','SALES_ORDER_CANCELED_BY_CLIENT',NULL,'127.0.0.1','2026-08-12 05:48:47.166'),('f1935a4f-dc7b-40c9-b4b2-6c2ed70a3236','SALES_ORDER_DELETED_BY_CLIENT',NULL,'::1','2026-08-12 06:39:32.846');
/*!40000 ALTER TABLE `auditlog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `barcode`
--

DROP TABLE IF EXISTS `barcode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `barcode` (
  `id` varchar(191) NOT NULL,
  `code` varchar(191) NOT NULL,
  `barcodeType` varchar(191) NOT NULL DEFAULT 'CODE128',
  `productId` varchar(191) NOT NULL,
  `batchId` varchar(191) NOT NULL,
  `trackingStatus` varchar(191) NOT NULL DEFAULT 'GENERATED',
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `barcode_code_key` (`code`),
  KEY `barcode_productId_fkey` (`productId`),
  KEY `barcode_batchId_fkey` (`batchId`),
  CONSTRAINT `barcode_batchId_fkey` FOREIGN KEY (`batchId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `barcode_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `barcode`
--

LOCK TABLES `barcode` WRITE;
/*!40000 ALTER TABLE `barcode` DISABLE KEYS */;
INSERT INTO `barcode` VALUES ('15830501-49f4-4630-8da7-b4df3dcc90c6','WMS-01BA-712E2F-2C826881-1716','CODE128','712e2fe9-7f66-4b75-b407-529a3eed37e6','2c826881-1f3e-45e3-8875-34f31c9ed996','GENERATED','01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 13:02:47.015');
/*!40000 ALTER TABLE `barcode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `batch`
--

DROP TABLE IF EXISTS `batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `batch` (
  `id` varchar(191) NOT NULL,
  `lotNumber` varchar(191) DEFAULT NULL,
  `lotId` varchar(191) DEFAULT NULL,
  `productId` varchar(191) NOT NULL,
  `receivingItemId` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `mfgDate` datetime(3) DEFAULT NULL,
  `expiryDate` datetime(3) DEFAULT NULL,
  `acceptedQty` int(11) NOT NULL DEFAULT 0,
  `status` varchar(191) NOT NULL DEFAULT 'QUARANTINE',
  `quarantine` tinyint(1) NOT NULL DEFAULT 0,
  `coaLocked` tinyint(1) NOT NULL DEFAULT 1,
  `testCertificateId` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `batch_productId_fkey` (`productId`),
  KEY `batch_companyId_fkey` (`companyId`),
  KEY `batch_receivingItemId_fkey` (`receivingItemId`),
  CONSTRAINT `batch_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `batch_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `batch_receivingItemId_fkey` FOREIGN KEY (`receivingItemId`) REFERENCES `receivingitem` (`id`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `batch`
--

LOCK TABLES `batch` WRITE;
/*!40000 ALTER TABLE `batch` DISABLE KEYS */;
INSERT INTO `batch` VALUES ('2c826881-1f3e-45e3-8875-34f31c9ed996',NULL,'SDFGH23','712e2fe9-7f66-4b75-b407-529a3eed37e6',NULL,'01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 00:00:00.000','2026-08-31 00:00:00.000',0,'QUARANTINE',0,0,NULL,'2026-08-11 13:02:46.986','2026-08-11 13:02:46.986'),('554620f5-ef9d-4c69-b355-dc3f54ca4713','OPENING-ASF12324','OPENING-1786453324160','712e2fe9-7f66-4b75-b407-529a3eed37e6',NULL,'01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 13:02:04.161',NULL,500,'RELEASED',0,0,NULL,'2026-08-11 13:02:04.163','2026-08-11 13:02:04.163');
/*!40000 ALTER TABLE `batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `category` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `description` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `deletedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `category_companyId_fkey` (`companyId`),
  CONSTRAINT `category_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES ('52b1473a-cf63-4b2f-a67a-1e21f92f0e61','mobile','asd123','asdsfd','0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-11 09:09:26.460','2026-08-11 12:46:15.037','2026-08-11 12:46:15.034'),('69e0b5ce-9897-4c8d-bef8-fc0a175e3600','Cat',NULL,NULL,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-07 09:42:50.458','2026-08-11 08:48:54.475','2026-08-11 08:48:54.473'),('8996de16-77dd-453f-ae15-5d9d0aaebe06','MOBILE','ASDS123','MOBILE PHONES','01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 13:00:59.496','2026-08-11 13:00:59.496',NULL),('c86c9607-c4e9-439f-b6ce-c9827c14fb61','asdfgn','sdfgh','sdfgh','0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-11 06:20:13.494','2026-08-11 08:48:52.365','2026-08-11 08:48:52.360');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `creditLimit` double NOT NULL DEFAULT 0,
  `tier` varchar(191) NOT NULL DEFAULT 'STANDARD',
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `shippingAddress` varchar(191) DEFAULT NULL,
  `gstNumber` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'ACTIVE',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `companyId` varchar(191) DEFAULT NULL,
  `warehouseId` varchar(191) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `client_companyId_fkey` (`companyId`),
  KEY `client_warehouseId_fkey` (`warehouseId`),
  CONSTRAINT `client_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `client_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `warehouse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES ('1d70df49-40af-4a5b-b6d3-4adb59621e37','Client',0,'STANDARD','stitchclient@gmail.com','N/A','N/A',NULL,NULL,'ACTIVE','2026-08-11 07:50:35.618','2026-08-11 07:50:35.618','0865134b-9d8b-4f9e-bc54-8eaa88f74d35',NULL,'x'),('7689a925-73f8-4ed0-a31b-062ae0bc1b6a','cleint demoo',100000,'STANDARD','client@gmail.com','+1 12345678','sdgf, Birmingham, Alabama, United States, PIN: 35203','sdgf, Birmingham, Alabama, United States, PIN: 35203','','ACTIVE','2026-08-11 13:13:10.930','2026-08-11 13:13:10.930','01bad94b-2627-4b95-9b21-64000231a180',NULL,'$2b$10$zfWukFEKL0nbiMlus8i2Xu8F37ifQU.4HpwrQ2w2C6hL18GLMFqK.');
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `company`
--

DROP TABLE IF EXISTS `company`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `company` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `clientCode` varchar(191) DEFAULT NULL,
  `industry` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'ACTIVE',
  `email` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `company`
--

LOCK TABLES `company` WRITE;
/*!40000 ALTER TABLE `company` DISABLE KEYS */;
INSERT INTO `company` VALUES ('01bad94b-2627-4b95-9b21-64000231a180','demo','asd123','Chemicals & Materials','ACTIVE','demo@gmail.com','245654','2026-08-11 12:49:16.946','2026-08-11 12:49:16.946'),('0865134b-9d8b-4f9e-bc54-8eaa88f74d35','StitchNexus',NULL,'Logistics','ACTIVE','testabc@company.com',NULL,'2026-08-07 09:42:50.303','2026-08-11 06:53:33.055');
/*!40000 ALTER TABLE `company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `expiryalert`
--

DROP TABLE IF EXISTS `expiryalert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `expiryalert` (
  `id` varchar(191) NOT NULL,
  `lotId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `expiryDate` datetime(3) NOT NULL,
  `daysRemaining` int(11) NOT NULL,
  `alertTier` varchar(191) NOT NULL,
  `resolved` tinyint(1) NOT NULL DEFAULT 0,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `expiryalert_lotId_fkey` (`lotId`),
  KEY `expiryalert_productId_fkey` (`productId`),
  KEY `expiryalert_companyId_fkey` (`companyId`),
  CONSTRAINT `expiryalert_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `expiryalert_lotId_fkey` FOREIGN KEY (`lotId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `expiryalert_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `expiryalert`
--

LOCK TABLES `expiryalert` WRITE;
/*!40000 ALTER TABLE `expiryalert` DISABLE KEYS */;
INSERT INTO `expiryalert` VALUES ('598fb616-2f9c-4c43-944a-c638f83715aa','2c826881-1f3e-45e3-8875-34f31c9ed996','712e2fe9-7f66-4b75-b407-529a3eed37e6','2026-08-31 00:00:00.000',19,'30 Days',0,'01bad94b-2627-4b95-9b21-64000231a180','2026-08-12 06:42:38.503');
/*!40000 ALTER TABLE `expiryalert` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `id` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `companyId` varchar(191) NOT NULL,
  `totalStock` int(11) NOT NULL DEFAULT 0,
  `reservedStock` int(11) NOT NULL DEFAULT 0,
  `availableStock` int(11) NOT NULL DEFAULT 0,
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventory_productId_companyId_key` (`productId`,`companyId`),
  KEY `inventory_companyId_fkey` (`companyId`),
  CONSTRAINT `inventory_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventory_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
INSERT INTO `inventory` VALUES ('9547c010-ac8c-4016-aecf-77dc49c916a0','712e2fe9-7f66-4b75-b407-529a3eed37e6','01bad94b-2627-4b95-9b21-64000231a180',490,0,490,'2026-08-12 07:08:24.076');
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventoryledger`
--

DROP TABLE IF EXISTS `inventoryledger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventoryledger` (
  `id` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `lotId` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `locationId` varchar(191) DEFAULT NULL,
  `sourceLocationId` varchar(191) DEFAULT NULL,
  `destLocationId` varchar(191) DEFAULT NULL,
  `location` varchar(191) DEFAULT NULL,
  `quantityDelta` int(11) NOT NULL,
  `movementType` varchar(191) NOT NULL,
  `referenceId` varchar(191) DEFAULT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `createdBy` varchar(191) DEFAULT NULL,
  `timestamp` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `inventoryledger_productId_fkey` (`productId`),
  KEY `inventoryledger_lotId_fkey` (`lotId`),
  KEY `inventoryledger_companyId_fkey` (`companyId`),
  KEY `inventoryledger_locationId_fkey` (`locationId`),
  CONSTRAINT `inventoryledger_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventoryledger_locationId_fkey` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventoryledger_lotId_fkey` FOREIGN KEY (`lotId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventoryledger_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventoryledger`
--

LOCK TABLES `inventoryledger` WRITE;
/*!40000 ALTER TABLE `inventoryledger` DISABLE KEYS */;
INSERT INTO `inventoryledger` VALUES ('5c766a6f-2333-46c1-92f3-9459cc154a7e','712e2fe9-7f66-4b75-b407-529a3eed37e6','554620f5-ef9d-4c69-b355-dc3f54ca4713','01bad94b-2627-4b95-9b21-64000231a180','6442c27a-81a3-41c1-85cb-001b9609ea7f',NULL,NULL,NULL,-10,'SHIP','ORDER-7af47e6d-f2c5-440e-9211-b42dde1bfcc6','Outbound pick & ship from location bin 6442c27a-81a3-41c1-85cb-001b9609ea7f',NULL,'2026-08-12 07:08:24.019'),('9d210ba1-568f-43f4-827b-baca8d6dd669','712e2fe9-7f66-4b75-b407-529a3eed37e6','554620f5-ef9d-4c69-b355-dc3f54ca4713','01bad94b-2627-4b95-9b21-64000231a180','6442c27a-81a3-41c1-85cb-001b9609ea7f',NULL,NULL,NULL,500,'OPENING_STOCK',NULL,'Initial opening stock',NULL,'2026-08-11 13:02:04.183');
/*!40000 ALTER TABLE `inventoryledger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventorytransfer`
--

DROP TABLE IF EXISTS `inventorytransfer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventorytransfer` (
  `id` varchar(191) NOT NULL,
  `transferNumber` varchar(191) NOT NULL,
  `transferType` varchar(191) NOT NULL DEFAULT 'BIN_TO_BIN',
  `sourceLocationId` varchar(191) NOT NULL,
  `destLocationId` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `companyId` varchar(191) NOT NULL,
  `createdBy` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `inventorytransfer_transferNumber_key` (`transferNumber`),
  KEY `inventorytransfer_companyId_fkey` (`companyId`),
  KEY `inventorytransfer_sourceLocationId_fkey` (`sourceLocationId`),
  KEY `inventorytransfer_destLocationId_fkey` (`destLocationId`),
  KEY `inventorytransfer_createdBy_fkey` (`createdBy`),
  CONSTRAINT `inventorytransfer_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventorytransfer_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventorytransfer_destLocationId_fkey` FOREIGN KEY (`destLocationId`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `inventorytransfer_sourceLocationId_fkey` FOREIGN KEY (`sourceLocationId`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventorytransfer`
--

LOCK TABLES `inventorytransfer` WRITE;
/*!40000 ALTER TABLE `inventorytransfer` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventorytransfer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `invoice` (
  `id` varchar(191) NOT NULL,
  `invoiceNo` varchar(191) NOT NULL,
  `orderId` varchar(191) NOT NULL,
  `clientId` varchar(191) NOT NULL,
  `companyId` varchar(191) NOT NULL,
  `items` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`items`)),
  `totalAmount` decimal(65,30) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'UNPAID',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `paidAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `invoice_invoiceNo_key` (`invoiceNo`),
  KEY `invoice_orderId_fkey` (`orderId`),
  KEY `invoice_clientId_fkey` (`clientId`),
  KEY `invoice_companyId_fkey` (`companyId`),
  CONSTRAINT `invoice_clientId_fkey` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `invoice_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `salesorder` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `invoice`
--

LOCK TABLES `invoice` WRITE;
/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` VALUES ('c6ea7b6d-fd39-4a9d-9c34-3257cc5fd65c','INV-2026-0001','ed0af680-bf81-4615-9b7c-52e9084df0d2','7689a925-73f8-4ed0-a31b-062ae0bc1b6a','01bad94b-2627-4b95-9b21-64000231a180','[{\"productId\":\"712e2fe9-7f66-4b75-b407-529a3eed37e6\",\"name\":\"IPHONE\",\"quantity\":100,\"unitPrice\":20000000,\"total\":2000000000}]',2000000000.000000000000000000000000000000,'PAID','2026-08-12 07:13:49.156','2026-08-12 07:35:27.126');
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `location`
--

DROP TABLE IF EXISTS `location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `location` (
  `id` varchar(191) NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `name` varchar(191) DEFAULT NULL,
  `warehouse` varchar(191) NOT NULL DEFAULT 'Main Warehouse',
  `zone` varchar(191) NOT NULL,
  `aisle` varchar(191) NOT NULL,
  `rack` varchar(191) NOT NULL,
  `shelf` varchar(191) NOT NULL,
  `bin` varchar(191) NOT NULL DEFAULT 'A1',
  `capacityType` varchar(191) NOT NULL DEFAULT 'Items',
  `maxCapacity` int(11) NOT NULL DEFAULT 1000,
  `occupied` int(11) NOT NULL DEFAULT 0,
  `status` varchar(191) NOT NULL DEFAULT 'Active',
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `deletedAt` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `location_companyId_fkey` (`companyId`),
  CONSTRAINT `location_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `location`
--

LOCK TABLES `location` WRITE;
/*!40000 ALTER TABLE `location` DISABLE KEYS */;
INSERT INTO `location` VALUES ('38c3da64-556f-40d8-918a-c90d98177acb','A-1-1-1-1','Bin A-1-1-1-1','demo warehouse','A','1','1','1','1','Items',500,0,'Active','01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 12:59:54.179','2026-08-11 12:59:54.179',NULL),('6442c27a-81a3-41c1-85cb-001b9609ea7f','B-1-1-1-1','Bin B-1-1-1-1','demo warehouse','B','1','1','1','1','Items',500,0,'Active','01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 13:00:12.262','2026-08-11 13:00:12.262',NULL),('e9193e0b-c657-4301-b709-ad545a6a6e85',NULL,'Loc-1','WH-1','A','1','1','1','A1','Items',1000,0,'Active','0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-07 09:42:50.440','2026-08-11 07:29:05.746','2026-08-11 07:29:05.743');
/*!40000 ALTER TABLE `location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locationinventory`
--

DROP TABLE IF EXISTS `locationinventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locationinventory` (
  `id` varchar(191) NOT NULL,
  `locationId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `lotId` varchar(191) DEFAULT NULL,
  `warehouseId` varchar(191) DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 0,
  `reserved` int(11) NOT NULL DEFAULT 0,
  `available` int(11) NOT NULL DEFAULT 0,
  `lotNumber` varchar(191) DEFAULT NULL,
  `batchNumber` varchar(191) DEFAULT NULL,
  `serialNumber` varchar(191) DEFAULT NULL,
  `expiryDate` datetime(3) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `locationinventory_locationId_productId_lotId_key` (`locationId`,`productId`,`lotId`),
  KEY `locationinventory_productId_fkey` (`productId`),
  KEY `locationinventory_lotId_fkey` (`lotId`),
  KEY `locationinventory_warehouseId_fkey` (`warehouseId`),
  KEY `locationinventory_companyId_fkey` (`companyId`),
  CONSTRAINT `locationinventory_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `locationinventory_locationId_fkey` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `locationinventory_lotId_fkey` FOREIGN KEY (`lotId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `locationinventory_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `locationinventory_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `warehouse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locationinventory`
--

LOCK TABLES `locationinventory` WRITE;
/*!40000 ALTER TABLE `locationinventory` DISABLE KEYS */;
INSERT INTO `locationinventory` VALUES ('b066c070-6153-47d4-9ba0-b513d6252da1','6442c27a-81a3-41c1-85cb-001b9609ea7f','712e2fe9-7f66-4b75-b407-529a3eed37e6','554620f5-ef9d-4c69-b355-dc3f54ca4713',NULL,490,0,490,NULL,NULL,NULL,NULL,'01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 13:02:04.173','2026-08-12 07:08:24.008');
/*!40000 ALTER TABLE `locationinventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notification` (
  `id` varchar(191) NOT NULL,
  `userId` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `title` varchar(191) NOT NULL,
  `message` varchar(191) NOT NULL,
  `read` tinyint(1) NOT NULL DEFAULT 0,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `notification_userId_fkey` (`userId`),
  KEY `notification_companyId_fkey` (`companyId`),
  CONSTRAINT `notification_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `notification_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
INSERT INTO `notification` VALUES ('4448d3c3-c9a5-4e51-b29d-c97eb81d1c25',NULL,'01bad94b-2627-4b95-9b21-64000231a180','New Order Request','A new order request (7af47e6d-f2c5-440e-9211-b42dde1bfcc6) has been placed and is pending review.',0,'2026-08-12 06:41:42.157'),('5f168edd-30d5-4354-90ad-30f758e355e7',NULL,'01bad94b-2627-4b95-9b21-64000231a180','Order Approved','Your order (7af47e6d-f2c5-440e-9211-b42dde1bfcc6) has been approved and is now being picked.',0,'2026-08-12 06:44:10.607'),('8bfbf2ad-4767-4dfd-be77-b617bfdc9ac8',NULL,'01bad94b-2627-4b95-9b21-64000231a180','Order Approved','Your order (ed0af680-bf81-4615-9b7c-52e9084df0d2) has been approved and is now being picked.',0,'2026-08-12 06:44:06.967'),('ec82763a-8e60-4b6f-a998-fff217dfcdb6',NULL,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','Order Rejected','Your order (d02f1adf-497d-4dd3-850e-3e9d1c10f2b8) was rejected. Reason: asdfg',0,'2026-08-11 07:21:44.051');
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picklist`
--

DROP TABLE IF EXISTS `picklist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picklist` (
  `id` varchar(191) NOT NULL,
  `orderId` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `picklist_companyId_fkey` (`companyId`),
  CONSTRAINT `picklist_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picklist`
--

LOCK TABLES `picklist` WRITE;
/*!40000 ALTER TABLE `picklist` DISABLE KEYS */;
INSERT INTO `picklist` VALUES ('21932aaf-e17c-44bd-bb28-bcba3c27d866','ed0af680-bf81-4615-9b7c-52e9084df0d2','PENDING','01bad94b-2627-4b95-9b21-64000231a180','2026-08-12 06:44:06.927','2026-08-12 06:44:06.927'),('c13f29a1-4c56-4208-9e80-808680179cfe','7af47e6d-f2c5-440e-9211-b42dde1bfcc6','COMPLETED','01bad94b-2627-4b95-9b21-64000231a180','2026-08-12 06:44:10.582','2026-08-12 07:08:24.123');
/*!40000 ALTER TABLE `picklist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picklistitem`
--

DROP TABLE IF EXISTS `picklistitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picklistitem` (
  `id` varchar(191) NOT NULL,
  `pickListId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `batchId` varchar(191) DEFAULT NULL,
  `binLocation` varchar(191) NOT NULL,
  `targetQuantity` int(11) NOT NULL,
  `pickedQuantity` int(11) NOT NULL DEFAULT 0,
  `picked` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `picklistitem_pickListId_fkey` (`pickListId`),
  KEY `picklistitem_productId_fkey` (`productId`),
  KEY `picklistitem_batchId_fkey` (`batchId`),
  CONSTRAINT `picklistitem_batchId_fkey` FOREIGN KEY (`batchId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `picklistitem_pickListId_fkey` FOREIGN KEY (`pickListId`) REFERENCES `picklist` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `picklistitem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picklistitem`
--

LOCK TABLES `picklistitem` WRITE;
/*!40000 ALTER TABLE `picklistitem` DISABLE KEYS */;
INSERT INTO `picklistitem` VALUES ('478d9521-45b9-4c94-bbdb-a073f6920817','c13f29a1-4c56-4208-9e80-808680179cfe','712e2fe9-7f66-4b75-b407-529a3eed37e6','554620f5-ef9d-4c69-b355-dc3f54ca4713','A-01-RACK-1',10,10,1),('7d95ab37-cbcb-45ab-9968-d8cdb1bb527c','21932aaf-e17c-44bd-bb28-bcba3c27d866','712e2fe9-7f66-4b75-b407-529a3eed37e6',NULL,'A-01-RACK-1',100,0,0);
/*!40000 ALTER TABLE `picklistitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product` (
  `id` varchar(191) NOT NULL,
  `sku` varchar(191) NOT NULL,
  `barcode` varchar(191) DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `description` varchar(191) DEFAULT NULL,
  `category` varchar(191) DEFAULT NULL,
  `categoryId` varchar(191) DEFAULT NULL,
  `unitCost` double NOT NULL DEFAULT 0,
  `wholesalePrice` double NOT NULL DEFAULT 0,
  `brand` varchar(191) DEFAULT NULL,
  `uom` varchar(191) NOT NULL DEFAULT 'Piece',
  `storageType` varchar(191) NOT NULL DEFAULT 'General Storage',
  `trackingMethod` varchar(191) NOT NULL DEFAULT 'None',
  `status` varchar(191) NOT NULL DEFAULT 'ACTIVE',
  `availableStock` int(11) NOT NULL DEFAULT 0,
  `committedStock` int(11) NOT NULL DEFAULT 0,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  `deletedAt` datetime(3) DEFAULT NULL,
  `attributes` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attributes`)),
  PRIMARY KEY (`id`),
  KEY `product_companyId_fkey` (`companyId`),
  KEY `product_categoryId_fkey` (`categoryId`),
  CONSTRAINT `product_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `product_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product`
--

LOCK TABLES `product` WRITE;
/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` VALUES ('01ac9b03-e60a-4cf6-9074-688998beb393','ORB-TRZ-15','663810733973','G2-TRZ 15mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('041f4b7c-327a-4b5b-8fe3-6aaa7c396338','test1',NULL,'Test Product',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('04ba1956-7bb0-4c7f-8845-4dc4f19ac90e','SYN-NAD-500',NULL,'NAD+',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('086e24d6-1d7d-4deb-9abe-67619bc82e00','SYN-TA1-10','663810734581','Thymosin Alpha 1 - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('09b7b3bd-1a0b-416f-975c-aefc438d5e6f','ORB-SURV-10','663810733676','Survodutide 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('0bc2fb0e-31d8-4846-9306-b2b8a5a235d8','ORB-CORT20','663810733935','Cortagen 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('0c6d0213-6f71-41b2-94b9-44e484e7eba2','ORB-LOGO-XXL','663810733232','Logo Tee - XXL',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('0d4c4750-2ce9-41fb-9ea6-b8b66843defd','ORB-SELA-30','663810733522','Selank 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('0dd802ba-7149-41ab-96d4-f08d38973e7e','ORB-CJC-1295','663810733423','CJC-1295 (no DAC) + IPA',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('0e704a9c-f0c4-444f-86eb-889479104704','ORB-BACT-30','663810733485','Bacteriostic Water 30ml',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('1148491c-8bd1-40a3-98c5-8f91b3309f55','ORB-5KIT-PNK','663810734147','Lab Storage Case - 5 slot - pink/white',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('11ce42ab-6fa7-4b45-892a-3610d0b908ef','ORB-GLUT-1500','663810733638','Glutathione 1500mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('11ea9570-226d-4693-b5cb-7b08e38b55ff','SYN-MT2-2','663810734413','MT2 (Melanotan 2)',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('122fdc16-42ec-4957-acbb-c08233572596','SYN-AOD-9604','663810734192','AOD-9604',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('13ffec0b-70f9-4205-8c01-89ba02765bbf','ORB-DIVE-S','663810734383','Graphic Tee - Diver\'s Pride - S',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('151b96af-3190-447c-b3b9-9b947229e17c','ORB-CAX-20','663810733928','Cartalax 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('17ef612f-e4f2-425e-abac-cd43f5d86dda','SYN-DSIP-10','663810734260','DSIP - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('1b3946f5-ea5a-4b43-b6ca-4d817156df45','ORB-SLU-5','663810733348','SLU-PP-332 5mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('1c30e485-ab19-462c-8af6-37c91568bf68','SYN-LCARN','663810734079','L-Carnitine',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('1f141553-471f-4203-810c-9f59ff2fe24b','ORB-ROSIE-L','663810734116','Graphic Tee - Rosie the Researcher - L',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('1f1aaf75-3139-4689-9df0-8ea0dc00aa81','ORB-BNAD500','663810733805','NAD Buffered',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('1f86c91a-b7fc-4c83-b3f9-5219fa782244','ORB-CAG-10','663810733379','Cag-10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('21cae578-a1e6-4b5a-adfe-54a3db213eda','ORB-SERM-10','663810733409','Sermorelin 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('225e739e-c40e-4df8-808e-b3fe33a0afb7','SYN-BAC-30','663810734451','Reconstitution Solution - 30ml',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('237946a3-cb96-4a14-a2f9-c8f2ac7b23d6','ORB-SX-10','663810733515','Semax 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('24aaee86-a704-4783-a94c-3ac3407ba146','ORB-EPIT-50','663810733607','Epithalon - 50mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('263f2361-07bc-4b5f-a4e9-60e355cb246e','ORB-INSU','663810734642','Insulated Shaker Bottle',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('26862271-5d7b-4ab4-b1eb-0e42d0cf5409','ORB-PT141-10','663810733447','PT-141 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('2b06db78-7034-4225-a8f0-fd9b502e3ced','SYN-SS-50','663810734567','MitoSS-31 - 50mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('2cd248e6-7251-49ef-b6c5-6752d88644aa','ORB-SX-30','663810733508','Semax 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('2e6b79b0-9b93-41ef-a7f0-c8227e806a3c','SYN-RELA','663810734468','Relaxation Blend',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('33acea3e-09ff-4d26-bd64-8a140f9789c8','SYN-RETA-40','663810734505','GLP-3R - 40mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('35fa652c-d511-4be0-a99d-64e39220023f','SYN-IGF-1','663810734390','IGF-1 LR3',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('382b1440-078d-473a-8214-54cb0d367929','ORB-LOGO-L','663810733898','Logo Tee - L',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('388d4afb-b28e-4817-b710-9f07c61ba487','ORB-LOGO-S','663810733874','Logo Tee - S',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('39000f2e-0a95-4707-8c1f-b824cdc736e8','ORB-SEMA-20','663810733478','1G-SGT 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('3a366654-eab4-4a3d-be37-069ecd003fcd','ORB-EPIT-20','663810733591','Epithalon - 20 mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('3b1f6482-ce08-4164-8403-ccdcf41c3e1d','ORB-CASE-NEPTUN','663810733294','Lab Storage Case - 10+1 - neptune/gold',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('3d6a403e-8b6a-4767-ba90-b8a0b1a2d42e','SYN-MISC-FOCU','663810733249','Focus Blend',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('3f807310-747b-4454-8718-acaaf30e5eea','ORB-CASE-PINKWH','663810733256','Lab Storage Case - 10+1 - pink/white',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('42f7c90e-38bc-4bf0-a176-c211032995d1','SYN-CAG-10','663810734246','Cagrilintide (Amylin Analogue)',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('43b4769f-ed49-42ea-8950-a6e3edb8be40','SYN-TESA-10','663810734598','Tesamorelin - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('45fb99d5-b6b0-4152-8be3-30f9bad60640','ORB-ROSIE-S','663810734062','Graphic Tee - Rosie the Researcher - S',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('462fde69-c6ab-4352-b491-f92670e0f665','ORB-IPA-10','663810733959','Ipamorelin 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('4847faed-6c2b-454b-bd94-be2ea7b95cb1','SYN-CJCIPA-10',NULL,'CJC-1295 (No DAC) + Ipamorelin',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('48a7fab4-df76-4a2f-a1c7-5a449f1b6b41','SYN-BUNDL','663810734321','Copper GHk-Cu Hair Care Bundle',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('4a1f34ac-89eb-4b60-b15a-97a8715e5b76','SYN-BPC-TB-10','663810734222','BPC-157 + TB-500 - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('4d4201bd-8cd8-4c30-aa91-adfde6721e27','ORB-LOGO-M','663810733881','Logo Tee - M',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('519a47e3-75e2-413d-b480-3d75d90089ec','ORB-ARA-290','663810733447','ARA-290',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('51ae45c6-a068-496e-8494-bc3afd449719','ORB-BENC','663810733850','Bench Towel',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('52559ed4-155b-4959-9a4e-dff8c9ad0fb5','SYN-FRAG-176','663810734284','Frag 176-191',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('539b1cd8-366a-4af5-b543-34a62a803d9d','SYN-SUPE','663810734574','Superhuman Blend',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('5654e99b-46f3-481d-b401-395ec83b18a0','ORB-LL-37','663810733324','LL-37 5mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('56b1d4c9-174c-4a53-8253-fe06b5d429b1','ORB-TA1-10','663810733706','Thymosin Alpha-1 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('59e7cfbf-acb8-4b2c-aa46-c20468f24d14','ORB-DIVE-M','663810734604','Graphic Tee - Diver\'s Pride - M',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('5c75fe83-c6ac-4618-ae5d-ebe6fd9d67d3','SYN-RETA-20','663810734482','GLP-3R - 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('5ce8abe7-1768-4b16-89fe-2cee5df24007','ORB-DIVE-L','663810734628','Graphic Tee - Diver\'s Pride - L',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('5ceb9d4a-4faf-48e6-8c8c-f090121c426f','SYN-TAB-SLU1','663810734536','SLU-PP-332 Tablets - 1mg - 100 Tablets',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('5e93ba6b-b740-4c58-8a17-d2d8fd4d71f9','ORB-CASE-HOTPIN','663810733287','Lab Storage Case - 10+1 - hot pink/white',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('68c4a4d4-473c-4bbe-8278-577ff5a2f4d3','ORB-NAD-500','663810733386','NAD+ 500mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('6945d9b4-67ca-4bd3-84dd-bc64e18a7460','SYN-TAB-SLU5','663810734543','SLU-PP-332 Tablets - 5mg - 100 Tablets',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('6c216d61-37f1-4652-a46e-f5559bd3bddb','ORB-TB500-10','663810733317','TB-500 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('6d040e1f-38fe-4a24-9983-b5eb7067ea67','ORB-LCAR-5000','663810733744','L-Carnitine 5000mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('6d1be9c6-593d-4bdf-be02-818785afd0b3','ORB-SELA-10','663810733546','Selank 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('6ea2d1d0-d6a9-4e1f-bc35-f17e66ad77da','SYN-1S-5','663810734352','GLP-1S - 5mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('6f99e56c-af31-40f6-9633-61bb05246f24','ORB-VILO-20','663810733577','Vilon 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('70110aaa-ac99-4db3-b1cc-2932d6b5ab8b','P2',NULL,'Prod 2',NULL,NULL,'69e0b5ce-9897-4c8d-bef8-fc0a175e3600',0,0,NULL,'Piece','General Storage','None','ACTIVE',50,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-07 09:42:50.504','2026-08-11 07:19:44.682','2026-08-11 07:19:44.680',NULL),('712e2fe9-7f66-4b75-b407-529a3eed37e6','ASF12324','12436Y568','IPHONE','IPHONE 17 PRO',NULL,'8996de16-77dd-453f-ae15-5d9d0aaebe06',1000000,20000000,NULL,'Piece','General Storage','None','ACTIVE',490,0,'01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 13:02:04.148','2026-08-12 07:30:52.347',NULL,'{}'),('712f9c06-8120-49ec-8c10-256f622f6ccd','SYN-MOTS-40','663810733737','MOTS-c - 40 mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('71e5bdc1-f2d4-4b42-8505-0633c07c33c8','ORB-MOTSC-40','663810733683','MOTS-c 40mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('72c77538-335f-4a0b-945b-f83a02809ece','60-ACE1125',NULL,'Acetic Acid',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('734bacb2-9c92-4347-a156-5863a8f6dc3f','ORB-AOD-9604','663810733683','AOD-9604 5mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('7493c4e2-f51c-451a-9c25-8e75b039f06c','80-EPI40526',NULL,'Epithalon',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('74c7245f-a432-4e06-ae7d-1d5127bfa02c','SYN-TESA','663810734611','Tesamorelin + Ipamorelin',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('75baee66-1bd4-4d8f-b7c2-27800004c851','SYN-TABBPC-5','663810734215','BPC-157 Tablets',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('780e93dd-71e1-4ced-953f-2d7f699a64c5','SYN-BPC-10','663810734208','BPC-157 - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('7abb52e5-4be0-4624-8e13-de06db5c5dd6','SYN-SX-10','663810734512','Semax - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('7aeb03e4-d97d-4c62-9435-525c9b28d71b','ORB-SEMA-10','663810733300','1G-SGT 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('7c4550eb-713b-472b-a237-e3899062af5f','ORB-VIP-10','663810733430','VIP 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('801cf389-3db3-4415-88c2-97f5b58c160f','ORB-SS-50','663810734161','MTP-31 50mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('81fd38d5-6835-49e6-938f-4680b4c486a4','ORB-MISC-FOCU','663810733812','Focus Blend',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('82ca9215-500a-415c-9182-5bf824a59d9c','SYN-SHAMP','663810734314','Copper Surge GHk-Cu Shampoo',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('838bffe4-bd07-42b1-beff-6cc01f9926f8','ORB-GLOW-70','663810733355','GLOW 70',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('8663843c-f0b3-4e11-9400-4386226147a5','ORB-FOXO-4','663810733690','FOXO4-DRI 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('8b3edc3d-5e4a-4823-8888-7204ecb90ba3','ORB-CASE-GREENB','663810733270','Lab Storage Case - 10+1 - green/black',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('8d451f5b-a05f-4a3d-831c-d0df776e0696','ORB-RETA-20','663810733829','3G-RT 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('8fd3c721-6c92-4874-94d2-7a345dc237be','SYN-CJC-1295','663810734253','CJC-1295 (No DAC)',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('90226917-bd6e-434c-9a05-997ce57e9723','SYN-SX-30','663810734529','Semax - 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9085f8f6-374d-4bb9-ac69-07bc9b2f36ca','SYN-CONDIT','663810734307','Copper Restore GHK-Cu Conditioner',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9672c656-fc68-4459-bb28-f73c4860bed5','ORB-5KIT-NEPT','663810734093','Lab Storage Case - 5 slot - neptune/gold',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9a9cc644-0d39-41a4-9761-05497351d078','ORB-DIVE-XL','663810734031','Graphic Tee - Diver\'s Pride - XL',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9b3ac201-7cfe-4d05-9a8b-005b24ae0697','SYN-RETA-10','663810734369','GLP-3R - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9c0adb80-0315-4059-a21e-728d391af173','ORB-GHK-50','663810733331','GHK-Cu 50mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9eecd214-00c8-461f-ad54-20521c2c4e68','ORB-DIVE-XXL','663810734055','Graphic Tee - Diver\'s Pride - XXL',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('9f516441-91f4-4209-9951-3514b6e3c8e0','ORB-OXYT-2','663810733768','Oxytocin 2mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a3c290e9-62e4-460d-a2a9-bd554abbd2e2','SYN-TIRZ-15',NULL,'GLP-2T',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a43a0992-2fd0-47fd-baad-e8c7126f16b7','SYN-PT-141','663810733645','PT-141',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a43a5c57-098b-4b2f-a371-b95223a2f6ee','ORB-TRZ-30','663810733980','G2-TRZ 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a484260c-5cc1-4354-96b7-ddd755b2dea7','SYN-IPAM-10','663810733416','Ipamorelin 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a5c8df4c-0b65-4d62-8a77-fa88c4c86e95','ORB-ACE10','663810733751','Acetic Acid Solution',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a631c84e-566d-4e58-b6c5-3337e111be57','ORB-EPIT-10','663810733584','Epithalon 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('a904bbe0-a59b-4837-bd98-93d281a989c3','SYN-RETA-30','663810734499','GLP-3R - 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('acd63a90-04d0-4d8b-85ad-e769cb503de2','ORB-LOGO-XL','663810733904','Logo Tee - XL',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('aea531f8-f0ee-4f88-b0ed-6f21afc8cf86','ORB-KPV-10','663810733843','KPV 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('afd71412-5aa2-454c-8c25-be0ab991a0fc','ORB-PHOS-100','663810734130','Phosphate-buffered Saline (PBS) 100ml',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b1fad86f-4c85-42b3-8497-3bf5ac405331','SYN-CREAM','663810734291','Copper Renewal Cream',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b27e93f6-6cb0-44e6-b8e6-93e0de0d6b63','ORB-BPC-10','663810733225','BPC-157 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b6353c2d-8d3e-4248-90b8-bc4749d62d9a','SYN-NAD-BUFF-500',NULL,'NAD+ (Buffered)',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b64e6a82-b75a-4a0f-b957-69357bfe7e2f','ORB-RETA-10','663810733799','3G-RT 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b749de7d-d23b-4c2b-b405-a1baafc17a91','SYN-KPV','663810733621','KPV',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b7a08f22-2a30-4b2a-b751-7aeba701a785','ORB-5AM-10','663810733652','5-amino-1mq 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b7a224e9-b629-4013-8e23-c6d9b12722aa','SYN-BAC-10','663810734444','Reconstitution Solution - 10ml',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('b8441de6-71a7-4ed2-adec-d4600d360a0b','P1',NULL,'Prod 1',NULL,NULL,'69e0b5ce-9897-4c8d-bef8-fc0a175e3600',0,0,NULL,'Piece','General Storage','None','ACTIVE',100,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-07 09:42:50.483','2026-08-11 07:19:46.784','2026-08-11 07:19:46.783',NULL),('b9c815d2-5ec3-425d-8aaa-9721eddcd604','ORB-CAP-TESO','663810734635','Tesofensine 500mcg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('bc945144-e353-4b1d-bdc8-58599949915c','ORB-NSX-10','663810733492','N-acetyl Semax Amidate 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('bdefeb9b-4409-43a2-9f09-a97123508998','SYN-GHK-50',NULL,'GHK-Cu',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('c13093df-9084-4cae-9cde-cff5dcd0f6a8','ORB-SS-10','663810734154','MTP-31 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('c627aa39-7f34-42f2-a36e-07e12e13a6ab','ORB-ROSIE-M','663810734048','Graphic Tee - Rosie the Researcher - M',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('c7162c7f-71d2-4aac-87ec-638144d866a9','SYN-SS-10','663810734550','MitoSS-31 - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('cace0e10-2053-428e-8caf-4e6e7128d3ec','ORB-ADAM-10','663810733843','Adamax 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('cadb1ea6-6e3c-45ad-97ae-afcd66040f0f','SYN-BPC-TB-20','663810734239','BPC-157 + TB-500 - 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('cbabf6c1-0037-429e-865a-73096952c0e8','SYN-GLOW-70','663810734338','Glow 70 Blend',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('cedfc3fc-6330-4d57-98f0-5185e063c621','SYN-GLUT','663810734376','Glutathione',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d097b22a-6055-4d06-b4ec-49472b350f6c','SYN-MOTS-10','663810734406','MOTS-C - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d29dc8b0-0a69-41ef-b0ad-49221a05151a','ORB-ROSIE-XXL','663810733867','Graphic Tee - Rosie the Researcher - XXL',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d2ac39ce-07c1-44a6-9d96-e299e9156704','ORB-CASE-GALAXY','663810733263','Lab Storage Case - 10+1 - galaxy',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d325338b-b75f-45ee-b96e-251df0c516e8','ORB-NSX-30','663810734437','NA Semax Amidate 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d3605d43-d00e-4efc-b2a5-bfa1719e6494','SYN-5AM-10','663810734178','5-Amino-1MQ - 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d3e8bb0a-170f-4964-afae-66f1a491c620','SYN-KLOW-80',NULL,'KLOW 80',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d656edf5-8cb6-43e4-8ba6-9f6482706be8','ORB-NSEL-30','663810734420','NA Selank Amidate 30mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d6e0877d-6639-41ee-9b16-32955f33703b','ORB-TESA-10','663810733393','Tesa-10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d8e897de-1fe0-4db5-80a4-75cef140eee6','ORB-PINE','663810733560','Pinealon',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('d9cf34de-6290-4e79-a545-2461532141eb','ORB-SOMA','663810733782','SomatoPulse',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('dc304a08-2988-4568-b8a1-341f67060432','SYN-RETA-15','663810734475','GLP-3R - 15mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('dc5ed09a-4996-41ea-bf10-0283aa3a9645','ORB-ORBI-40','663810734659','Orbitzen 40',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('dc6ff4da-7347-416b-ab46-e611b4eeef38','SYN-1S-15','663810734345','GLP-1S - 15mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('de753f50-a5ca-49b0-b983-609f0d95464e','ORB-CAPSLU','663810733911','SLU-PP-332 1000mcg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('de9e993b-bec9-4836-9c91-3b9371d239de','ORB-TRZ-60','663810733997','G2-TRZ 60mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('df096d49-b429-4bea-8e62-e5e354c42ae0','ORB-5AM-50','663810733720','5-amino-1mq - 50mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('e01ed38a-80ad-4704-8abf-bb2ada3bf88b','SYN-EPIT-40','663810734277','Epithalon - 40mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('e4a09c29-c011-48e4-9b5d-837ab68081fa','ORB-RETA-36','663810733836','3G-RT 36mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('e4a777a4-702e-4f90-8a03-9470eac5e65a','ORB-5KIT-GAL','663810734000','Lab Storage Case - 5 slot - galaxy',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('e7790c90-c9eb-4f79-93c7-1c4f4900cb78','ORB-BPC-TB-20','663810733775','Wolverine 20mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('e95e1baf-2b7e-44a4-97d3-c8c5599f3238','ORB-KISS','663810733614','Kisspeptin',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('eb301cc1-b42b-48b4-b316-f67929ca48b6','SYN-CAP5AM','663810734185','5-Amino-1MQ Tablets',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('ec7eb017-473a-4d02-bb36-d00f109557ee','ORB-KLOW','663810733362','KLOW',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('ed77cff0-acae-4c2b-8e2f-1ef77acaef2e','ORB-LIPO','663810733669','LIPO-C',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('ee07cf0f-ba08-4ad8-91a6-3f82aab0583d','DERIVED-PROCESSING-FEE-SHIPPING-PROTECTION',NULL,'Processing Fee / Shipping Protection',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('eed1ffee-1eb2-40d7-8df7-10c0f94857c5','ORB-TRZ-10','663810733966','G2-TRZ 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f13dc7a4-ca81-4da4-9156-9f55ec7e7ea1','ORB-5KIT-GRN','663810734024','Lab Storage Case - 5 slot - green/black',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f60b4f3e-0c5a-4ca1-ae01-3bb3db9f0c6d','ORB-MOTS-10','663810733553','MOTS-c - 10 mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f60e93a8-336d-484f-b989-5435cd049c54','ORB-NSEL-10','663810733539','N-acetyl Selank Amidate 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f6adcc73-102c-4957-bc07-d265bd1ff47d','ORB-MT-2','663810733461','MT-II',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f7d36843-632a-40fc-8c9f-bc9be845adec','ORB-ORBI','663810734123','Orbitrex Hat',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f8d9e174-aaa6-4c6a-a211-6e36747ddc0f','ORB-ROSIE-XL','663810734109','Graphic Tee - Rosie the Researcher - XL',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('f8ddd40c-6c21-4aa3-87c2-0718a2cddcfb','ORB-MT-1','663810733454','MT-1',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL),('fd149a69-5519-4c93-9836-e257e9796626','ORB-DSIP-10','663810733713','DSIP 10mg',NULL,NULL,NULL,0,0,NULL,'Piece','General Storage','None','ACTIVE',0,0,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:19:07.505','2026-08-12 07:26:37.191',NULL,NULL);
/*!40000 ALTER TABLE `product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `productspecification`
--

DROP TABLE IF EXISTS `productspecification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `productspecification` (
  `id` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `weight` double DEFAULT NULL,
  `length` double DEFAULT NULL,
  `width` double DEFAULT NULL,
  `height` double DEFAULT NULL,
  `volume` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `productspecification_productId_key` (`productId`),
  CONSTRAINT `productspecification_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `productspecification`
--

LOCK TABLES `productspecification` WRITE;
/*!40000 ALTER TABLE `productspecification` DISABLE KEYS */;
/*!40000 ALTER TABLE `productspecification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseorder`
--

DROP TABLE IF EXISTS `purchaseorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaseorder` (
  `id` varchar(191) NOT NULL,
  `poNumber` varchar(191) NOT NULL,
  `supplier` varchar(191) NOT NULL,
  `expectedDelivery` datetime(3) DEFAULT NULL,
  `totalCost` double NOT NULL DEFAULT 0,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `purchaseorder_poNumber_key` (`poNumber`),
  KEY `purchaseorder_companyId_fkey` (`companyId`),
  CONSTRAINT `purchaseorder_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorder`
--

LOCK TABLES `purchaseorder` WRITE;
/*!40000 ALTER TABLE `purchaseorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchaseorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `purchaseorderitem`
--

DROP TABLE IF EXISTS `purchaseorderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `purchaseorderitem` (
  `id` varchar(191) NOT NULL,
  `purchaseOrderId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `quantity` int(11) NOT NULL,
  `unitCost` double NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `purchaseorderitem_purchaseOrderId_fkey` (`purchaseOrderId`),
  KEY `purchaseorderitem_productId_fkey` (`productId`),
  CONSTRAINT `purchaseorderitem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `purchaseorderitem_purchaseOrderId_fkey` FOREIGN KEY (`purchaseOrderId`) REFERENCES `purchaseorder` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `purchaseorderitem`
--

LOCK TABLES `purchaseorderitem` WRITE;
/*!40000 ALTER TABLE `purchaseorderitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `purchaseorderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receiving`
--

DROP TABLE IF EXISTS `receiving`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receiving` (
  `id` varchar(191) NOT NULL,
  `receivingNumber` varchar(191) NOT NULL,
  `poNumber` varchar(191) DEFAULT NULL,
  `supplier` varchar(191) NOT NULL,
  `warehouse` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `receivedAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `inspectorId` varchar(191) DEFAULT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdBy` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `receiving_receivingNumber_key` (`receivingNumber`),
  KEY `receiving_companyId_fkey` (`companyId`),
  KEY `receiving_inspectorId_fkey` (`inspectorId`),
  CONSTRAINT `receiving_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `receiving_inspectorId_fkey` FOREIGN KEY (`inspectorId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receiving`
--

LOCK TABLES `receiving` WRITE;
/*!40000 ALTER TABLE `receiving` DISABLE KEYS */;
/*!40000 ALTER TABLE `receiving` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receivingitem`
--

DROP TABLE IF EXISTS `receivingitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `receivingitem` (
  `id` varchar(191) NOT NULL,
  `receivingId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `expectedQty` int(11) NOT NULL,
  `receivedQty` int(11) NOT NULL DEFAULT 0,
  `acceptedQty` int(11) NOT NULL DEFAULT 0,
  `rejectedQty` int(11) NOT NULL DEFAULT 0,
  `rejectionReason` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  KEY `receivingitem_receivingId_fkey` (`receivingId`),
  KEY `receivingitem_productId_fkey` (`productId`),
  CONSTRAINT `receivingitem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `receivingitem_receivingId_fkey` FOREIGN KEY (`receivingId`) REFERENCES `receiving` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receivingitem`
--

LOCK TABLES `receivingitem` WRITE;
/*!40000 ALTER TABLE `receivingitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `receivingitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesorder`
--

DROP TABLE IF EXISTS `salesorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesorder` (
  `id` varchar(191) NOT NULL,
  `orderNumber` varchar(191) DEFAULT NULL,
  `clientId` varchar(191) NOT NULL,
  `companyId` varchar(191) NOT NULL,
  `priority` varchar(191) DEFAULT 'NORMAL',
  `status` varchar(191) NOT NULL DEFAULT 'PENDING_REVIEW',
  `rejectionReason` varchar(191) DEFAULT NULL,
  `totalCost` double NOT NULL DEFAULT 0,
  `shippingAddress` varchar(191) DEFAULT NULL,
  `poNumber` varchar(191) DEFAULT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `salesorder_orderNumber_key` (`orderNumber`),
  KEY `salesorder_clientId_fkey` (`clientId`),
  KEY `salesorder_companyId_fkey` (`companyId`),
  CONSTRAINT `salesorder_clientId_fkey` FOREIGN KEY (`clientId`) REFERENCES `client` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `salesorder_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesorder`
--

LOCK TABLES `salesorder` WRITE;
/*!40000 ALTER TABLE `salesorder` DISABLE KEYS */;
INSERT INTO `salesorder` VALUES ('7af47e6d-f2c5-440e-9211-b42dde1bfcc6',NULL,'7689a925-73f8-4ed0-a31b-062ae0bc1b6a','01bad94b-2627-4b95-9b21-64000231a180','NORMAL','PACKING',NULL,200000000,'sdgf, Birmingham, Alabama, United States, PIN: 35203','123456789','asdfghjk','2026-08-12 06:41:42.123','2026-08-12 07:08:24.134'),('ed0af680-bf81-4615-9b7c-52e9084df0d2','SO-2026-4192','7689a925-73f8-4ed0-a31b-062ae0bc1b6a','01bad94b-2627-4b95-9b21-64000231a180','NORMAL','SHIPPED',NULL,2000000000,'United States','1234tasdf','asdfghjkl | Carrier: Standard Freight | Payment Term: Credit Line (Net-30) | Min Expiry: No Preference','2026-08-12 06:42:01.164','2026-08-12 07:13:49.103');
/*!40000 ALTER TABLE `salesorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salesorderitem`
--

DROP TABLE IF EXISTS `salesorderitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `salesorderitem` (
  `id` varchar(191) NOT NULL,
  `salesOrderId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `salesorderitem_salesOrderId_fkey` (`salesOrderId`),
  KEY `salesorderitem_productId_fkey` (`productId`),
  CONSTRAINT `salesorderitem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `salesorderitem_salesOrderId_fkey` FOREIGN KEY (`salesOrderId`) REFERENCES `salesorder` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salesorderitem`
--

LOCK TABLES `salesorderitem` WRITE;
/*!40000 ALTER TABLE `salesorderitem` DISABLE KEYS */;
INSERT INTO `salesorderitem` VALUES ('81de3e2c-fc6d-49b8-b5d6-8b9062a732af','ed0af680-bf81-4615-9b7c-52e9084df0d2','712e2fe9-7f66-4b75-b407-529a3eed37e6',100),('d5756d99-a20a-4b47-8294-2b10a133cfa5','7af47e6d-f2c5-440e-9211-b42dde1bfcc6','712e2fe9-7f66-4b75-b407-529a3eed37e6',10);
/*!40000 ALTER TABLE `salesorderitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `shipment`
--

DROP TABLE IF EXISTS `shipment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `shipment` (
  `id` varchar(191) NOT NULL,
  `trackingNumber` varchar(191) NOT NULL,
  `carrier` varchar(191) NOT NULL,
  `orderId` varchar(191) NOT NULL,
  `recipient` varchar(191) NOT NULL,
  `destination` varchar(191) NOT NULL,
  `estimatedDelivery` varchar(191) DEFAULT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'LABEL_CREATED',
  `labelUrl` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `shipment_trackingNumber_key` (`trackingNumber`),
  KEY `shipment_companyId_fkey` (`companyId`),
  CONSTRAINT `shipment_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `shipment`
--

LOCK TABLES `shipment` WRITE;
/*!40000 ALTER TABLE `shipment` DISABLE KEYS */;
INSERT INTO `shipment` VALUES ('076a0f8e-a252-4246-bdbd-e708b6a5d873','SS-TRACK-14119','UPS Express','ed0af680-bf81-4615-9b7c-52e9084df0d2','cleint demoo','cleint demoo Warehouse, Hub 4','2026-08-15','LABEL_CREATED','https://mock.shipstation.com/labels/sample.pdf','01bad94b-2627-4b95-9b21-64000231a180','2026-08-12 07:13:49.017','2026-08-12 07:13:49.017');
/*!40000 ALTER TABLE `shipment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stockadjustment`
--

DROP TABLE IF EXISTS `stockadjustment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stockadjustment` (
  `id` varchar(191) NOT NULL,
  `adjustmentNumber` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `lotId` varchar(191) NOT NULL,
  `locationId` varchar(191) NOT NULL,
  `quantityDelta` int(11) NOT NULL,
  `reasonCode` varchar(191) NOT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `createdBy` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  PRIMARY KEY (`id`),
  UNIQUE KEY `stockadjustment_adjustmentNumber_key` (`adjustmentNumber`),
  KEY `stockadjustment_productId_fkey` (`productId`),
  KEY `stockadjustment_lotId_fkey` (`lotId`),
  KEY `stockadjustment_locationId_fkey` (`locationId`),
  KEY `stockadjustment_createdBy_fkey` (`createdBy`),
  KEY `stockadjustment_companyId_fkey` (`companyId`),
  CONSTRAINT `stockadjustment_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockadjustment_createdBy_fkey` FOREIGN KEY (`createdBy`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockadjustment_locationId_fkey` FOREIGN KEY (`locationId`) REFERENCES `location` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockadjustment_lotId_fkey` FOREIGN KEY (`lotId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `stockadjustment_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stockadjustment`
--

LOCK TABLES `stockadjustment` WRITE;
/*!40000 ALTER TABLE `stockadjustment` DISABLE KEYS */;
/*!40000 ALTER TABLE `stockadjustment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `systemsettings`
--

DROP TABLE IF EXISTS `systemsettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `systemsettings` (
  `id` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  `value` text NOT NULL,
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_key_key` (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `systemsettings`
--

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;
INSERT INTO `systemsettings` VALUES ('57c25cdd-f6ed-4290-8c33-693a71851846','CARRIERS','[\"FedEx Freight\",\"UPS Express\",\"DHL Supply Chain\",\"XPO Logistics\",\"Blue Dart\",\"Delhivery\"]','2026-08-11 06:23:05.674');
/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferitem`
--

DROP TABLE IF EXISTS `transferitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferitem` (
  `id` varchar(191) NOT NULL,
  `transferId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `lotId` varchar(191) NOT NULL,
  `quantity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transferitem_transferId_fkey` (`transferId`),
  KEY `transferitem_productId_fkey` (`productId`),
  KEY `transferitem_lotId_fkey` (`lotId`),
  CONSTRAINT `transferitem_lotId_fkey` FOREIGN KEY (`lotId`) REFERENCES `batch` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transferitem_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transferitem_transferId_fkey` FOREIGN KEY (`transferId`) REFERENCES `inventorytransfer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferitem`
--

LOCK TABLES `transferitem` WRITE;
/*!40000 ALTER TABLE `transferitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transferorder`
--

DROP TABLE IF EXISTS `transferorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferorder` (
  `id` varchar(191) NOT NULL,
  `sourceCompanyId` varchar(191) NOT NULL,
  `destinationCompanyId` varchar(191) NOT NULL,
  `productId` varchar(191) NOT NULL,
  `quantity` int(11) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'PENDING',
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `transferorder_sourceCompanyId_fkey` (`sourceCompanyId`),
  KEY `transferorder_destinationCompanyId_fkey` (`destinationCompanyId`),
  KEY `transferorder_productId_fkey` (`productId`),
  CONSTRAINT `transferorder_destinationCompanyId_fkey` FOREIGN KEY (`destinationCompanyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transferorder_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `product` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `transferorder_sourceCompanyId_fkey` FOREIGN KEY (`sourceCompanyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferorder`
--

LOCK TABLES `transferorder` WRITE;
/*!40000 ALTER TABLE `transferorder` DISABLE KEYS */;
/*!40000 ALTER TABLE `transferorder` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password` varchar(191) NOT NULL,
  `role` varchar(191) NOT NULL,
  `status` varchar(191) NOT NULL DEFAULT 'ACTIVE',
  `phone` varchar(191) DEFAULT NULL,
  `jobTitle` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) DEFAULT NULL,
  `warehouseId` varchar(191) DEFAULT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_email_key` (`email`),
  KEY `user_companyId_fkey` (`companyId`),
  KEY `user_warehouseId_fkey` (`warehouseId`),
  CONSTRAINT `user_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_warehouseId_fkey` FOREIGN KEY (`warehouseId`) REFERENCES `warehouse` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('43e8f8fe-99b3-4150-b162-164cff928281','Manager','stitchmanager@gmail.com','x','WAREHOUSE_MANAGER','ACTIVE',NULL,NULL,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35',NULL,'2026-08-07 09:42:50.350','2026-08-11 07:40:39.997'),('57e1142a-f8c3-4889-92f3-23703f7b9a1c','Clerk','stitchclerk@gmail.com','x','INVENTORY_CLERK','ACTIVE',NULL,NULL,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35',NULL,'2026-08-07 09:42:50.365','2026-08-11 07:40:40.006'),('6d065f89-c2de-4086-993a-139450ccb653','demo ','m@gmail.com','$2b$10$Ist57jPDBasbr9x0vIj3n.QPWF4kLrD17QEzSEYuZGHn61Eb21v36','WAREHOUSE_MANAGER','ACTIVE','+1 12345678','manager','01bad94b-2627-4b95-9b21-64000231a180',NULL,'2026-08-11 12:50:16.769','2026-08-11 12:50:16.769'),('d69450a5-edd8-47ad-8057-c5e7a79de357','Super Admin','alex@stitchnexus.com','$2b$10$3CkY9wKQ4knyZcf.T.gkhuSsAEYPXG.XaCXtZJLOtc2eXVn56GdXK','SUPER_ADMIN','ACTIVE',NULL,NULL,'0865134b-9d8b-4f9e-bc54-8eaa88f74d35',NULL,'2026-08-11 07:35:05.402','2026-08-11 07:38:15.521'),('f28c3bdf-923c-47a6-ac3c-eeb2f28df3b5','clerk demo','clerk@gmail.com','$2b$10$uj2Z5lKRF0Nj0vk1zaCREOEP7yIAoPjWgvjW18zaxK3BnONfdRxvS','INVENTORY_CLERK','ACTIVE','+1 243345454','clerk','01bad94b-2627-4b95-9b21-64000231a180','abefdc82-92cc-401b-9061-efba9898b81a','2026-08-11 13:12:32.367','2026-08-11 13:12:32.367');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `warehouse`
--

DROP TABLE IF EXISTS `warehouse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `warehouse` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `city` varchar(191) DEFAULT NULL,
  `state` varchar(191) DEFAULT NULL,
  `country` varchar(191) DEFAULT NULL,
  `zipCode` varchar(191) DEFAULT NULL,
  `managerName` varchar(191) DEFAULT NULL,
  `managerId` varchar(191) DEFAULT NULL,
  `contactPhone` varchar(191) DEFAULT NULL,
  `capacityType` varchar(191) DEFAULT NULL,
  `capacityValue` double DEFAULT NULL,
  `facilityType` varchar(191) DEFAULT NULL,
  `supportedItems` varchar(191) DEFAULT NULL,
  `companyId` varchar(191) NOT NULL,
  `createdAt` datetime(3) NOT NULL DEFAULT current_timestamp(3),
  `updatedAt` datetime(3) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `warehouse_companyId_fkey` (`companyId`),
  KEY `warehouse_managerId_fkey` (`managerId`),
  CONSTRAINT `warehouse_companyId_fkey` FOREIGN KEY (`companyId`) REFERENCES `company` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `warehouse_managerId_fkey` FOREIGN KEY (`managerId`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `warehouse`
--

LOCK TABLES `warehouse` WRITE;
/*!40000 ALTER TABLE `warehouse` DISABLE KEYS */;
INSERT INTO `warehouse` VALUES ('5d3b0032-6f76-43b8-aa0d-37fc401b3df9','STITCH NEXUS WMS ','STITCH-NEXUS-WM','asdfghjk','Montgomery','Alabama','United States','36104',NULL,'43e8f8fe-99b3-4150-b162-164cff928281','+1 876543234567','Items',8000000,'General','ASDFGHJ','0865134b-9d8b-4f9e-bc54-8eaa88f74d35','2026-08-12 07:17:46.253','2026-08-12 07:17:46.253'),('abefdc82-92cc-401b-9061-efba9898b81a','demo warehouse','DEMO-WAREHOUSE','assdd','Anchorage','Alaska','United States','99501',NULL,'6d065f89-c2de-4086-993a-139450ccb653','+1 1234567','Items',1000,'General','MOBILE ','01bad94b-2627-4b95-9b21-64000231a180','2026-08-11 12:54:55.469','2026-08-11 12:54:55.469');
/*!40000 ALTER TABLE `warehouse` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-12 14:45:16
