import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'feed_screen.dart';
import 'reels_screen.dart';
import 'create_screen.dart';
import 'messages_screen.dart';
import 'profile_screen.dart';
class MainShell extends StatefulWidget{const MainShell({super.key});@override State<MainShell> createState()=>_MainShellState();}
class _MainShellState extends State<MainShell>{
 int index=0;
 final screens=const [FeedScreen(),ReelsScreen(),CreateScreen(),MessagesScreen(),ProfileScreen()];
 @override Widget build(BuildContext context)=>Scaffold(body:IndexedStack(index:index,children:screens),bottomNavigationBar:NavigationBar(selectedIndex:index,onDestinationSelected:(v)=>setState(()=>index=v),destinations:const [
 NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:'Home'),
 NavigationDestination(icon:Icon(Icons.play_circle_outline),label:'Reels'),
 NavigationDestination(icon:Icon(Icons.add_box_outlined),label:'Create'),
 NavigationDestination(icon:Icon(Icons.chat_outlined),label:'Messages'),
 NavigationDestination(icon:Icon(Icons.person_outline),label:'Profile'),
 ]));
}
