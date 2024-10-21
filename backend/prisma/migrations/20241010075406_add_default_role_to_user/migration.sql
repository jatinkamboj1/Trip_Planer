-- CreateTable
CREATE TABLE `Payment` (
    `paymentid` INTEGER NOT NULL AUTO_INCREMENT,
    `tripid` INTEGER NOT NULL,
    `amount` DOUBLE NOT NULL,
    `paymentdate` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `paymentmethod` VARCHAR(191) NULL,
    `paymentstatus` VARCHAR(191) NOT NULL,
    `transactionid` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`paymentid`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_tripid_fkey` FOREIGN KEY (`tripid`) REFERENCES `Trip`(`tripid`) ON DELETE RESTRICT ON UPDATE CASCADE;
