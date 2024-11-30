import { Module } from '@nestjs/common';
import { PetsController } from './pets.controller';
import { PetsService } from './pets.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Pet } from './entities/pet.entity';
import { PatientsModule } from 'src/patients/patients.module';
import { AuthModule } from 'src/auth/auth.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Pet]), // Registra el repositorio de Pet
    PatientsModule,
    AuthModule,
  ],
  controllers: [PetsController],
  providers: [PetsService],
  exports: [
    PetsService, 
    TypeOrmModule, // Exporta TypeOrmModule para que otros módulos puedan usar PetRepository
  ],
})
export class PetsModule {}
