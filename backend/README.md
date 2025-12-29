# Backend — Setup & Run 🔧

## Overview

Small Express + TypeScript backend using Drizzle ORM and PostgreSQL. The app exposes endpoints under `/auth` and `/tasks` and listens on port `8000` by default.

## Prerequisites ✅

- Node.js (>= 18)
- npm
- Docker & Docker Compose (optional, recommended for running Postgres locally)

## Quick start — Local (Node)

1. Copy or edit `.env` if needed

2. Install dependencies:

```bash
cd backend
npm install
```

3. Run in development (auto-restarts via nodemon):

```bash
npm run dev
```

4. Open the API at: `http://localhost:8000` (endpoints: `/auth`, `/tasks`).

## Quick start — Using Docker Compose

From the `backend/` folder:

```bash
docker-compose up --build
```

This starts the backend service and a Postgres `db` service using the values in `.env`.

## Database / Migrations

Drizzle Kit is included in `devDependencies`. You can use it to generate or push migrations. Example (adjust to your workflow and check the Drizzle docs):

```bash
# generate or push migrations with drizzle-kit (example)
npx drizzle-kit generate --config src/drizzle.config.ts
# or
npx drizzle-kit push --config src/drizzle.config.ts --url "$DATABASE_URL"
```

## Notes / Troubleshooting ⚠️

- The server listens on port `8000` in `src/index.ts`. Change the value if needed and update any client configuration.
- If the DB is unreachable, confirm `DB_PASSWORD` and `DATABASE_URL` in `.env` and that the `db` container (if using Docker) is running.
