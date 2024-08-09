/*
  Warnings:

  - You are about to drop the column `ingredients` on the `Product` table. All the data in the column will be lost.
  - You are about to drop the column `stock` on the `Product` table. All the data in the column will be lost.
  - You are about to alter the column `price` on the `Product` table. The data in that column could be lost. The data in that column will be cast from `VarChar(191)` to `Double`.
  - You are about to drop the `ProductFeature` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `Product` DROP FOREIGN KEY `Product_sellerId_fkey`;

-- DropForeignKey
ALTER TABLE `ProductFeature` DROP FOREIGN KEY `ProductFeature_productId_fkey`;

-- DropForeignKey
ALTER TABLE `ProductImage` DROP FOREIGN KEY `ProductImage_productId_fkey`;

-- DropForeignKey
ALTER TABLE `Review` DROP FOREIGN KEY `Review_productId_fkey`;

-- DropForeignKey
ALTER TABLE `Review` DROP FOREIGN KEY `Review_userId_fkey`;

-- DropForeignKey
ALTER TABLE `SellerProfile` DROP FOREIGN KEY `SellerProfile_sellerId_fkey`;

-- DropForeignKey
ALTER TABLE `UserProfile` DROP FOREIGN KEY `UserProfile_userId_fkey`;

-- AlterTable
ALTER TABLE `Product` DROP COLUMN `ingredients`,
    DROP COLUMN `stock`,
    ADD COLUMN `status` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `stockAcquired` INTEGER NOT NULL DEFAULT 0,
    ADD COLUMN `stockSpecified` INTEGER NOT NULL DEFAULT 0,
    MODIFY `price` DOUBLE NOT NULL DEFAULT 0,
    MODIFY `description` LONGTEXT NULL;

-- AlterTable
ALTER TABLE `Seller` ADD COLUMN `accessToken` LONGTEXT NULL,
    ADD COLUMN `refreshToken` LONGTEXT NULL;

-- DropTable
DROP TABLE `ProductFeature`;

-- AddForeignKey
ALTER TABLE `SellerProfile` ADD CONSTRAINT `SellerProfile_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `UserProfile` ADD CONSTRAINT `UserProfile_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Product` ADD CONSTRAINT `Product_sellerId_fkey` FOREIGN KEY (`sellerId`) REFERENCES `Seller`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ProductImage` ADD CONSTRAINT `ProductImage_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_productId_fkey` FOREIGN KEY (`productId`) REFERENCES `Product`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
