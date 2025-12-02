import { Elysia, t } from 'elysia';
import { db } from '../db';
import { results } from '../db/schema';
import { eq } from 'drizzle-orm';

export const resultRoutes = new Elysia({ prefix: '/results' })
    .get('/', async () => {
        return await db.select().from(results).all();
    })
    .post('/', async ({ body }) => {
        const result = await db.insert(results).values(body).returning();
        return result[0];
    }, {
        body: t.Object({
            examId: t.Number(),
            studentId: t.String(),
            obtainedScore: t.Number(),
            metadata: t.Optional(t.Any())
        })
    });
