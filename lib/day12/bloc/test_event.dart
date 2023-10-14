part of 'test_bloc.dart';

@immutable
sealed class TestEvent {}

class TestInitialEvenet extends TestEvent {}

class WshListButtonClicked extends TestEvent {
  final int type;

  WshListButtonClicked({required this.type});
}
class CheckBoxCheckedEvent extends TestEvent {}