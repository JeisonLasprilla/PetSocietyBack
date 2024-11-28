import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Comment, CommentDocument } from './comment.schema';
import { CreateCommentDto } from './dtos/create-comment.dto';
import { UpdateCommentDto } from './dtos/update-comment.dto';

@Injectable()
export class CommentsService {
  constructor(@InjectModel(Comment.name) private commentModel: Model<CommentDocument>) {}

  // Crear un nuevo comentario
  async create(createCommentDto: CreateCommentDto): Promise<Comment> {
    const newComment = new this.commentModel({
      ...createCommentDto,
      createdAt: new Date(),
    });
    return newComment.save();
  }

  // Obtener todos los comentarios
  async findAll(): Promise<Comment[]> {
    return this.commentModel.find().exec();
  }

  // Obtener un comentario por ID
  async findById(id: string): Promise<Comment> {
    const comment = await this.commentModel.findById(id).exec();
    if (!comment) {
      throw new NotFoundException(`Comment with ID ${id} not found`);
    }
    return comment;
  }

  // Actualizar un comentario por ID
  async update(id: string, updateCommentDto: UpdateCommentDto): Promise<Comment> {
    const updatedComment = await this.commentModel.findByIdAndUpdate(id, updateCommentDto, {
      new: true, // Devuelve el documento actualizado
    }).exec();

    if (!updatedComment) {
      throw new NotFoundException(`Comment with ID ${id} not found`);
    }
    return updatedComment;
  }

  // Eliminar un comentario por ID
  async delete(id: string): Promise<void> {
    const result = await this.commentModel.findByIdAndDelete(id).exec();
    if (!result) {
      throw new NotFoundException(`Comment with ID ${id} not found`);
    }
  }
}
