import { Module } from "@nestjs/common";
// import { PrismaModule } from "src/prisma/prisma.module";
import { RegisterService } from "./register.service";
import { RegisterController } from "./register.controller";
import { PrismaService } from "src/prisma.service";


@Module({
    controllers: [RegisterController],
    providers: [RegisterService, PrismaService],
    })

export class RegisterModule {}