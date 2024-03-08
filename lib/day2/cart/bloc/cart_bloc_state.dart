part of 'cart_bloc_bloc.dart';

@immutable
sealed class CartBlocState {}

class CartActionState extends CartBlocState {}

class CartDeleteItemClickedState extends CartActionState {}

final class CartBlocInitialState extends CartBlocState {}

class CartErrorState extends CartBlocState {}

class CartSuccessState extends CartBlocState {
  final List<ProductData> data;

  CartSuccessState({required this.data});
}
