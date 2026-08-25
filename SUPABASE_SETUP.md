# Supabase Setup for UpSkill

This project is a Vite React frontend with an Express backend. Use Vite env names on the frontend and server env names on the backend.

## 1. Install dependencies

Already done in the root app:

```bash
npm install @supabase/supabase-js @supabase/ssr
```

The Express server already has `@supabase/supabase-js` installed in `server/package.json`.

## 2. Environment variables

Root `.env.local`:

```env
VITE_SUPABASE_URL=https://pgrflyjtllesuolmjyrn.supabase.co
VITE_SUPABASE_PUBLISHABLE_KEY=sb_publishable_7uLgccn8AXe47qMG3A8vjA_vFeEblZ7
```

Server `server/.env.local`:

```env
SUPABASE_URL=https://pgrflyjtllesuolmjyrn.supabase.co
SUPABASE_PUBLISHABLE_KEY=sb_publishable_7uLgccn8AXe47qMG3A8vjA_vFeEblZ7
SUPABASE_SECRET_KEY=your-service-role-or-secret-key
SUPABASE_JWKS_URL=https://pgrflyjtllesuolmjyrn.supabase.co/auth/v1/.well-known/jwks.json
```

Use a server-only service role/secret key for `SUPABASE_SECRET_KEY`. Do not put it in frontend env files.

## 3. Create database tables and storage buckets

Open the Supabase SQL Editor and run:

```sql
-- paste supabase/schema.sql here
```

The schema creates:

- `login_profiles` for student/admin login details
- `subjects_list`, `student_subjects`, and `student_assignments`
- `videos` and `notes` metadata tables
- `upload_metadata` and `chat_history`
- Storage buckets for course videos, study materials, and OCR uploads

## 4. App integration status

The frontend can import the configured client from:

```js
import { supabase } from './lib/supabaseClient';
```

The backend already switches auth/profile storage to Supabase when `SUPABASE_URL` and `SUPABASE_SECRET_KEY` are present. If those are missing, it falls back to SQLite.
