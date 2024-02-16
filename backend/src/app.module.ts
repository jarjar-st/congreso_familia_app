import { Module } from '@nestjs/common';
import { TaskModule } from './task/task.module';
import { RegisterModule } from './register/register.module';

@Module({
  imports: [TaskModule, RegisterModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
