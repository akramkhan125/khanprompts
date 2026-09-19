# ⚡ KHAN Prompts - Curated AI Prompts Library

A modern, fast, responsive, and completely free AI Prompts Library website built with a single-file architecture (`index.html`) and powered by **Supabase**.

---

## 🚀 5-Step Quickstart & Deployment Guide

Follow these 5 simple steps to connect your shared Supabase cloud database and deploy to Vercel in less than 5 minutes:

### Step 1: Create a Supabase Project
1. Go to [supabase.com](https://supabase.com) and sign in or create a free account.
2. Click **"New project"**.
3. Choose an organization, name your project (e.g. `khan-prompts`), set a strong database password, and pick your nearest region.
4. Click **"Create new project"** and wait ~1-2 minutes for provisioning.

---

### Step 2: Run the SQL Schema & Seed Data
1. In your Supabase Project dashboard, navigate to the **SQL Editor** on the left menu (icon: `>_`).
2. Click **"New query"**.
3. Open [`supabase.sql`](./supabase.sql) from this repository, copy its entire contents, and paste it into the editor.
4. Click the **"Run"** button (or press `Ctrl+Enter`).
   - This creates the `prompts`, `categories`, and `app_settings` tables.
   - Enables Row Level Security (RLS) with public read/write access policies for MVP.
   - Seeds 5 categories, default site settings, and 4 high-converting AI prompts.
   - Enables Supabase Realtime replication.

---

### Step 3: Copy Your API Credentials
1. In the Supabase dashboard, click the **Settings** gear icon (bottom left) -> **API**.
2. Under **Project URL**, copy the **URL** (e.g. `https://xyzcompany.supabase.co`).
3. Under **Project API keys**, copy the **`anon` `public` key** (long JWT token).

---

### Step 4: Configure Your Database (.env or env.js)
You have three flexible ways to add your credentials:

- **Method A (Recommended - `.env`)**:
  Open [`.env`](./.env) and paste your credentials:
  ```env
  SUPABASE_URL=https://xyzcompany.supabase.co
  SUPABASE_ANON_KEY=eyJhbGciOi...
  ```
  *(When running `npm run dev`, it auto-detects `.env` instantly).*

- **Method B (Browser runtime - `env.js`)**:
  Open [`env.js`](./env.js) and paste:
  ```javascript
  window.ENV = {
    SUPABASE_URL: "https://xyzcompany.supabase.co",
    SUPABASE_ANON_KEY: "eyJhbGciOi..."
  };
  ```

- **Method C (Admin Dashboard UI)**:
  Open the website, go to `#admin` (PIN: `2572`), open the **Settings** tab, paste your Supabase URL and Key, and click **Save Settings**!

---

### Step 5: Upload to GitHub & Deploy on Vercel
1. Initialize a git repository and push to GitHub:
   ```bash
   git init
   git add .
   git commit -m "Initial commit: KHAN Prompts"
   git branch -M main
   git remote add origin https://github.com/<your-username>/khan-prompts.git
   git push -u origin main
   ```
2. Go to [vercel.com](https://vercel.com) and click **"Add New..."** -> **"Project"**.
3. Import your `khan-prompts` repository.
4. Vercel automatically detects static HTML. Click **"Deploy"**.
5. Your website is live worldwide on a fast CDN! 🎉

---

## 🛡️ Admin Suite Access
- **PIN Passcode**: `2572`
- **Access Methods**:
  1. Click the logo in the **footer 5 times quickly**, OR
  2. Navigate directly to `/#admin` in the browser URL.
- **Admin Capabilities**:
  - **Metrics**: Real-time overview of active prompts, views, copies, and likes.
  - **Settings**: Live customization of site name, tagline, announcement bar, primary accent colors, WhatsApp contact, and address.
  - **Manage Prompts**: Add, edit, hide/show, or delete prompts with instant cloud synchronization.
  - **Categories**: Create or remove prompt categories dynamically.
  - **Users**: View locally registered community users and manage accounts.
  - **Data & Backup**: 1-click JSON export/download and bulk prompt JSON import.

---

## 🎨 Design System & Technologies
- **Font**: Google Font [Outfit](https://fonts.google.com/specimen/Outfit) (weights 300 to 900)
- **Theme**: Instant Dark/Light mode toggle with persistence
- **Architecture**: Single file SPA with zero build steps or npm packages required
- **Backend**: Supabase JS v2 client via CDN with automatic fallback to local demo storage if credentials are not yet supplied
- **Mobile First**: Fully responsive layout optimized for mobile, tablet, and desktop screens

---

## 📁 Repository Structure
```
.
├── index.html        # Complete single-file application (HTML + CSS + JS)
├── supabase.sql      # Database schema, RLS policies, seed data & realtime config
└── README.md         # Setup and deployment documentation
```
