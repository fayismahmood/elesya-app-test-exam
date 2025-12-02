import { sqliteTable, text, integer } from 'drizzle-orm/sqlite-core';
import { sql } from 'drizzle-orm';

export const exams = sqliteTable('exams', {
    id: integer('id').primaryKey({ autoIncrement: true }),
    type: text('type', { enum: ['normal', 'continuous'] }).notNull(),
    subject: text('subject').notNull(),
    maxScore: integer('max_score').notNull(),
    scoreDistributions: text('score_distributions', { mode: 'json' }).$type<{ section_name: string; allocated_score: number }[]>(),
    scoreMappings: text('score_mappings', { mode: 'json' }).$type<{ min_score: number; max_score: number; status: string }[]>(),
    createdAt: integer('created_at', { mode: 'timestamp' }).default(sql`(strftime('%s', 'now'))`),
});

export const results = sqliteTable('results', {
    id: integer('id').primaryKey({ autoIncrement: true }),
    examId: integer('exam_id').references(() => exams.id).notNull(),
    studentId: text('student_id').notNull(),
    obtainedScore: integer('obtained_score').notNull(),
    metadata: text('metadata', { mode: 'json' }),
});
