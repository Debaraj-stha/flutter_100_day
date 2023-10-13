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
    int id = event.id;
    int index = wishlistData.indexWhere((element) => element.id == id);
    if (index != -1) {
      emit(ItemAlreadyWishlistedState(
          message: "Item is already in the wish list"));
      return false;
    }
    wishlistData.add(event.productData);
    int itemCount = wishlistData.length;
    emit(HomeItemAddedToWishListState(
      message: "Item added to wishlist successfully",
    ));
    // emit(WishlistItemChangeState(itemCount: itemCount));
    print("itemcount: $itemCount");
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeBlocState> emit) {
    int id = event.id;
    int x = cartList.indexWhere((element) => element.id == id);
    print(x);

    if (x != -1) {
      emit(ItemAlreadyCartedState(message: "Item is  already in cart"));
      return false;
    }
    cartList.add(event.productData);
    emit(HomeItemAddToCartState(message: "Item added to cart successfully"));
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
