// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class TextForms extends StatelessWidget {
  final label ;
  final hintlabel ;
  final TextEditingController controller;

  const TextForms({
    super.key,required this.label,required this.hintlabel, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width/1.2,
      height: size.height/15,
      child: TextFormField(

        controller: controller,
        maxLines: 10,
        decoration: InputDecoration(

          labelText: label,
          labelStyle: const TextStyle(fontSize: 13) ,
          hintText: hintlabel,
          hintStyle: const TextStyle(fontSize: 13) ,

          border: OutlineInputBorder(

            borderRadius: BorderRadius.circular(15),
          )
        ),
      ),
    );
  }
}
class Content extends StatelessWidget {
  final label ;
  final hintlabel ;
  final TextEditingController controller;

  const Content({
    super.key,required this.label,required this.hintlabel, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width/1.2,



      child: TextFormField(

        controller: controller,
        maxLines: 20,
        decoration: InputDecoration(
            labelText: label,
            labelStyle: const TextStyle(fontSize: 13) ,
            hintText: hintlabel,
            hintStyle: const TextStyle(fontSize: 13) ,

            border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(15),
            )
        ),
      ),
    );
  }
}