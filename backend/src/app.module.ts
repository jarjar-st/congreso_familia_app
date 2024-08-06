import { Module } from '@nestjs/common';
// import { TaskModule } from './task/task.module';
import { RegisterModule } from './register/register.module';
import { PrismaService } from './prisma.service';

@Module({
  imports: [ RegisterModule],
  controllers: [],
  providers: [PrismaService],
})
export class AppModule {}
