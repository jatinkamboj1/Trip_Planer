/*
  Warnings:

  - The primary key for the `user` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `id` on the `user` table. All the data in the column will be lost.
  - Added the required column `userid` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `user` DROP PRIMARY KEY,
    DROP COLUMN `id`,
    ADD COLUMN `userid` INTEGER NOT NULL AUTO_INCREMENT,
    ADD PRIMARY KEY (`userid`);

-- CreateTable
CREATE TABLE `Trip` (
    `tripid` INTEGER NOT NULL AUTO_INCREMENT,
    `destination` VARCHAR(191) NOT NULL,
    `budget` DOUBLE NOT NULL,
    `description` VARCHAR(191) NOT NULL,
    `startdate` DATETIME(3) NOT NULL,
    `enddate` DATETIME(3) NOT NULL,
    `vehicaldetail` VARCHAR(191) NULL,
    `totalseats` INTEGER NOT NULL,
    `tripimage` VARCHAR(191) NULL,
    `userId` INTEGER NOT NULL,
    `pickuppoint` VARCHAR(191) NOT NULL,
    `droppoint` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`tripid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Trip` ADD CONSTRAINT `Trip_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`userid`) ON DELETE RESTRICT ON UPDATE CASCADE;
