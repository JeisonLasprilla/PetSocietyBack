import { IsOptional, IsString, IsNumber, MinLength } from "class-validator";
import { Patient } from "src/patients/entities/patients.entity";

export class UpdatePetDto {
    @IsOptional()
    @IsString()
    name: string;

    @IsOptional()
    @IsString()
    @MinLength(3)
    species: string;

    @IsOptional()
    @IsString()
    @MinLength(3)
    breed: string;

    @IsOptional()
    @IsString()
    @MinLength(3)
    birth_date: string;

    @IsOptional()
    @IsString()
    @MinLength(3)
    gender: string;

    @IsOptional()
    @IsNumber()
    weight: number;

    @IsOptional()
    @IsNumber()
    user: number;
}