part of 'note_bloc.dart';


@immutable

sealed class NoteEvent {}


class InitialNote extends NoteEvent {}


class DeleteNote extends NoteEvent {

  int id;


  DeleteNote({required this.id});

}


class EditNote extends NoteEvent {

  final Note data;


  EditNote({required this.data});

}


class PatchNote extends NoteEvent {

  final int id;


  Map<String, dynamic> data;


  PatchNote({required this.id, required this.data});

}


class EditButtonClick extends NoteEvent {

  final Note data;


  EditButtonClick({required this.data});

}


class SwitchTrue extends NoteEvent {}


class SwitchFalse extends NoteEvent {}

