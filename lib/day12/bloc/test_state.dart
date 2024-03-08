part of 'test_bloc.dart';

@immutable
sealed class TestState {}

class TestActionState extends TestState {}

final class TestInitial extends TestState {}

class WishListButtonClickedState extends TestActionState {
  final int wishListCount;
  final int cartCount;
  WishListButtonClickedState(
      {required this.wishListCount, required this.cartCount});
}

class CheckBoxState extends TestActionState {
  final bool isChecked;

  CheckBoxState({required this.isChecked});

  @override
  List<Object> get props => [isChecked];
}

class LoaadinProductState extends TestState {}

class LoadedProductState extends TestState {
  final List<Products> products;

  LoadedProductState({required this.products});
}

class ErrorProductState extends TestState {
  final String message;

  ErrorProductState({required this.message});
}
