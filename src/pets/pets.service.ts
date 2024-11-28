import { BadRequestException, Injectable, InternalServerErrorException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Pet } from './entities/pet.entity';
import { Repository } from 'typeorm';
import { CreatePetDto } from './dtos/create-pet.dto';
import { UpdatePetDto } from './dtos/update-pet.dto';
import { AuthService } from 'src/auth/auth.service';

@Injectable()
export class PetsService {

    constructor(
        @InjectRepository(Pet) private readonly petRepository: Repository<Pet>,
        private readonly authService: AuthService
    ){}

    async createPet(createPetDto: CreatePetDto & { userId: number }): Promise<Pet> {
        const user = await this.authService.findUserById(createPetDto.userId);

        if (!user) {
            throw new NotFoundException(`User with ID ${createPetDto.userId} not found`);
        }

        const newPet = this.petRepository.create({ ...createPetDto, user });
        return this.petRepository.save(newPet);
    }

    async findAllPets() {
        return await this.petRepository.find({ relations: ['user'] });
    }

    async findPetById(id: number){
        const pets = await this.petRepository.find({where:{ id }, relations: ['user']});

        if(!pets){
            throw new NotFoundException(`Pet with ID ${id} not found`)
        }

        return pets;
    }

    async updatePet(id: number, updatePetDto: UpdatePetDto){

        const user = await this.authService.findUserById(updatePetDto.user);

        const pet = await this.petRepository.preload({
            id,
            ...updatePetDto,
            user
        });

        if(!pet){
            throw  new NotFoundException(`Pet with ID ${id} not found`);
        }

        try {
            return await this.petRepository.save(pet)
        } catch (err) {
            this.handleDBErrors(err);
        }
    }

    async deletePet(id: number) {
        
        const pet = await this.findPetById(id);
        await this.petRepository.remove(pet);
        return {message: `Pet with ID ${id} successfully deleted`};

    }


    private  handleDBErrors(error: any) {
        if(error.code === '23505') {
            throw new BadRequestException('Pet already exists');
        }

        throw new InternalServerErrorException('Error creating pet');
    }

}
