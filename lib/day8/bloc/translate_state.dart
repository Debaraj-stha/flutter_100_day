part of 'translate_bloc.dart';

@immutable
sealed class TranslateState {}
class TranslateActionState extends TranslateState{}
final class TranslateInitial extends TranslateState {}
class ChangedLanguageState extends TranslateState {
  final Iterable<Map<String, dynamic>> language;

  ChangedLanguageState({required this.language});
}