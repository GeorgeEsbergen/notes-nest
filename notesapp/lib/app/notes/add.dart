// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/app/componet/crud.dart';
import 'package:notesapp/app/constant/customtextforms.dart';
import 'package:notesapp/app/homepage.dart';
import 'package:notesapp/main.dart';

import '../constant/linkapi.dart';

class AddNote extends StatefulWidget {
  static const routeName = "addNotes";
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote>  with Crud{
  GlobalKey<FormState> formstate =GlobalKey();
  File? myfile;
  TextEditingController title =TextEditingController() ;
  TextEditingController content =TextEditingController() ;

  bool isloading=false;
  AddNotes()async{
    if(myfile== null )return AwesomeDialog(context: context ,title: "Important" ,body: const Text("didn't import image"))..show();
    isloading = true;
    setState(() {});
    var response = await postRequestWithFile(linkAddNotes, {
      'title': title.text,
      'content' : content.text,
      'id' : sharedPref.getString('id')
    }, myfile! );

    isloading = false;
    setState(() {});
    if(response['status']=='Success'){
      Navigator.popAndPushNamed(context, HomePage.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:isloading==true?const Center(child: CircularProgressIndicator(),): SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Form(
                  key: formstate ,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextForms(label: "title", hintlabel: "Enter what you want", controller: title),
                      const SizedBox(height: 20,),
                      Content(label: "content", hintlabel: "Enter what you want", controller: content),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          MaterialButton(onPressed: (){
                            showModalBottomSheet(context: context, builder: (context)=> SizedBox(
                              height: 100,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  IconButton(onPressed: ()async{
                                    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.gallery);
                                    Navigator.of(context).pop();
                                    myfile= File(xfile!.path);


                                  }, icon: const Icon(Icons.image_outlined)),
                                  IconButton(onPressed: ()async{
                                    XFile? xfile = await ImagePicker().pickImage(source: ImageSource.camera);
                                    Navigator.of(context).pop();
                                    myfile= File(xfile!.path);
                                  }, icon: const Icon(Icons.camera)),

                                ],),
                            ));
                          } , child: const Text("Add Image " ,),),

                          ElevatedButton(onPressed: ()async{
                            await AddNotes();
                          }, child: const Text("Add Note")),
                        ],
                      )

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}
