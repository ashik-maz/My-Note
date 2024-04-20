import 'package:flutter/material.dart';
import 'package:note/models/note_model.dart';
import 'package:note/screens/note_screen.dart';
import 'package:note/services/database_helper.dart';
import 'package:note/widgets/note_widget.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Text("Notes"),
        centerTitle: true,
      ),
      floatingActionButton: 
      FloatingActionButton(onPressed: () async {
            await Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NoteScreen()));
            setState(() {});
          },

      child: Icon(Icons.add),
      ),
      body: FutureBuilder<List<Note>?>(
        future: DatabaseHelper.getAllNotes(), 
        builder: (context, AsyncSnapshot<List<Note>?>snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator();
          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else if(snapshot.hasData){
            if(snapshot.data !=null){
              return ListView.builder(
                itemBuilder: (context, index) => NoteWidget(
                  note: snapshot.data![index], 
                  Ontap: ()async{
                    Navigator.push(context, MaterialPageRoute(builder:(context) => NoteScreen(
                      note: snapshot.data![index],
                    )));
                    setState(() {
                      
                    });
                  }, 
                  OnLongPress: (){
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Are you sure, you want to delete this note?"),
                          actions: [
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStatePropertyAll(Colors.red),
                              ),
                              onPressed: () async{
                                await DatabaseHelper.deleteNote(snapshot.data![index]);
                                Navigator.pop(context);
                                setState(() {
                                  
                                });
                              },
                              child: Text("Yes")),

                            ElevatedButton(onPressed: () => Navigator.pop(context), 
                            child: Text("No"))
                          ],
                        );
                      });
                  }
                  ),

                  itemCount: snapshot.data!.length,
                );
            }
            return Center(child: 
              Text("No note yet")
            );
          }
          return SizedBox.shrink();
          
        },
        ),
    );
  }
}