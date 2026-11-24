import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'main_shell.dart';

class AuthScreen extends StatefulWidget {
 const AuthScreen({super.key});
 @override State<AuthScreen> createState()=>_AuthScreenState();
}
class _AuthScreenState extends State<AuthScreen>{
 final email=TextEditingController(), password=TextEditingController();
 bool register=false, busy=false;
 Future<void> submit() async {
  setState(()=>busy=true);
  try {
   final auth=Supabase.instance.client.auth;
   if(register){await auth.signUp(email:email.text.trim(),password:password.text);}
   else {await auth.signInWithPassword(email:email.text.trim(),password:password.text);}
   if(mounted) Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(_)=>const MainShell()));
  } catch(e){if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text(e.toString())));}
  if(mounted)setState(()=>busy=false);
 }
 @override Widget build(BuildContext context)=>Scaffold(body:SafeArea(child:Center(child:SingleChildScrollView(padding:const EdgeInsets.all(24),child:Column(mainAxisSize:MainAxisSize.min,children:[
  const Text('FOCUS',style:TextStyle(fontSize:36,fontWeight:FontWeight.bold,letterSpacing:2)),
  const SizedBox(height:24),Text(register?'Create account':'Welcome back'),
  const SizedBox(height:16),TextField(controller:email,keyboardType:TextInputType.emailAddress,decoration:const InputDecoration(labelText:'Email',border:OutlineInputBorder())),
  const SizedBox(height:12),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password',border:OutlineInputBorder())),
  const SizedBox(height:16),SizedBox(width:double.infinity,child:FilledButton(onPressed:busy?null:submit,child:Text(busy?'Please wait':register?'Sign up':'Log in'))),
  TextButton(onPressed:()=>setState(()=>register=!register),child:Text(register?'Already registered? Log in':'Create account'))
])))));
}
}
