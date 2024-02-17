part of 'note_bloc.dart';


@immutable

sealed class NoteState {}


abstract class NoteActionState extends NoteState {}


class GotoEditscreen extends NoteActionState {

  final Note data;


  GotoEditscreen({required this.data});

}


class SwitchTruestate extends NoteActionState {}


class Swiotchfalsestate extends NoteActionState {}


class DeletedNotestate extends NoteActionState {}


class EditedNotestate extends NoteActionState {}


final class NoteInitial extends NoteState {}


class LoadingState extends NoteState {}


class SuccessState extends NoteState {

  List<Note> items = [];


  SuccessState({required this.items});

}

