import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:hundred_day/day12/data/prodcutsModel.dart';
import 'package:hundred_day/day12/data/wishlist.dart';
import 'package:hundred_day/day12/repository/Testrepo.dart';
import 'package:meta/meta.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestInitial()) {
    on<TestEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<WshListButtonClicked>(whListButtonClicked);
    on<TestInitialEvenet>(testInitialEvenet);
    on<CheckBoxCheckedEvent>(checkBoxCheckedEvent);
  }

  FutureOr<void> whListButtonClicked(
      WshListButtonClicked event, Emitter<TestState> emit) {
    int type = event.type;
    type == 1 ? counterData['wishlist']++ : counterData['cart']++;
    int wishListCount = counterData['wishlist'];
    int cartCount = counterData['cart'];
    emit(WishListButtonClickedState(
        wishListCount: wishListCount, cartCount: cartCount));
  }

  FutureOr<void> testInitialEvenet(
      TestInitialEvenet event, Emitter<TestState> emit) async {
    int wishListCount = counterData['wishlist'];
    int cartCount = counterData['cart'];

    emit(WishListButtonClickedState(
        wishListCount: wishListCount, cartCount: cartCount));
    emit(LoaadinProductState());
    Future.delayed(const Duration(seconds: 1), () {});
    try {
      List<Products> products = await TestRepo().getProducts();

      emit(LoadedProductState(products: products));
    } catch (e) {
      emit(ErrorProductState(message: "Exception:$e"));
    }
  }

  FutureOr<void> checkBoxCheckedEvent(
      CheckBoxCheckedEvent event, Emitter<TestState> emit) {
    // Toggle the checkbox state
    final currentState = state as CheckBoxState;
    final newCheckBoxState = CheckBoxState(isChecked: !currentState.isChecked);
    emit(newCheckBoxState);
  }
}
