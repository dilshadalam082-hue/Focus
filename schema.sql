-- Run this script in Supabase SQL Editor. Review policies and storage security before production.
create table if not exists public.profiles (
 id uuid primary key references auth.users(id) on delete cascade,
 username text unique,
 avatar_url text,
 bio text default '',
 created_at timestamptz default now()
);
create table if not exists public.posts (
 id uuid primary key default gen_random_uuid(),
 user_id uuid not null references auth.users(id) on delete cascade,
 media_url text not null,
 media_type text not null default 'image' check(media_type in ('image','video')),
 caption text default '',
 created_at timestamptz default now()
);
create table if not exists public.likes (
 post_id uuid references public.posts(id) on delete cascade,
 user_id uuid references auth.users(id) on delete cascade,
 created_at timestamptz default now(),
 primary key(post_id,user_id)
);
create table if not exists public.comments (
 id uuid primary key default gen_random_uuid(),
 post_id uuid references public.posts(id) on delete cascade,
 user_id uuid references auth.users(id) on delete cascade,
 body text not null,
 created_at timestamptz default now()
);
create table if not exists public.follows (
 follower_id uuid references auth.users(id) on delete cascade,
 following_id uuid references auth.users(id) on delete cascade,
 created_at timestamptz default now(),
 primary key(follower_id,following_id),
 check(follower_id <> following_id)
);
alter table profiles enable row level security;
alter table posts enable row level security;
alter table likes enable row level security;
alter table comments enable row level security;
alter table follows enable row level security;
create policy "profiles readable" on profiles for select using (true);
create policy "profile owner insert" on profiles for insert with check (auth.uid()=id);
create policy "profile owner update" on profiles for update using (auth.uid()=id);
create policy "posts readable" on posts for select using (true);
create policy "post owner create" on posts for insert with check (auth.uid()=user_id);
create policy "post owner update" on posts for update using (auth.uid()=user_id);
create policy "post owner delete" on posts for delete using (auth.uid()=user_id);
create policy "likes readable" on likes for select using (true);
create policy "like own" on likes for insert with check (auth.uid()=user_id);
create policy "unlike own" on likes for delete using (auth.uid()=user_id);
create policy "comments readable" on comments for select using (true);
create policy "comment own" on comments for insert with check (auth.uid()=user_id);
create policy "comment delete own" on comments for delete using (auth.uid()=user_id);
create policy "follows readable" on follows for select using (true);
create policy "follow own" on follows for insert with check (auth.uid()=follower_id);
create policy "unfollow own" on follows for delete using (auth.uid()=follower_id);
-- Create storage buckets via Supabase dashboard (media, avatars); review bucket policies before launch.
