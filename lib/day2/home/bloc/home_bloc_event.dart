part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocEvent {}

class HomeInitialEvent extends HomeBlocEvent {}

class HomeProductWishListButtonClickedEvent extends HomeBlocEvent {
  final ProductData productData;

  HomeProductWishListButtonClickedEvent({required this.productData});
}

class HomeProductCartButtonClickedEvent extends HomeBlocEvent {
    final ProductData productData;

  HomeProductCartButtonClickedEvent({required this.productData});
}

class HometWishListButtonNavigateClickEvent extends HomeBlocEvent {}

class HomeCartButtonNavigateClickedEvent extends HomeBlocEvent {}
