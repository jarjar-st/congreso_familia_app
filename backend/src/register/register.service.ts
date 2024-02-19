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
        const existingUser = await this.prisma.registro.findFirst({ where: { correo: data.correo } });
        if (existingUser) {
          throw new Error('El correo electrónico ya está registrado');
        }

        const existingUserDNI = await this.prisma.registro.findFirst({ where: { identidad: data.identidad } });
        if (existingUserDNI) {
            throw new Error('El número de identidad ya está registrado');
            
        }
        return this.prisma.registro.create({data});
    }
    async updateRegister(id:number, data: Registro): Promise<Registro>{
        return this.prisma.registro.update({where: {id}, data});
    }
    async deleteRegister(id:number): Promise<Registro>{
        return this.prisma.registro.delete({where: {id}});
    }
}