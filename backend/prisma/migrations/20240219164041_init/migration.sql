/*
  Warnings:

  - A unique constraint covering the columns `[identidad]` on the table `Registro` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateIndex
CREATE UNIQUE INDEX `Registro_identidad_key` ON `Registro`(`identidad`);
