part of 'home_bloc_bloc.dart';

@immutable
sealed class HomeBlocState {}

abstract class HomeBlocActionState extends HomeBlocState {}

final class HomeBlocInitial extends HomeBlocState {}

class HomeLoadingState extends HomeBlocState {}

class HomeLoadedSuccessState extends HomeBlocState {
  final List<ProductData> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeLoadedErrorState extends HomeBlocState {}

class HomeNavigateToWishListPageState extends HomeBlocActionState {}

class HomeNavigateToCartPageState extends HomeBlocActionState {}

class HomeItemAddToCartState extends HomeBlocActionState {
  final String message;

  HomeItemAddToCartState({required this.message});
}

class HomeItemAddedToWishListState extends HomeBlocActionState {
  final String message;

  HomeItemAddedToWishListState({required this.message});
}

class ItemAlreadyWishlistedState extends HomeBlocActionState {
  final String message;

  ItemAlreadyWishlistedState({required this.message});
}

class ItemAlreadyCartedState extends HomeBlocActionState {
  final String message;

  ItemAlreadyCartedState({required this.message});
}

class WishlistItemChangeState extends HomeBlocState {
  final int itemCount;

  WishlistItemChangeState({required this.itemCount});
}
