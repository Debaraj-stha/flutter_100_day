import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateBloc() : super(TranslateInitial()) {
    on<TranslateEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<ChnageLanguageTo>(chnageLanguageTo);
  }

  FutureOr<void> chnageLanguageTo(
      ChnageLanguageTo event, Emitter<TranslateState> emit) {
    print("language event: ${event.language}");
    Iterable<Map<String, dynamic>> language = event.language;
    emit(ChangedLanguageState(language: language));
  }
}
