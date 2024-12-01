import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  Patch,
  Post,
  Req,
  UseGuards,
} from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dtos/create-comment.dto';
import { UpdateCommentDto } from './dtos/update-comment.dto';
import { Comment } from './comment.schema';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';
import { Request } from 'express';
import { AuthService } from '../auth/auth.service';

interface RequestWithUser extends Request {
  user: any; // Puedes definir un tipo más específico si lo tienes
}

@Controller('comments')
export class CommentsController {
  constructor(
    private readonly commentsService: CommentsService,
    private readonly authService: AuthService,
  ) {}

  @UseGuards(JwtAuthGuard)
  @Post()
  async createComment(@Body() createCommentDto: CreateCommentDto, @Req() req: RequestWithUser) {
      const user = req.user;
      const userDetails = await this.authService.findUserById(user.id);
      createCommentDto.author = userDetails.name;
      return this.commentsService.create(createCommentDto);
  }

  // Obtener todos los comentarios
  @Get()
  async getAllComments() {
    return this.commentsService.findAll();
  }

  // Obtener un comentario por ID
  @Get(':id')
  async getCommentById(@Param('id') id: string): Promise<Comment> {
    return this.commentsService.findById(id);
  }

  // Actualizar un comentario por ID
  @Patch(':id')
  async updateComment(
    @Param('id') id: string,
    @Body() updateCommentDto: UpdateCommentDto,
  ): Promise<Comment> {
    return this.commentsService.update(id, updateCommentDto);
  }

  // Eliminar un comentario por ID
  @Delete(':id')
  async deleteComment(@Param('id') id: string): Promise<void> {
    return this.commentsService.delete(id);
  }
}
