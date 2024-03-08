part of 'wish_list_bloc.dart';

@immutable
sealed class WishListState {}

abstract class WishListActionState extends WishListState {}

final class WishListInitial extends WishListState {}

class DeleteButtonClickedState extends WishListActionState {}

class WishListDateLoadedState extends WishListState {
  final List<ProductData> data;

  WishListDateLoadedState({required this.data});
}

class WishListLoadingErrorState extends WishListState {}

class ItemAlreadyWishlistedState extends WishListActionState {
  final int id;

  ItemAlreadyWishlistedState({required this.id});
}
