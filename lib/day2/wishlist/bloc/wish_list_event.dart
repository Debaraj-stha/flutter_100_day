part of 'wish_list_bloc.dart';

@immutable
sealed class WishListEvent {}

class DeleteButtonClickedEvent extends WishListEvent {
  final int id;

  DeleteButtonClickedEvent({required this.id});

}

class WishListDataLoadedEvent extends WishListEvent {}

class WishListDataLoadingEvent extends WishListEvent {}
