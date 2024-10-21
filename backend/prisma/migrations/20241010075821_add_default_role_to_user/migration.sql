-- CreateTable
CREATE TABLE `Review` (
    `reviewid` INTEGER NOT NULL AUTO_INCREMENT,
    `tripid` INTEGER NOT NULL,
    `userid` INTEGER NOT NULL,
    `ratingid` INTEGER NOT NULL,
    `reviewtext` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`reviewid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_tripid_fkey` FOREIGN KEY (`tripid`) REFERENCES `Trip`(`tripid`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_userid_fkey` FOREIGN KEY (`userid`) REFERENCES `User`(`userid`) ON DELETE RESTRICT ON UPDATE CASCADE;
