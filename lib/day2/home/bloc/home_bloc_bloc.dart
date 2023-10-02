import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hundred_day/day2/data/cartdata.dart';
import 'package:hundred_day/day2/data/productItem.dart';
import 'package:hundred_day/day2/data/wishlistData.dart';
import 'package:hundred_day/day2/home/model/homeProductData.dart';
import 'package:meta/meta.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeBlocEvent>((event, emit) {});
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeCartButtonNavigateClickedEvent>(homeCartButtonNavigateClickedEvent);
    on<HometWishListButtonNavigateClickEvent>(
        hometWishListButtonNavigateClickEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeCartButtonNavigateClickedEvent(
      HomeCartButtonNavigateClickedEvent event, Emitter<HomeBlocState> emit) {
    print("cart button clicked");
    emit(HomeNavigateToCartPageState());
  }

  FutureOr<void> hometWishListButtonNavigateClickEvent(
      HometWishListButtonNavigateClickEvent event,
      Emitter<HomeBlocState> emit) {
    print("wishlist button clicked");
    emit(HomeNavigateToWishListPageState());
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
      HomeProductWishListButtonClickedEvent event,
      Emitter<HomeBlocState> emit) {
    print("home product wishist button clicked");
    wishlistData.add(event.productData);
    emit(HomeItemAddedToWishListState());
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeBlocState> emit) {
    print("home bottom product wishist button clicked");
    cartList.add(event.productData);
    emit(HomeItemAddToCartState());
  }

  FutureOr<void> homeInitialEvent(
      HomeBlocEvent event, Emitter<HomeBlocState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2), () {});

    emit(HomeLoadedSuccessState(
        products: GroceryData.groceryProducts
            .map((e) => ProductData(
                description: e['description'],
                image: e['image'],
                name: e['name'],
                price: e['price'],
                // rating: e[' rating'],
                id: e['id']))
            .toList()));
  }
}
