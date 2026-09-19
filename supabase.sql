-- ==========================================================
-- KHAN PROMPTS - SUPABASE DATABASE SCHEMA & SEED SCRIPT
-- ==========================================================
-- Run this SQL in your Supabase SQL Editor (Dashboard -> SQL Editor -> New query -> Paste & Run)

-- 1. Create Prompts Table
CREATE TABLE IF NOT EXISTS public.prompts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title TEXT NOT NULL,
    image TEXT,
    description TEXT,
    prompt_text TEXT NOT NULL,
    category TEXT DEFAULT 'General',
    featured BOOLEAN DEFAULT false,
    active BOOLEAN DEFAULT true,
    views INT DEFAULT 0,
    copies INT DEFAULT 0,
    likes INT DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT now()
);

-- 2. Create Categories Table
CREATE TABLE IF NOT EXISTS public.categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name TEXT UNIQUE NOT NULL
);

-- 3. Create App Settings Table
CREATE TABLE IF NOT EXISTS public.app_settings (
    id INT PRIMARY KEY DEFAULT 1,
    site_name TEXT DEFAULT 'KHAN Prompts',
    tagline TEXT DEFAULT 'Curated Free AI Prompts for Creators, Coders & Visionaries',
    primary_color TEXT DEFAULT '#7c3aed',
    whatsapp TEXT DEFAULT '1234567890',
    address TEXT DEFAULT 'Silicon Valley, CA & Worldwide',
    announce TEXT DEFAULT '🔥 Welcome to KHAN Prompts! Explore 100% free production-ready AI prompts updated regularly.',
    announce_on BOOLEAN DEFAULT true,
    logo_style TEXT DEFAULT 'gradient',
    updated_at TIMESTAMPTZ DEFAULT now()
);

-- ==========================================================
-- ROW LEVEL SECURITY (RLS) POLICIES
-- ==========================================================
-- Enable RLS on all tables
ALTER TABLE public.prompts ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.app_settings ENABLE ROW LEVEL SECURITY;

-- Prompts Policies (MVP: Public read & write; tighten with Supabase Auth in production)
DROP POLICY IF EXISTS "public read prompts" ON public.prompts;
CREATE POLICY "public read prompts" ON public.prompts FOR SELECT USING (true);

DROP POLICY IF EXISTS "public write prompts" ON public.prompts;
CREATE POLICY "public write prompts" ON public.prompts FOR ALL USING (true) WITH CHECK (true);

-- Categories Policies
DROP POLICY IF EXISTS "public read categories" ON public.categories;
CREATE POLICY "public read categories" ON public.categories FOR SELECT USING (true);

DROP POLICY IF EXISTS "public write categories" ON public.categories;
CREATE POLICY "public write categories" ON public.categories FOR ALL USING (true) WITH CHECK (true);

-- App Settings Policies
DROP POLICY IF EXISTS "public read app_settings" ON public.app_settings;
CREATE POLICY "public read app_settings" ON public.app_settings FOR SELECT USING (true);

DROP POLICY IF EXISTS "public write app_settings" ON public.app_settings;
CREATE POLICY "public write app_settings" ON public.app_settings FOR ALL USING (true) WITH CHECK (true);

-- Enable Realtime replication on prompts
ALTER PUBLICATION supabase_realtime ADD TABLE public.prompts;
ALTER PUBLICATION supabase_realtime ADD TABLE public.categories;
ALTER PUBLICATION supabase_realtime ADD TABLE public.app_settings;

-- ==========================================================
-- SEED DATA
-- ==========================================================

-- Seed Categories
INSERT INTO public.categories (name)
VALUES 
    ('Marketing'),
    ('Art'),
    ('Writing'),
    ('Business'),
    ('Coding')
ON CONFLICT (name) DO NOTHING;

-- Seed Default App Settings (Row id 1)
INSERT INTO public.app_settings (id, site_name, tagline, primary_color, whatsapp, address, announce, announce_on, logo_style)
VALUES (
    1,
    'KHAN Prompts',
    'Curated Free AI Prompts for Creators, Coders & Visionaries',
    '#7c3aed',
    '1234567890',
    'Silicon Valley, CA & Worldwide',
    '🔥 Welcome to KHAN Prompts! Explore 100% free production-ready AI prompts updated regularly.',
    true,
    'gradient'
)
ON CONFLICT (id) DO UPDATE SET
    site_name = EXCLUDED.site_name,
    tagline = EXCLUDED.tagline,
    primary_color = EXCLUDED.primary_color;

