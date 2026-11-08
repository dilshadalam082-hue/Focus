import 'package:flutter/material.dart';

void main() => runApp(const FocusApp());

const Color focusInk = Color(0xFF101321);
const Color focusPurple = Color(0xFF7C4DFF);
const Color focusPink = Color(0xFFFF4FA3);
const Color focusBlue = Color(0xFF36C5F0);

class FocusApp extends StatelessWidget {
  const FocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FOCUS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F8FC),
        colorScheme: ColorScheme.fromSeed(seedColor: focusPurple),
        fontFamily: 'Roboto',
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [FeedPage(), ReelsPage(), CreatePage(), InboxPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        backgroundColor: Colors.white,
        indicatorColor: focusPurple.withOpacity(.12),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.play_circle_outline), selectedIcon: Icon(Icons.play_circle), label: 'Reels'),
          NavigationDestination(icon: Icon(Icons.add_box_outlined), selectedIcon: Icon(Icons.add_box), label: 'Create'),
          NavigationDestination(icon: Icon(Icons.chat_bubble_outline), selectedIcon: Icon(Icons.chat_bubble), label: 'Chat'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, this.small = false});
  final bool small;
  @override
  Widget build(BuildContext context) => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: small ? 30 : 38, height: small ? 30 : 38,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [focusBlue, focusPurple, focusPink]),
        ),
        child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: small ? 22 : 28),
      ),
      const SizedBox(width: 9),
      Text('FOCUS', style: TextStyle(fontSize: small ? 19 : 24, fontWeight: FontWeight.w900, letterSpacing: 2.1, color: focusInk)),
    ],
  );
}

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});
  @override
  Widget build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverAppBar(
        floating: true, backgroundColor: const Color(0xFFF8F8FC),
        title: const BrandMark(),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
          const SizedBox(width: 6),
        ],
      ),
      SliverToBoxAdapter(
        child: SizedBox(
          height: 112,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            scrollDirection: Axis.horizontal,
            children: const [
              StoryBubble(label: 'Your story', add: true),
              StoryBubble(label: 'Ayesha', colors: [focusPink, focusPurple]),
              StoryBubble(label: 'Omar', colors: [focusBlue, focusPurple]),
              StoryBubble(label: 'Mariam', colors: [Color(0xFFFFB74D), focusPink]),
              StoryBubble(label: 'Khalid', colors: [focusPurple, focusBlue]),
              StoryBubble(label: 'Sara', colors: [focusPink, Color(0xFFFFB74D)]),
            ],
          ),
        ),
      ),
      const SliverToBoxAdapter(child: Divider(height: 1)),
      SliverList(delegate: SliverChildListDelegate(const [
        PostCard(name: 'focus.community', location: 'Discover • Community', caption: 'Your space to share moments, ideas and creativity. Welcome to FOCUS.'),
        PostCard(name: 'daily.inspiration', location: 'Today’s inspiration', caption: 'Stay connected to what matters. Share your story with the FOCUS community.'),
      ])),
    ],
  );
}

class StoryBubble extends StatelessWidget {
  const StoryBubble({super.key, required this.label, this.add = false, this.colors = const [focusPurple, focusPink]});
  final String label;
  final bool add;
  final List<Color> colors;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: 76,
    child: Column(children: [
      Container(
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: colors)),
        child: CircleAvatar(radius: 29, backgroundColor: Colors.white,
          child: add ? const Icon(Icons.add, color: focusPurple, size: 28) : const Icon(Icons.person, color: Color(0xFF9A9AA8), size: 30)),
      ),
      const SizedBox(height: 5),
      Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
    ]),
  );
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.name, required this.location, required this.caption});
  final String name, location, caption;
  @override
  Widget build(BuildContext context) => Card(
    margin: const EdgeInsets.fromLTRB(12, 12, 12, 4),
    color: Colors.white, elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18), side: const BorderSide(color: Color(0xFFECECF2))),
    clipBehavior: Clip.antiAlias,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFEDE7FF), child: Icon(Icons.person, color: focusPurple)),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(location, style: const TextStyle(fontSize: 11)),
        trailing: const Icon(Icons.more_horiz),
      ),
      Container(
        height: 230, width: double.infinity,
        decoration: const BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF202A55), focusPurple, focusPink])),
        child: const Center(child: BrandMark()),
      ),
      Padding(
        padding: const EdgeInsets.fromLTRB(14, 8, 14, 14),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.mode_comment_outlined)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.send_outlined)),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          ]),
          Text(caption, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 5),
          const Text('View all comments', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ]),
      ),
    ]),
  );
}

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: FeaturePlaceholder(icon: Icons.play_circle_outline, title: 'FOCUS Reels', detail: 'Short videos will appear here when video upload and media storage are connected.'));
}
class CreatePage extends StatelessWidget {
  const CreatePage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: FeaturePlaceholder(icon: Icons.add_a_photo_outlined, title: 'Create a post', detail: 'Photo and video publishing will be enabled after secure media storage is configured.'));
}
class InboxPage extends StatelessWidget {
  const InboxPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: FeaturePlaceholder(icon: Icons.forum_outlined, title: 'Messages', detail: 'Private messaging and audio/video calling require the FOCUS backend and calling service.'));
}
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(20), children: [
    const Center(child: BrandMark()),
    const SizedBox(height: 28),
    const CircleAvatar(radius: 46, backgroundColor: Color(0xFFEDE7FF), child: Icon(Icons.person, size: 48, color: focusPurple)),
    const SizedBox(height: 12),
    const Center(child: Text('Your FOCUS profile', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))),
    const SizedBox(height: 22),
    const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ProfileStat(value: '0', label: 'Posts'), ProfileStat(value: '0', label: 'Followers'), ProfileStat(value: '0', label: 'Following'),
    ]),
    const SizedBox(height: 24),
    SwitchListTile(value: true, onChanged: (_) {}, title: const Text('Private account'), subtitle: const Text('Beta placeholder — privacy controls need backend enforcement')),
    const ListTile(leading: Icon(Icons.language), title: Text('Language'), subtitle: Text('English • العربية • हिन्दी')),
    const ListTile(leading: Icon(Icons.verified_user_outlined), title: Text('Privacy & security')),
  ]);
}

class ProfileStat extends StatelessWidget {
  const ProfileStat({super.key, required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
    Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
  ]);
}
class FeaturePlaceholder extends StatelessWidget {
  const FeaturePlaceholder({super.key, required this.icon, required this.title, required this.detail});
  final IconData icon;
  final String title, detail;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(28),
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const BrandMark(),
      const SizedBox(height: 32),
      Icon(icon, size: 64, color: focusPurple),
      const SizedBox(height: 16),
      Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Text(detail, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black54, height: 1.5)),
    ]),
  );
}
