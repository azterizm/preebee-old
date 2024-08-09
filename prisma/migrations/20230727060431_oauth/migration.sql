/*
  Warnings:

  - You are about to drop the column `imagePath` on the `SellerProfile` table. All the data in the column will be lost.
  - You are about to drop the column `imagePath` on the `UserProfile` table. All the data in the column will be lost.
  - Added the required column `imageURL` to the `SellerProfile` table without a default value. This is not possible if the table is not empty.
  - Added the required column `imageURL` to the `UserProfile` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `SellerProfile` DROP COLUMN `imagePath`,
    ADD COLUMN `imageURL` LONGTEXT NOT NULL;

-- AlterTable
ALTER TABLE `User` ADD COLUMN `accessToken` LONGTEXT NULL,
    ADD COLUMN `refreshToken` LONGTEXT NULL;

-- AlterTable
ALTER TABLE `UserProfile` DROP COLUMN `imagePath`,
    ADD COLUMN `imageURL` LONGTEXT NOT NULL;
