import { PrismaService } from "src/prisma/prisma.service";
import { Injectable } from "@nestjs/common";
import { Registro } from "@prisma/client";


@Injectable()
export class RegisterService {

    constructor(private prisma:PrismaService) {}

    
    async getAllregisters(): Promise<Registro[]>{
        return this.prisma.registro.findMany();
    }
    async getRegisterById(id: number): Promise<Registro>{
        return this.prisma.registro.findUnique({where: {id: id}});  
    }
    async createRegister(data: Registro): Promise<Registro>{
        return this.prisma.registro.create({data});
    }
    async updateRegister(id:number, data: Registro): Promise<Registro>{
        return this.prisma.registro.update({where: {id}, data});
    }
    async deleteRegister(id:number): Promise<Registro>{
        return this.prisma.registro.delete({where: {id}});
    }
}