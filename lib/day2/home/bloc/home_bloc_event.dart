part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class HomeInitialEvent extends HomeBlocEvent {}

class HomeProductWishListButtonClickedEvent extends HomeBlocEvent {
  final ProductData productData;
  final int id;
  HomeProductWishListButtonClickedEvent(
      {required this.productData, required this.id});
}

class HomeProductCartButtonClickedEvent extends HomeBlocEvent {
  final ProductData productData;
  final int id;

  HomeProductCartButtonClickedEvent(
      {required this.productData, required this.id});
}

class HometWishListButtonNavigateClickEvent extends HomeBlocEvent {}

class HomeCartButtonNavigateClickedEvent extends HomeBlocEvent {}
