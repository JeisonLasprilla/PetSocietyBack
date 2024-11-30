import { IsOptional, IsString, IsEmail, MinLength, IsArray } from 'class-validator';
import { Pet } from 'src/pets/entities/pet.entity';

export class UpdateUserDto {
    @IsOptional()
    @IsString()
    name?: string;

    @IsOptional()
    @IsEmail()
    email?: string;

    @IsOptional()
    @MinLength(6)
    password?: string;

    @IsOptional()
    @IsArray()
    pets?: Pet[];
}