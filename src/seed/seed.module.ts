import { Module, OnApplicationBootstrap } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from '../auth/entities/user.entity';
import { SeedService } from './seed.service';
import { Pet } from '../pets/entities/pet.entity';

@Module({
  imports: [TypeOrmModule.forFeature([User, Pet])],
  providers: [SeedService],
})
export class SeedModule implements OnApplicationBootstrap {
  constructor(private seedService: SeedService) {}

  async onApplicationBootstrap() {
    await this.seedService.seed();
  }
}