import {
  BadRequestException,
  Injectable,
  InternalServerErrorException,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from './entities/user.entity';
import { Repository, In } from 'typeorm';
import { Pet } from '../pets/entities/pet.entity';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from './dtos/create-user.dto';
import * as bcrypt from 'bcrypt';
import { LoginUserDto } from './dtos/login-user.dto';
import { UpdateUserDto } from './dtos/update-user.dto';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(User)
    private readonly userRepository: Repository<User>,
    @InjectRepository(Pet)
    private readonly petRepository: Repository<Pet>,
    private readonly jwtService: JwtService,
  ) {}

  async createUser(createUserDto: CreateUserDto) {
    try {
      const { password, ...userData } = createUserDto;

      const user = this.userRepository.create({
        password: bcrypt.hashSync(password, 10),
        ...userData,
      });

      await this.userRepository.save(user);

      return user;
    } catch (e) {
      this.handleDBErrors(e);
    }
  }

  async loginUser(loginUserDto: LoginUserDto) {
    const { email, password } = loginUserDto;
    const user = await this.userRepository.findOne({
      where: { email },
      select: ['id', 'email', 'password', 'role'],
    });
    if (!user || !bcrypt.compareSync(password, user.password))
      throw new UnauthorizedException('Invalid credentials');

    console.log('Email:', email);
    console.log('User found:', user);
    console.log('Password match:', bcrypt.compareSync(password, user.password));

    return {
      user_id: user.id,
      email: user.email,
      token: this.jwtService.sign({ user_id: user.id }),
      role: user.role,
    };
  }

  async findAllUsers() {
    return await this.userRepository.find({ relations: ['pets'] });
  }

  async findUserById(id: number) {
    const user = await this.userRepository.findOne({ where: { id } });
    if (!user) {
        throw new NotFoundException(`User with ID ${id} not found`);
    }
    return user;
  }

  async findUsersByRole(role: string) {
    const users = await this.userRepository.find({ where: { role } });

    if (!users.length) {
      throw new NotFoundException(`No users found with the role '${role}'`);
    }

    return users;
  }

  async updateUser(id: number, updateUserDto: UpdateUserDto) {
    const user = await this.userRepository.preload({
      id,
      ...updateUserDto,
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }

    if (updateUserDto.password) {
      user.password = bcrypt.hashSync(updateUserDto.password, 10);
    }

    try {
      return await this.userRepository.save(user);
    } catch (error) {
      this.handleDBErrors(error);
    }
  }

  async addPetToUser(userId: number, petIds: number[]) {
    const user = await this.userRepository.findOne({
      where: { id: userId },
      relations: ['pets'],
    });

    if (!user) {
      throw new NotFoundException(`User with ID ${userId} not found`);
    }

    // Buscar las mascotas por IDs usando findBy
    const petsToAdd = await this.petRepository.findBy({
      id: In(petIds), // Necesitarás importar In de typeorm
    });

    if (!petsToAdd.length) {
      throw new NotFoundException(`No pets found with the provided IDs`);
    }

    // Agregar las mascotas al usuario
    user.pets = [...(user.pets || []), ...petsToAdd];

    try {
      return await this.userRepository.save(user);
    } catch (error) {
      this.handleDBErrors(error);
    }
  }

  async deleteUser(id: number) {
    const user = await this.findUserById(id);
    await this.userRepository.remove(user);
    return { message: `User with ID ${id} successfully deleted` };
  }

  private handleDBErrors(error: any) {
    if (error.code === '23505') {
      throw new BadRequestException('User already exists');
    }

    throw new InternalServerErrorException('Error creating user');
  }
  async findOne(id: number): Promise<User> {
    const user = await this.userRepository.findOne({
      where: { id },
      relations: ['pets'],
    });
    if (!user) {
      throw new NotFoundException(`User with ID ${id} not found`);
    }
    return user;
  }
}
