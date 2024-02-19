/*
  Warnings:

  - A unique constraint covering the columns `[correo]` on the table `Registro` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `Registro_correo_key` ON `Registro`(`correo`);
