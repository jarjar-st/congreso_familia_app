import { Module } from "@nestjs/common";
import { PrismaModule } from "src/prisma/prisma.module";
import { RegisterService } from "./register.service";
import { RegisterController } from "./register.controller";


@Module({
    controllers: [RegisterController],
    providers: [RegisterService],
    imports: [PrismaModule],
    })

export class RegisterModule {}