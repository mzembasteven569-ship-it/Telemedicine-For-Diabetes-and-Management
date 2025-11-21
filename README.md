Telemedicine App — Local Hosting & Supabase Deployment

Quick local hosting and Supabase deployment steps

Prerequisite
- Replace placeholders in `supabase/config.js` with your Supabase project values, or add meta tags to `index.html` (see below).

Provide Supabase credentials
- Option A: Edit `supabase/config.js` and set `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
- Option B: Add these meta tags into `index.html` head:

  <meta name="supabase-url" content="https://your-project.supabase.co">
  <meta name="supabase-anon-key" content="YOUR_ANON_KEY">

Local quick serve (choose one)
- Python 3 (recommended, zero deps):

```bash
# from project root (where index.html lives)
python -m http.server 8000
# then open http://localhost:8000
```

- Node (http-server):

```bash
npm install -g http-server
http-server -c-1 -p 8000
# or with npx: npx http-server -c-1 -p 8000
```

- Built-in PowerShell helper (Windows):

```powershell
# from project root
./serve.ps1
```

Supabase static hosting
1. In the Supabase dashboard, enable Static Sites (or use any static host). Upload the site files (all files in this repo) including `supabase/config.js`.
2. Ensure `supabase/config.js` contains your project URL and anon key.
3. Database: run the provided SQL files to create tables: `CREATE TABLE profiles`, `patients`, `consultations`.
4. Row Level Security (RLS) and policies:
   - Enable RLS on tables and add policies that allow authenticated users to insert/select/update as needed.
   - Example: allow a signed-up user to create their `profiles` row:

```sql
-- run in SQL editor
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
CREATE POLICY "profiles_insert_own" ON profiles FOR INSERT USING (auth.uid() = id);
CREATE POLICY "profiles_select" ON profiles FOR SELECT USING (true);
```

Notes & troubleshooting
- If operations like `upsert` into `profiles` fail after `signUp`, check RLS policies — anon key needs policy permissions for the action.
- If you prefer not to commit `supabase/config.js` with keys, use meta tags in `index.html` or configure environment injection in your static host.

If you want, I can add example RLS SQL files into `sql/` in the repo and a step-by-step `deploy-to-supabase.md` with screenshots.
