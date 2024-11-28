import { IsOptional, IsString } from 'class-validator';

export class UpdateCommentDto {
  @IsOptional()
  @IsString()
  text?: string;

  @IsOptional()
  @IsString()
  author?: string;
}