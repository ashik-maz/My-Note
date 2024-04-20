import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note/models/note_model.dart';
import 'package:note/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;
  const NoteScreen({super.key, this.note});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title;
      descriptionController.text = note!.description;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text(note==null ? "Add Note" : "Edit note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Center(
                child: Text("What are you thinking about?",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Center(
                child: TextField(
                  controller: titleController,
                  maxLines: 1,
                  decoration: InputDecoration(
                    hintText: "Title",
                    labelText: "Note Title",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,

                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                ),


              ),
            ),
            TextField(
                  controller: descriptionController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: "Type here the note",
                    labelText: "Note description",
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                        width: 0.75,

                      ),
                      borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                  ),
                  keyboardType: TextInputType.multiline,
                  onChanged: (str) {
                    
                  },
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: SizedBox(
                    height: 45,
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: ()async{
                        final title = titleController.value.text;
                        final description = descriptionController.value.text;

                        if(title.isEmpty || description.isEmpty){
                          return;
                        }


                        final Note model=Note(title: title, description: description,id: note?.id);

                        if(note==null){
                          await DatabaseHelper.addNote(model);
                        }
                        else{
                          await DatabaseHelper.updateNote(model);
                        }
                        Navigator.pop(context);
                        
                      }, 
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white,width: 0.75),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          )
                        )
                      ),
                    child: Text(note == null ?
                      "save" : "Edit",
                      style: TextStyle(fontSize: 20),
                    )
                    ),
                  ),
                )
            
          ],
        ),
      ),


    );
  }
}
