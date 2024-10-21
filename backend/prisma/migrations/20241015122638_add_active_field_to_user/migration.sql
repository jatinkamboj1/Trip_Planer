/*
  Warnings:

  - You are about to drop the column `pickuppoint` on the `trip` table. All the data in the column will be lost.
  - Added the required column `picuppoint` to the `Trip` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `trip` DROP COLUMN `pickuppoint`,
    ADD COLUMN `picuppoint` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `user` ADD COLUMN `active` BOOLEAN NOT NULL DEFAULT false;
