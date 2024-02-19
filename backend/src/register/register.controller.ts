import { Body, ConflictException, Controller, Delete, Get, Param, Post, Put } from "@nestjs/common";
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
        try {
            const newUser = await this.registerService.createRegister(data);
            console.log(`Este es el nuevo usuario: ${newUser}`);
            return newUser;
          } catch (error) {
            if (error.message === 'El correo electrónico ya está registrado') {
              throw new ConflictException('El correo electrónico ya está registrado');
            }
            if (error.message === 'El número de identidad ya está registrado') {
                throw new ConflictException('El número de identidad ya está registrado');
            }
            throw error;
          }
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