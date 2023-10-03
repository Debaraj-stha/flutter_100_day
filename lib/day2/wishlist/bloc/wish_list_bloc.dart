import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hundred_day/day2/data/wishlistData.dart';
import 'package:hundred_day/day2/home/model/homeProductData.dart';
import 'package:hundred_day/day2/wishlist/ui/wishList.dart';
import 'package:meta/meta.dart';

part 'wish_list_event.dart';
part 'wish_list_state.dart';

class WishListBloc extends Bloc<WishListEvent, WishListState> {
  WishListBloc() : super(WishListInitial()) {
    on<WishListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<WishListDataLoadingEvent>(wishListDataLoadingEvent);
    on<DeleteButtonClickedEvent>(deleteButtonClickedEvent);
  }

  FutureOr<void> wishListDataLoadingEvent(
      WishListDataLoadingEvent event, Emitter<WishListState> emit) async {
    emit(WishListInitial());
    await Future.delayed(const Duration(seconds: 2), () {});
    emit(WishListDateLoadedState(data: wishlistData));
  }

  FutureOr<void> deleteButtonClickedEvent(
      DeleteButtonClickedEvent event, Emitter<WishListState> emit) {
    emit(DeleteButtonClickedState());
    int id = event.id;
    print(id);
    wishlistData.removeWhere((ele) => ele.id == id);
    emit(WishListDateLoadedState(data: wishlistData));
    print("deleted");
  }
}
