import { Body, Delete, Get, Param, Patch, Post, Controller, UseGuards } from '@nestjs/common';
import { CreatePetDto } from './dtos/create-pet.dto';
import { PetsService } from './pets.service';
import { UpdatePetDto } from './dtos/update-pet.dto';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { RolesGuard } from '../auth/guards/roles.guard';
import { Roles } from '../auth/decorators/roles.decorator';

@Controller('pets')
export class PetsController {
    constructor(private readonly petsService: PetsService) {}

    @Post('register')
    async createPet(@Body() createPetDto: CreatePetDto) {
        const userId = createPetDto.userId;
        const pet = await this.petsService.createPet({ ...createPetDto, userId });
        return pet;
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Get()
    @Roles('admin', 'vet', 'owner')
    async getAllPets() {
        return await this.petsService.findAllPets();
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Get(':id')
    @Roles('admin', 'vet', 'owner')
    async getPetById(@Param('id') id: number) {
        return await this.petsService.findPetById(id);
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Patch(':id')
    @Roles('admin', 'vet', 'owner')
    async updatePet(
        @Param('id') id: number,
        @Body() updatePetDto: UpdatePetDto,
    ) {
        return await this.petsService.updatePet(id, updatePetDto);
    }

    @UseGuards(JwtAuthGuard, RolesGuard)
    @Delete(':id')
    @Roles('admin')
    async deletePet(@Param('id') id: number) {
        return await this.petsService.deletePet(id);
    }
}
