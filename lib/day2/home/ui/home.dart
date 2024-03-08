import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hundred_day/day2/cart/ui/cartPage.dart';
import 'package:hundred_day/day2/home/bloc/home_bloc_bloc.dart';
import 'package:hundred_day/day2/home/ui/productCard.dart';
import 'package:hundred_day/day2/wishlist/ui/wishList.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeBlocBloc homeBloc = HomeBlocBloc();
  @override
  void initState() {
    // TODO: implement initState
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      bloc: homeBloc,
      buildWhen: (previous, current) => current is! HomeBlocActionState,
      listenWhen: (previous, current) => current is HomeBlocActionState,
      listener: (context, state) {
        print(state);
        if (state is HomeNavigateToCartPageState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartPage()));
        }
        if (state is HomeNavigateToWishListPageState) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const WishList()));
        } else if (state is HomeItemAddedToWishListState) {
          final msg = state;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              msg.message,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            closeIconColor: Colors.black,
            showCloseIcon: true,
            backgroundColor: Colors.greenAccent,
            dismissDirection: DismissDirection.startToEnd,
          ));
        } else if (state is HomeItemAddToCartState) {
          final msg = state;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              msg.message,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
            backgroundColor: Colors.greenAccent,
            showCloseIcon: true,
            dismissDirection: DismissDirection.startToEnd,
            closeIconColor: Colors.black,
          ));
        } else if (state is ItemAlreadyCartedState) {
          final msg = state;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
            elevation: 0,
            dismissDirection: DismissDirection.startToEnd,
            content: Text(
              msg.message,
              style: const TextStyle(fontSize: 18),
            ),
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ));
        } else if (state is ItemAlreadyWishlistedState) {
          final msg = state;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 1),
            elevation: 0,
            dismissDirection: DismissDirection.startToEnd,
            content: Text(
              msg.message,
              style: const TextStyle(fontSize: 18),
            ),
            showCloseIcon: true,
            closeIconColor: Colors.white,
          ));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Home page"),
                  actions: [
                    InkWell(
                      onTap: () {
                        homeBloc.add(HometWishListButtonNavigateClickEvent());
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.favorite_outline_outlined),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homeBloc.add(HomeCartButtonNavigateClickedEvent());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(Icons.shopping_bag),
                      ),
                    )
                  ],
                ),
                body: const Center(
                  child: CircularProgressIndicator(),
                ));
          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                title: const Text("Home page"),
                actions: [
                  InkWell(
                    onTap: () {
                      homeBloc.add(HometWishListButtonNavigateClickEvent());
                    },
                    child: Stack(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.favorite_outline_outlined),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.red),
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                            child: const Text(
                              "0",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      homeBloc.add(HomeCartButtonNavigateClickedEvent());
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: const Icon(Icons.shopping_bag),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                      padding: const EdgeInsets.all(10),
                      shrinkWrap: true,
                      itemCount: state.products.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final data = state.products[index];
                        print(data);
                        return ProductCard(data: data, bloc: homeBloc);
                      }),
                ),
              ),
            );
          case HomeLoadedErrorState:
            return Scaffold(
                appBar: AppBar(
                  title: const Text("Home page"),
                  actions: [
                    InkWell(
                      onTap: () {
                        homeBloc.add(HometWishListButtonNavigateClickEvent());
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.favorite_outline_outlined),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        homeBloc.add(HomeCartButtonNavigateClickedEvent());
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Icon(Icons.shopping_bag),
                      ),
                    )
                  ],
                ),
                body: const Center(
                  child: Text("Something went wrong||"),
                ));
          default:
            return Container(
              child: const Text("default text"),
            );
        }
      },
    );
  }
}
