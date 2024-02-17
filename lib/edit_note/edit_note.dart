import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_patch/bloc/note_bloc.dart';
import 'package:project_patch/model/note_model.dart';
import 'package:project_patch/widgets/snackbar.dart';

// ignore: must_be_immutable
class Editscreen extends StatefulWidget {
  Editscreen({super.key, required this.note, required this.noteBloc});
  Note note;
  NoteBloc noteBloc;
  @override
  State<Editscreen> createState() => _EditscreenState();
}

class _EditscreenState extends State<Editscreen> {
  bool istrue = false;
  @override
  void initState() {
    notecontrooler.text = widget.note.note;
    istrue = widget.note.iscompleted;
    super.initState();
  }

  TextEditingController notecontrooler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Todo',
          style: TextStyle(fontFamily: 'Hashi', fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.white,
        height: size.height,
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              child: Column(
            children: [
              SizedBox(
                height: size.height / 30,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Type Something';
                  }
                  return null;
                },
                controller: notecontrooler,
                decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.note_alt),
                    border: OutlineInputBorder(),
                    labelText: 'Note'),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 3, top: 7),
                child: Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Completed',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Hashi',
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                    Switch(
                        value: istrue,
                        onChanged: (value) {
                          setState(() {
                            istrue = !istrue;
                            widget.noteBloc.add(PatchNote(
                                id: int.parse(widget.note.id),
                                data: {"completed": value}));
                            value == true
                                ? widget.noteBloc.add(SwitchTrue())
                                : widget.noteBloc.add(SwitchFalse());
                          });
                        },
                        activeColor: Colors.white,
                        activeTrackColor: Colors.teal,
                        trackColor:
                            const MaterialStatePropertyAll(Colors.white),
                        thumbColor: const MaterialStatePropertyAll(Colors.teal),
                        trackOutlineColor: const MaterialStatePropertyAll(
                            Color.fromARGB(255, 0, 0, 0))),
                  ],
                ),
              ),
              SizedBox(
                height: size.height / 40,
              ),
              InkWell(
                onTap: () {
                  submit();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(10)),
                  width: double.maxFinite,
                  height: size.height / 15,
                  child: const Center(
                      child: Text(
                    'Update',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700),
                  )),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  submit() {
    final note = notecontrooler.text.trim();
    final data = Note(id: widget.note.id, iscompleted: istrue, note: note);
    widget.noteBloc.add(EditNote(data: data));
    Navigator.of(context).pop();
    notecontrooler.text = '';
  }
}
