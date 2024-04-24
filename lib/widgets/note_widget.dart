

import 'package:flutter/material.dart';
import 'package:note/models/note_model.dart';

class NoteWidget extends StatelessWidget {
  final Note note;
  final VoidCallback Ontap;
  final VoidCallback OnLongPress;
  const NoteWidget({super.key, required this.note, required this.Ontap, required this.OnLongPress});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: OnLongPress,
      onTap: Ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 6),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(note.title,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),

                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6,vertical: 12),
                  child: Divider(thickness: 1,),
                ),
                Text(note.description,style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),)
              ],
            ),
          ),
        )
      ),
    );
  }
}