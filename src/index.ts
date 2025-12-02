import { Elysia } from "elysia";
import { examRoutes } from "./routes/exams";
import { resultRoutes } from "./routes/results";

const app = new Elysia()
  .get("/", () => "Hello Elysia")
  .use(examRoutes)
  .use(resultRoutes)
  .listen(3000);

console.log(
  `🦊 Elysia is running at ${app.server?.hostname}:${app.server?.port}`
);


export default app;