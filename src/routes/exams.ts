import { Elysia, t } from 'elysia';
import { db } from '../db';
import { exams } from '../db/schema';
import { eq } from 'drizzle-orm';

export const examRoutes = new Elysia({ prefix: '/exams' })
    .get('/', async () => {
        return await db.select().from(exams).all();
    })
    .post('/', async ({ body }) => {
        const result = await db.insert(exams).values(body).returning();
        return result[0];
    }, {
        body: t.Object({
            type: t.Union([t.Literal('normal'), t.Literal('continuous')]),
            subject: t.String(),
            maxScore: t.Number(),
            scoreDistributions: t.Optional(t.Array(t.Object({
                section_name: t.String(),
                allocated_score: t.Number()
            }))),
            scoreMappings: t.Optional(t.Array(t.Object({
                min_score: t.Number(),
                max_score: t.Number(),
                status: t.String()
            })))
        })
    });
