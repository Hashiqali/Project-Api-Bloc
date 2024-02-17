import 'dart:async';


import 'package:bloc/bloc.dart';


import 'package:meta/meta.dart';


import 'package:project_patch/api%20service/functions.dart';


import 'package:project_patch/model/note_model.dart';


part 'note_event.dart';


part 'note_state.dart';


class NoteBloc extends Bloc<NoteEvent, NoteState> {

  NoteBloc() : super(NoteInitial()) {

    on<InitialNote>(initialNote);


    on<DeleteNote>(deleteNote);


    on<EditNote>(editNote);


    on<PatchNote>(patchNote);


    on<EditButtonClick>(editButtonClick);


    on<SwitchTrue>(switchTrue);


    on<SwitchFalse>(switchFalse);

  }


  FutureOr<void> initialNote(InitialNote event, Emitter<NoteState> emit) async {

    try {

      emit(LoadingState());


      final values = await getallnotes();


      await Future.delayed(const Duration(seconds: 1));


      emit(SuccessState(items: values));

    } catch (e) {

      print('error');

    }

  }


  FutureOr<void> deleteNote(DeleteNote event, Emitter<NoteState> emit) async {

    final value = await deletenotes(event.id);


    final values = await getallnotes();


    if (value == true) {

      emit(DeletedNotestate());

    }


    emit(SuccessState(items: values));

  }


  FutureOr<void> editNote(EditNote event, Emitter<NoteState> emit) async {

    final value = await editnotes(event.data);


    final values = await getallnotes();
    if (value == true) {

      emit(EditedNotestate());
    }


    emit(SuccessState(items: values));

  }


  FutureOr<void> patchNote(PatchNote event, Emitter<NoteState> emit) async {

    final value = await patchnotes(event.data, event.id);

  }


  FutureOr<void> editButtonClick(

      EditButtonClick event, Emitter<NoteState> emit) {

    emit(GotoEditscreen(data: event.data));

  }


  FutureOr<void> switchTrue(SwitchTrue event, Emitter<NoteState> emit) {

    emit(SwitchTruestate());

  }


  FutureOr<void> switchFalse(SwitchFalse event, Emitter<NoteState> emit) {

    emit(Swiotchfalsestate());

  }

}

