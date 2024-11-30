import { Module, forwardRef } from '@nestjs/common';
import { PatientsController } from './patients.controller';
import { PatientsService } from './patients.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Patient } from './entities/patients.entity';
import { AuthModule } from 'src/auth/auth.module';
import { PetsModule } from 'src/pets/pets.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([Patient]),
    AuthModule,
    forwardRef(() => PetsModule),
  ],
  exports: [PatientsService],
  controllers: [PatientsController],
  providers: [PatientsService],
})
export class PatientsModule {}
