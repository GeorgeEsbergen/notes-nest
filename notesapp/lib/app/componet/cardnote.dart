import 'package:flutter/material.dart';

import 'package:notesapp/app/model.dart';

import '../constant/linkapi.dart';

class CardNote extends StatelessWidget {
  final Function()? onTap;
  final Function()? delete;
  final NoteModel noteModel;

  const CardNote({
    Key? key,
    required this.onTap,
    required this.noteModel,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: ListTile(
          subtitle: Text('${noteModel.notesContent}'),
          title: Text("${noteModel.notesTitle}"),
          leading: Image.network("$linkImageRoot/${noteModel.notesImages}"),
          trailing:
              IconButton(onPressed: delete, icon: const Icon(Icons.delete)),
        ),
      ),
    );
  }
}