-- Seed Sample High-Quality Prompts
INSERT INTO public.prompts (title, image, description, prompt_text, category, featured, active, views, copies, likes)
VALUES 
(
    'Hyper-Realistic Cinematic Portrait Master',
    'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?auto=format&fit=crop&w=800&q=80',
    'Craft award-winning 8K photorealistic human portraits with cinematic lighting, depth of field, and photochemistry color grading in Midjourney & Stable Diffusion.',
    'A cinematic studio portrait of an elderly artisan with deep expressive eyes and weathered features, hands sculpting intricate clay, dramatic Rembrandt lighting with warm amber rim light, shot on 35mm anamorphic lens, f/1.4 aperture, subtle film grain, 8K resolution, octane render, photorealistic, shallow depth of field --ar 16:9 --v 6.0 --style raw',
    'Art',
    true,
    true,
    420,
    188,
    94
),
(
    'Viral LinkedIn Hook & Thought Leadership Carousel',
    'https://images.unsplash.com/photo-1557804506-669a67965ba0?auto=format&fit=crop&w=800&q=80',
    'Generate high-engagement viral B2B LinkedIn carousels and thought leadership posts engineered with proven psychological hooks.',
    'Act as a world-class B2B content strategist who has generated 50M+ views on LinkedIn. I need a 7-slide carousel breakdown about [TOPIC/INDUSTRY CHALLENGE]. Format requirements:\n1. Slide 1 (The Hook): A contrarian opening headline that stops the scroll (max 10 words).\n2. Slide 2 (The Hidden Cost): Explain why the standard way people do this is failing.\n3. Slide 3-5 (The Framework): Give a step-by-step 3-part blueprint with clear actionable examples.\n4. Slide 6 (Case in Point): A quick 2-sentence transformation story.\n5. Slide 7 (CTA): A conversational call to action encouraging saves and reposts. Tone: Authoritative, concise, devoid of buzzwords.',
    'Marketing',
    true,
    true,
    630,
    275,
    142
),
(
    'Production Code Refactor & Unit Test Suite Generator',
    'https://images.unsplash.com/photo-1555066931-4365d14bab8c?auto=format&fit=crop&w=800&q=80',
    'Transform messy legacy code into clean SOLID architecture complete with comprehensive edge-case test suites.',
    'Act as a Principal Software Engineer. Review the following code snippet for [LANGUAGE/FRAMEWORK]:\n\n```[PASTE CODE HERE]```\n\nTasks:\n1. Identify performance bottlenecks, potential race conditions, and architectural code smells.\n2. Provide an optimized, refactored version adhering strictly to SOLID principles, DRY, and modern idiomatic syntax.\n3. Add clean inline docstrings explaining non-trivial logic.\n4. Write a comprehensive unit test suite covering happy paths, null safety, boundary limits, and edge case failures using standard test assertions.',
    'Coding',
    true,
    true,
    890,
    412,
    215
),
(
    'SaaS Go-To-Market Pitch & Value Proposition Architect',
    'https://images.unsplash.com/photo-1460925895917-afdab827c52f?auto=format&fit=crop&w=800&q=80',
    'Develop an investor-ready pitch, clear positioning statement, and customer objection matrix for any B2B/B2C SaaS product.',
    'Act as an elite Y-Combinator venture partner and product marketing executive. Help me develop the positioning and Go-To-Market strategy for my software product: [BRIEF PRODUCT DESCRIPTION].\n\nDeliver:\n1. One-Sentence Elevator Pitch (The Steve Jobs style simplicity).\n2. Problem Statement: Quantify the financial and operational pain of our ideal customer persona.\n3. Value Wedge: 3 unfair advantages why we beat existing incumbents and spreadsheets.\n4. Objection Handling Matrix: Top 5 buyer objections and concise counter-arguments for enterprise sales demos.\n5. 30-Day Launch Roadmap focusing on organic acquisition channels.',
    'Business',
    false,
    true,
    315,
    140,
    67
)
ON CONFLICT DO NOTHING;
