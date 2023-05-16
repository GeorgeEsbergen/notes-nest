import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/login.dart';
import 'package:notesapp/app/componet/cardnote.dart';
import 'package:notesapp/app/componet/crud.dart';
import 'package:notesapp/app/model.dart';
import 'package:notesapp/app/notes/add.dart';
import 'package:notesapp/app/notes/edit.dart';
import 'package:notesapp/main.dart';

import 'constant/linkapi.dart';

class HomePage extends StatefulWidget {
  static const routeName = "homepage";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>with Crud {

 getNotes()async{
   var response = await postRequest(linkViewNotes, {
      "id" : sharedPref.getString("id")
   });
   return response;

 }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton( onPressed: (){
        Navigator.pushNamed(context, AddNote.routeName);

      }, child: const Icon(Icons.add),),
      body: ListView(
        children: [
          Row(children: [
            IconButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(LoginScreen.routeName, (route) => false);
            }, icon:const Icon(Icons.exit_to_app_outlined))
          ],),
          const SizedBox(height: 30,),
          FutureBuilder(
            future: getNotes(),
              builder:(BuildContext context , AsyncSnapshot snapshot) {
                if(snapshot.hasData){
                  if(snapshot.data['status']=='fail') {
                    return const Center(child: Text("Page Is Empty "),);
                  }
                  return ListView.builder(itemBuilder: (context , i ){
                    return CardNote(
                      delete: ()async{
                        var response = await postRequest(linkDeleteNotes, {
                          'id': snapshot.data['data'][i]['note_id'].toString(),
                          'imagename':snapshot.data['data'][i]['notes_image'].toString(),
                        });
                        if(response['status']=='Success'){
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(context, HomePage.routeName);
                        }
                      },

                        onTap: (){
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context)=>EditNote(notes:snapshot.data['data'][i] ,)));
                    }, noteModel: NoteModel.fromJson(snapshot.data['data'][i]),);
                  });
                }
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const Center(child: Text("Loading..."));
                }
                return const Center(child: Text("Loading..."));
              }
          )
          

        ],
      )
    );
  }
}
