import { Body, Controller, Delete, Get, Param, Post, Put } from "@nestjs/common";
import { RegisterService } from "./register.service";
import { Registro } from "@prisma/client";

@Controller("register")

export class RegisterController {
    constructor(private readonly registerService: RegisterService) {}

    @Get()
    async getAllregisters(){
        return this.registerService.getAllregisters();
    }
    @Post()
    async createRegister(@Body() data: Registro){
        return this.registerService.createRegister(data);
    }
    @Get(":id")
    async getRegisterById(@Param("id") id: string){
        return this.registerService.getRegisterById(Number(id));
    }
    @Put(":id")
    async updateRegister(@Param("id") id:string, @Body() data: Registro){
        return this.registerService.updateRegister(Number(id), data);
    } 
    @Delete(":id")
    async deleteRegister(@Param("id") id: string){
        return this.registerService.deleteRegister(Number(id));
    }
}