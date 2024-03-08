part of 'translate_bloc.dart';

@immutable
sealed class TranslateEvent {}
class ChnageLanguageTo extends TranslateEvent{
  final Iterable<Map<String, dynamic>> language;

  ChnageLanguageTo({required this.language});
}