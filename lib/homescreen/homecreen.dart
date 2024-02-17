import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_patch/api%20service/functions.dart';
import 'package:project_patch/bloc/note_bloc.dart';
import 'package:project_patch/edit_note/edit_note.dart';
import 'package:project_patch/model/note_model.dart';
import 'package:project_patch/widgets/alert_dialogue.dart';
import 'package:project_patch/widgets/snackbar.dart';

List<Note> allItems = [];

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final noetbloc = NoteBloc();
  @override
  void initState() {
    noetbloc.add(InitialNote());

    super.initState();
  }

  bool istrue = false;

  @override
  Widget build(BuildContext context) {
    getallnotes();
    final size = MediaQuery.of(context).size;
    return BlocConsumer<NoteBloc, NoteState>(
      listenWhen: (previous, current) => current is NoteActionState,
      buildWhen: (previous, current) => current is! NoteActionState,
      listener: (context, state) {
        if (state is GotoEditscreen) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (ctx) => Editscreen(
                    noteBloc: noetbloc,
                    note: state.data,
                  )));
        } else if (state is SwitchTruestate) {
          snakbar(context, 'Completed true');
        } else if (state is Swiotchfalsestate) {
          snakbar(context, 'Completed false');
        } else if (state is DeletedNotestate) {
          snakbar(context, 'Deleted');
        } else if (state is EditedNotestate) {
          snakbar(context, 'Edited');
        }
      },
      bloc: noetbloc,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(color: Colors.teal),
            ),
          );
        }
        if (state is SuccessState) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Note Pad',
                style:
                    TextStyle(fontFamily: 'hashi', fontWeight: FontWeight.w900),
              ),
              backgroundColor: Colors.teal,
            ),
            body: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: ListView.builder(
                  itemCount: state.items.length,
                  itemBuilder: (ctx, index) {
                    final data = state.items[index];

                    return Card(
                      shadowColor: Colors.teal,
                      elevation: 10,
                      child: ListTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Note ${index + 1}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        noetbloc
                                            .add(EditButtonClick(data: data));
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      )),
                                  IconButton(
                                      onPressed: () {
                                        alert(context, noetbloc, data.id);
                                      },
                                      icon: const Icon(
                                          color: Colors.red,
                                          Icons.delete_outline_outlined)),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Switch(
                                        value: data.iscompleted,
                                        onChanged: (value) {
                                          setState(() {
                                            data.iscompleted =
                                                !data.iscompleted;
                                            noetbloc.add(PatchNote(
                                                id: int.parse(data.id),
                                                data: {"completed": value}));
                                            value == true
                                                ? noetbloc.add(SwitchTrue())
                                                : noetbloc.add(SwitchFalse());
                                          });
                                        },
                                        activeColor: Colors.white,
                                        activeTrackColor: Colors.teal,
                                        trackColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white),
                                        thumbColor:
                                            const MaterialStatePropertyAll(
                                                Colors.teal),
                                        trackOutlineColor:
                                            const MaterialStatePropertyAll(
                                                Colors.white)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            data.note,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
