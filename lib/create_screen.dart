import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class CreateScreen extends StatefulWidget{const CreateScreen({super.key});@override State<CreateScreen> createState()=>_CreateScreenState();}
class _CreateScreenState extends State<CreateScreen>{
 final caption=TextEditingController();XFile? file;bool busy=false;
 Future<void> pick()async{final x=await ImagePicker().pickMedia();if(x!=null)setState(()=>file=x);}
 Future<void> publish()async{final user=Supabase.instance.client.auth.currentUser;if(user==null||file==null)return;setState(()=>busy=true);try{final bytes=await file!.readAsBytes();final ext=file!.name.split('.').last;final path='${user.id}/${DateTime.now().millisecondsSinceEpoch}.$ext';await Supabase.instance.client.storage.from('media').uploadBinary(path,bytes);final url=Supabase.instance.client.storage.from('media').getPublicUrl(path);await Supabase.instance.client.from('posts').insert({'user_id':user.id,'media_url':url,'caption':caption.text,'media_type':file!.mimeType?.startsWith('video')==true?'video':'image'});if(mounted)ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Post published')));caption.clear();setState(()=>file=null);}catch(e){if(mounted)ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('Upload failed: $e')));}if(mounted)setState(()=>busy=false);}
 @override Widget build(BuildContext context)=>Scaffold(appBar:AppBar(title:const Text('Create Post')),body:Padding(padding:const EdgeInsets.all(16),child:Column(children:[OutlinedButton.icon(onPressed:pick,icon:const Icon(Icons.photo_library),label:const Text('Choose photo/video')),if(file!=null)Text(file!.name),TextField(controller:caption,decoration:const InputDecoration(labelText:'Caption'),maxLines:3),const SizedBox(height:16),FilledButton(onPressed:busy?null:publish,child:Text(busy?'Uploading…':'Publish'))])));
}
