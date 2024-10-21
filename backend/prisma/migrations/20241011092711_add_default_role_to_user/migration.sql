/*
  Warnings:

  - The primary key for the `payment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `paymentid` on the `payment` table. All the data in the column will be lost.
  - You are about to drop the column `tripid` on the `payment` table. All the data in the column will be lost.
  - The primary key for the `picture` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `pictureid` on the `picture` table. All the data in the column will be lost.
  - You are about to drop the column `tripid` on the `picture` table. All the data in the column will be lost.
  - The primary key for the `review` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `ratingid` on the `review` table. All the data in the column will be lost.
  - You are about to drop the column `reviewid` on the `review` table. All the data in the column will be lost.
  - You are about to drop the column `tripid` on the `review` table. All the data in the column will be lost.
  - You are about to drop the column `userid` on the `review` table. All the data in the column will be lost.
  - The primary key for the `trip` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `tripid` on the `trip` table. All the data in the column will be lost.
  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `userid` on the `user` table. All the data in the column will be lost.
  - Added the required column `paymentId` to the `Payment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tripId` to the `Payment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `pictureId` to the `Picture` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tripId` to the `Picture` table without a default value. This is not possible if the table is not empty.
  - Added the required column `ratingId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `reviewId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tripId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Review` table without a default value. This is not possible if the table is not empty.
  - Added the required column `tripId` to the `Trip` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `payment` DROP FOREIGN KEY `Payment_tripid_fkey`;

-- DropForeignKey
ALTER TABLE `picture` DROP FOREIGN KEY `Picture_tripid_fkey`;

-- DropForeignKey
ALTER TABLE `review` DROP FOREIGN KEY `Review_tripid_fkey`;

-- DropForeignKey
ALTER TABLE `review` DROP FOREIGN KEY `Review_userid_fkey`;

-- DropForeignKey
ALTER TABLE `trip` DROP FOREIGN KEY `Trip_userId_fkey`;

-- AlterTable
ALTER TABLE `payment` DROP PRIMARY KEY,
    DROP COLUMN `paymentid`,
    DROP COLUMN `tripid`,
    ADD COLUMN `paymentId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `tripId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`paymentId`);

-- AlterTable
ALTER TABLE `picture` DROP PRIMARY KEY,
    DROP COLUMN `pictureid`,
    DROP COLUMN `tripid`,
    ADD COLUMN `pictureId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `tripId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`pictureId`);

-- AlterTable
ALTER TABLE `review` DROP PRIMARY KEY,
    DROP COLUMN `ratingid`,
    DROP COLUMN `reviewid`,
    DROP COLUMN `tripid`,
    DROP COLUMN `userid`,
    ADD COLUMN `ratingId` INTEGER NOT NULL,
    ADD COLUMN `reviewId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD COLUMN `tripId` INTEGER NOT NULL,
    ADD COLUMN `userId` INTEGER NOT NULL,
    ADD PRIMARY KEY (`reviewId`);

-- AlterTable
ALTER TABLE `trip` DROP PRIMARY KEY,
    DROP COLUMN `tripid`,
    ADD COLUMN `tripId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`tripId`);

-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `userid`,
    ADD COLUMN `userId` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`userId`);

-- AddForeignKey
ALTER TABLE `Trip` ADD CONSTRAINT `Trip_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_tripId_fkey` FOREIGN KEY (`tripId`) REFERENCES `Trip`(`tripId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_tripId_fkey` FOREIGN KEY (`tripId`) REFERENCES `Trip`(`tripId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`userId`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Picture` ADD CONSTRAINT `Picture_tripId_fkey` FOREIGN KEY (`tripId`) REFERENCES `Trip`(`tripId`) ON DELETE RESTRICT ON UPDATE CASCADE;
