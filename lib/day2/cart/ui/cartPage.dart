import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hundred_day/day2/cart/bloc/cart_bloc_bloc.dart';
import 'package:hundred_day/day2/cart/ui/cartProductCard.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBlocBloc bloc = CartBlocBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: BlocConsumer<CartBlocBloc, CartBlocState>(
        bloc: bloc,
        buildWhen: (previous, current) => current is! CartActionState,
        listenWhen: (previous, current) => current is CartActionState,
        listener: (context, state) {
          // TODO: implement listener
          if (state is CartDeleteItemClickedState) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Item removed from cart Successfully")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartBlocInitialState:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case CartSuccessState:
              final cartData = state as CartSuccessState;
              return SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      itemCount: cartData.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CartProductCard(
                            data: cartData.data[index], bloc: bloc);
                      }),
                ),
              );
            case CartErrorState:
              return const Center(
                child: Text("Error has occured"),
              );
            default:
              return const SizedBox(
                height: 30,
                width: 40,
              );
          }
        },
      ),
    );
  }
}
