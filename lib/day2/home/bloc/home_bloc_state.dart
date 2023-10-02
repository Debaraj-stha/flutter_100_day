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

class HomeItemAddToCartState extends HomeBlocActionState {}

class HomeItemAddedToWishListState extends HomeBlocActionState {}
