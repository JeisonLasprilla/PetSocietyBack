import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type CommentDocument = Comment & Document;

@Schema()
export class Comment {
    @Prop({ required: true })
    text: string;

    @Prop({ required: true })
    author: string;

    @Prop({ required: true, default: Date.now })
    createdAt: Date;
}

export const CommentSchema = SchemaFactory.createForClass(Comment);
