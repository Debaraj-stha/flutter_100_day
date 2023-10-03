import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hundred_day/day2/wishlist/bloc/wish_list_bloc.dart';
import 'package:hundred_day/day2/wishlist/ui/wishListProductCard.dart';

class WishList extends StatefulWidget {
  const WishList({super.key});

  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  final WishListBloc bloc = WishListBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.add(WishListDataLoadingEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wishlist"),
      ),
      body: BlocConsumer<WishListBloc, WishListState>(
        bloc: bloc,
        listenWhen: (previous, current) => current is WishListActionState,
        buildWhen: (previous, current) => current is! WishListActionState,
        listener: (context, state) {
          if (state is DeleteButtonClickedState) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Item deleted from wishlist")));
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case WishListInitial:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case WishListDateLoadedState:
              final wishListData = state as WishListDateLoadedState;
              return SingleChildScrollView(
                child: Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: wishListData.data.length,
                      itemBuilder: (context, index) {
                        return WishListProductCard(
                            data: wishListData.data[index], bloc: bloc);
                      }),
                ),
              );

            case WishListLoadingErrorState:
              return const Center(
                child: Text("Error"),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
