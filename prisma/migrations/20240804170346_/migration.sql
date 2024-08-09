/*
  Warnings:

  - You are about to alter the column `status` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `Int` to `Enum(EnumId(6))`.
  - You are about to drop the column `path` on the `ProductImage` table. All the data in the column will be lost.
  - You are about to drop the column `provider` on the `Social` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `Social` table. All the data in the column will be lost.
  - Added the required column `mainImage` to the `Product` table without a default value. This is not possible if the table is not empty.
  - Added the required column `data` to the `ProductImage` table without a default value. This is not possible if the table is not empty.
  - Added the required column `providerId` to the `Seller` table without a default value. This is not possible if the table is not empty.
  - Added the required column `providerName` to the `Seller` table without a default value. This is not possible if the table is not empty.
  - Added the required column `platform` to the `Social` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sellerId` to the `Social` table without a default value. This is not possible if the table is not empty.
  - Added the required column `providerId` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `providerName` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE `Social` DROP FOREIGN KEY `Social_userId_fkey`;

-- DropIndex
DROP INDEX `Seller_email_key` ON `Seller`;

-- DropIndex
DROP INDEX `User_email_key` ON `User`;

-- AlterTable
ALTER TABLE `Product` ADD COLUMN `mainImage` LONGBLOB NOT NULL,
    MODIFY `status` ENUM('EmptyStock', 'Restocking', 'Available') NOT NULL DEFAULT 'EmptyStock';

-- AlterTable
ALTER TABLE `ProductImage` DROP COLUMN `path`,
    ADD COLUMN `data` LONGBLOB NOT NULL;

-- AlterTable
ALTER TABLE `Seller` ADD COLUMN `address` LONGTEXT NULL,
    ADD COLUMN `phone` VARCHAR(191) NULL,
    ADD COLUMN `providerId` VARCHAR(191) NOT NULL,
    ADD COLUMN `providerName` VARCHAR(191) NOT NULL,
    ADD COLUMN `status` ENUM('Onboard', 'Active', 'Blocked', 'Verify') NOT NULL DEFAULT 'Onboard';

-- AlterTable
ALTER TABLE `Social` DROP COLUMN `provider`,
    DROP COLUMN `userId`,
    ADD COLUMN `platform` VARCHAR(191) NOT NULL,
    ADD COLUMN `sellerId` VARCHAR(191) NOT NULL;

-- AlterTable
ALTER TABLE `User` ADD COLUMN `address` LONGTEXT NULL,
    ADD COLUMN `addressName` VARCHAR(191) NULL,
    ADD COLUMN `blocked` BOOLEAN NOT NULL DEFAULT false,
    ADD COLUMN `city` VARCHAR(191) NULL,
    ADD COLUMN `phone` VARCHAR(191) NULL,
    ADD COLUMN `providerId` VARCHAR(191) NOT NULL,
    ADD COLUMN `providerName` VARCHAR(191) NOT NULL,
    ADD COLUMN `province` VARCHAR(191) NULL;

-- CreateTable
CREATE TABLE `AdminMessage` (
    `id` VARCHAR(191) NOT NULL,
    `message` VARCHAR(191) NOT NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `NationalIdentityCard` (
    `id` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NULL,
    `front` LONGBLOB NOT NULL,
    `back` LONGBLOB NOT NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `NationalIdentityCard_sellerId_key`(`sellerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `JazzCash` (
    `id` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `JazzCash_sellerId_key`(`sellerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `EasyPaisa` (
    `id` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `EasyPaisa_sellerId_key`(`sellerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `BankAccount` (
    `id` VARCHAR(191) NOT NULL,
    `number` VARCHAR(191) NOT NULL,
    `numberType` ENUM('IBAN', 'AccountNumber') NOT NULL,
    `bankName` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    UNIQUE INDEX `BankAccount_sellerId_key`(`sellerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ShippingCosts` (
    `id` VARCHAR(191) NOT NULL,
    `city` VARCHAR(191) NOT NULL,
    `province` VARCHAR(191) NOT NULL,
    `cost` DOUBLE NOT NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `WithdrawRequest` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('Done', 'Pending', 'Processing', 'Failed') NOT NULL DEFAULT 'Pending',
    `paymentMethod` ENUM('JazzCash', 'EasyPaisa', 'BankAccount') NOT NULL,
    `reason` VARCHAR(191) NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Rider` (
    `id` VARCHAR(191) NOT NULL,
    `username` VARCHAR(191) NOT NULL,
    `passwordHash` VARCHAR(191) NULL,
    `address` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `CollectionRequest` (
    `id` VARCHAR(191) NOT NULL,
    `status` ENUM('Done', 'Pending', 'Coming', 'Failed') NOT NULL DEFAULT 'Pending',
    `reason` VARCHAR(191) NULL,
    `sellerId` VARCHAR(191) NOT NULL,
    `riderId` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductCollected` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `riderId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL,
    `collectionRequestId` VARCHAR(191) NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ProductOrdered` (
    `id` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,
    `orderId` VARCHAR(191) NOT NULL,
    `quantity` INTEGER NOT NULL DEFAULT 0,
    `amount` DOUBLE NOT NULL DEFAULT 0,
    `commissionTaken` DOUBLE NOT NULL DEFAULT 0,
    `packageStatus` ENUM('Done', 'Pending', 'Coming', 'Failed') NOT NULL DEFAULT 'Pending',
    `reason` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SuitableFor` (
    `id` VARCHAR(191) NOT NULL,
    `key` VARCHAR(191) NOT NULL,
    `value` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Ingredient` (
    `id` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `productId` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Order` (
    `id` VARCHAR(191) NOT NULL,
    `paymentStatus` ENUM('Done', 'Pending', 'Failed') NOT NULL DEFAULT 'Pending',
    `reason` VARCHAR(191) NULL,
    `riderId` VARCHAR(191) NULL,
    `userId` VARCHAR(191) NULL,
    `amount` DOUBLE NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_CollectionRequestToProduct` (
    `A` VARCHAR(191) NOT NULL,
    `B` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `_CollectionRequestToProduct_AB_unique`(`A`, `B`),
    INDEX `_CollectionRequestToProduct_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `AdminMessage` ADD CONSTRAINT `AdminMessage_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `NationalIdentityCard` ADD CONSTRAINT `NationalIdentityCard_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `JazzCash` ADD CONSTRAINT `JazzCash_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `EasyPaisa` ADD CONSTRAINT `EasyPaisa_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `BankAccount` ADD CONSTRAINT `BankAccount_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ShippingCosts` ADD CONSTRAINT `ShippingCosts_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `WithdrawRequest` ADD CONSTRAINT `WithdrawRequest_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CollectionRequest` ADD CONSTRAINT `CollectionRequest_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `CollectionRequest` ADD CONSTRAINT `CollectionRequest_riderId_fkey` FOREIGN KEY (`riderId`) REFERENCES `Rider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductCollected` ADD CONSTRAINT `ProductCollected_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductCollected` ADD CONSTRAINT `ProductCollected_riderId_fkey` FOREIGN KEY (`riderId`) REFERENCES `Rider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductCollected` ADD CONSTRAINT `ProductCollected_collectionRequestId_fkey` FOREIGN KEY (`collectionRequestId`) REFERENCES `CollectionRequest`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductOrdered` ADD CONSTRAINT `ProductOrdered_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductOrdered` ADD CONSTRAINT `ProductOrdered_orderId_fkey` FOREIGN KEY (`orderId`) REFERENCES `Order`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Social` ADD CONSTRAINT `Social_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SuitableFor` ADD CONSTRAINT `SuitableFor_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ingredient` ADD CONSTRAINT `Ingredient_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_riderId_fkey` FOREIGN KEY (`riderId`) REFERENCES `Rider`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Order` ADD CONSTRAINT `Order_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CollectionRequestToProduct` ADD CONSTRAINT `_CollectionRequestToProduct_A_fkey` FOREIGN KEY (`A`) REFERENCES `CollectionRequest`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_CollectionRequestToProduct` ADD CONSTRAINT `_CollectionRequestToProduct_B_fkey` FOREIGN KEY (`B`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
