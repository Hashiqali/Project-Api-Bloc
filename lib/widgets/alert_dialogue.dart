import 'package:flutter/material.dart';
import 'package:project_patch/bloc/note_bloc.dart';
import 'package:project_patch/widgets/snackbar.dart';

alert(context, NoteBloc noteBloc, id) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text('You want to delete?'),
          actions: [
            TextButton(
                onPressed: () {
                  noteBloc.add(DeleteNote(id: int.parse(id)));
                  Navigator.of(context).pop();
                       
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      });
}
