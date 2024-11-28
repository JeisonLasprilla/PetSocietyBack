import { Module, OnModuleInit } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthModule } from './auth/auth.module';
import { CommonModule } from './common/common.module';
import { TypeOrmModule } from '@nestjs/typeorm';
import { ConfigModule } from '@nestjs/config';
import { PatientsModule } from './patients/patients.module';
import { PetsModule } from './pets/pets.module';
import { AppointmentsModule } from './appointments/appointments.module';
import { MedicalRecordsModule } from './medical_records/medical_records.module';
import { ServicesModule } from './services/services.module';
import { SeedModule } from './seed/seed.module';
import { MongooseModule } from '@nestjs/mongoose';
import { CommentsModule } from './comments/comments.module';
import * as mongoose from 'mongoose';
import { User } from './auth/entities/user.entity';
import { Pet } from './pets/entities/pet.entity';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST,
      database: process.env.DB_NAME,
      username: process.env.DB_USER,
      password: process.env.DB_PASSWORD,
      port: +process.env.DB_PORT,
      autoLoadEntities: true,
      synchronize: true,
      entities: [User, Pet],
    }),
    MongooseModule.forRoot(process.env.MONGODB_URL),
    SeedModule, AuthModule, CommonModule, PatientsModule, PetsModule, AppointmentsModule, MedicalRecordsModule, ServicesModule, CommentsModule
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule implements OnModuleInit {
  async onModuleInit() {
    try {
      await mongoose.connect(process.env.MONGODB_URL);
      console.log('📦 Conectado a MongoDB');
    } catch (error) {
      console.error('Error al conectar a MongoDB:', error);
      process.exit(1);
    }
  }
}
