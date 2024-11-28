import { Body, Controller, Delete, Get, Param, Patch, Post } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dtos/create-comment.dto';
import { UpdateCommentDto } from './dtos/update-comment.dto';
import { Comment } from './comment.schema';

@Controller('comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  // Crear un nuevo comentario
  @Post()
  async createComment(@Body() createCommentDto: CreateCommentDto): Promise<Comment> {
    return this.commentsService.create(createCommentDto);
  }

  // Obtener todos los comentarios
  @Get()
  async getAllComments(): Promise<Comment[]> {
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
