-- CreateTable
CREATE TABLE `Registro` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(191) NOT NULL,
    `apellido` VARCHAR(191) NOT NULL,
    `identidad` VARCHAR(191) NOT NULL,
    `correo` VARCHAR(191) NOT NULL,
    `celular` VARCHAR(191) NULL,
    `nombreConyuge` VARCHAR(191) NOT NULL,
    `apellidoConyuge` VARCHAR(191) NOT NULL,
    `parroquia` VARCHAR(191) NULL,
    `grupo` VARCHAR(191) NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `updatedAt` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
