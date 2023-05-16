import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/componet/crud.dart';
import 'package:notesapp/app/constant/customtextforms.dart';
import 'package:notesapp/app/homepage.dart';


import '../constant/linkapi.dart';

class EditNote extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final notes;
  static const routeName = "addNotes";
  const EditNote({Key? key, this.notes}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote>  with Crud{
  GlobalKey<FormState> formstate =GlobalKey();
  TextEditingController title =TextEditingController() ;
  TextEditingController content =TextEditingController() ;


  File? myfile ;

  bool isloading=false;
  // ignore: non_constant_identifier_names
  EditNotes()async{
    isloading = true;
    setState(() {});
    // ignore: prefer_typing_uninitialized_variables
    var response ;
   if(myfile==null){
     response= await postRequest(linkEditNotes, {
       'title': title.text,
       'content' : content.text,
       'id' : widget.notes['note_id'].toString(),
       'imagename' : widget.notes['notes_image'].toString(),
     });
   }else{
     response= await postRequestWithFile(linkEditNotes, {
       'title': title.text,
       'content' : content.text,
       'imagename' : widget.notes['notes_image'].toString(),
       'id' : widget.notes['note_id'].toString()
     },myfile!);
   }

    isloading = false;
    setState(() {});
    if(response['status']=='Success'){
      // ignore: use_build_context_synchronously
      Navigator.popAndPushNamed(context, HomePage.routeName);
    }
  }

  @override
  void initState() {
    title.text= widget.notes['notes_title'];
    content.text= widget.notes['notes_content'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:isloading==true?const Center(child: CircularProgressIndicator(),): Form(
        key: formstate ,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextForms(label: "title", hintlabel: "Enter what you want", controller: title),
            TextForms(label: "content", hintlabel: "Enter what you want", controller: content),
            const SizedBox(height: 50,),
            MaterialButton(onPressed: (){
              showModalBottomSheet(context: context, builder: (context)=> SizedBox(
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(onPressed: ()async{
                      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      myfile= File(xfile!.path);


                    }, icon: const Icon(Icons.image_outlined)),
                    IconButton(onPressed: ()async{
                      XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                      myfile= File(xfile!.path);
                    }, icon: const Icon(Icons.camera)),

                  ],),
              ));
            } , child: const Text("Add Image " ,),),

            const SizedBox(height: 50,),

            ElevatedButton(onPressed: ()async{
              await EditNotes();
            }, child: const Text("Update Note"))

          ],
        ),
      ),

    );
  }
}
