import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hundred_day/day2/data/cartdata.dart';
import 'package:meta/meta.dart';

import '../../home/model/homeProductData.dart';

part 'cart_bloc_event.dart';
part 'cart_bloc_state.dart';

class CartBlocBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBlocBloc() : super(CartBlocInitialState()) {
    on<CartBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveFromCartEvent>(cartRemoveFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartBlocState> emit) {
    emit(CartBlocInitialState());
    Future.delayed(const Duration(seconds: 3), () {});
    try {
      emit(CartSuccessState(data: cartList));
    } catch (e) {
      emit(CartErrorState());
    }
  }

  FutureOr<void> cartRemoveFromCartEvent(
      CartRemoveFromCartEvent event, Emitter<CartBlocState> emit) {
    emit(CartDeleteItemClickedState());
    int id = event.id;
    cartList.removeWhere((element) => element.id == id);
    emit(CartSuccessState(data: cartList));
  }
}
