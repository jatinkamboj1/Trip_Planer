-- CreateTable
CREATE TABLE `Picture` (
    `pictureid` INTEGER NOT NULL AUTO_INCREMENT,
    `tripid` INTEGER NOT NULL,
    `imageurl` VARCHAR(191) NOT NULL,
    `imagetitle` VARCHAR(191) NULL,

    PRIMARY KEY (`pictureid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Picture` ADD CONSTRAINT `Picture_tripid_fkey` FOREIGN KEY (`tripid`) REFERENCES `Trip`(`tripid`) ON DELETE RESTRICT ON UPDATE CASCADE;
