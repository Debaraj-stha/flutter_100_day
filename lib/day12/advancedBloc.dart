import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hundred_day/day12/bloc/test_bloc.dart';

import 'repository/Testrepo.dart';

class AdvancedBloc extends StatefulWidget {
  const AdvancedBloc({super.key});

  @override
  State<AdvancedBloc> createState() => _AdvancedBlocState();
}

class _AdvancedBlocState extends State<AdvancedBloc> {
  TestBloc bloc = TestBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.add(TestInitialEvenet());
    // bloc.add(CheckBoxCheckedEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Advanced Bloc"),
        actions: [
          BlocConsumer<TestBloc, TestState>(
              bloc: bloc,
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                switch (state.runtimeType) {
                  case WishListButtonClickedState:
                    final countData = state as WishListButtonClickedState;
                    return Row(
                      children: [
                        InkWell(
                          onTap: () {
                            // homeBloc.add(HometWishListButtonNavigateClickEvent());
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child:
                                    const Icon(Icons.favorite_outline_outlined),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  child: Text(
                                    countData.wishListCount.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            // homeBloc.add(HomeCartButtonNavigateClickedEvent());
                          },
                          child: Stack(
                            children: [
                              Container(
                                width: 40,
                                height: 40,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10)),
                                child: const Icon(Icons.shopping_bag),
                              ),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.red),
                                  width: 20,
                                  height: 20,
                                  alignment: Alignment.center,
                                  child: Text(
                                    countData.cartCount.toString(),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  default:
                    return Container();
                }
              })
        ],
      ),
      body: BlocConsumer<TestBloc, TestState>(
        listenWhen: (previous, current) => current is TestActionState,
        buildWhen: (previous, current) => current is! TestActionState,
        bloc: bloc,
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          print(state.runtimeType);
          switch (state.runtimeType) {
            case LoaadinProductState:
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            case ErrorProductState:
              final msg = state as ErrorProductState;
              print(msg);
              return Center(
                child: Container(
                    padding: const EdgeInsets.all(10),
                    alignment: Alignment.center,
                    child: Text(
                      msg.message,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.displaySmall,
                    )),
              );
            case LoadedProductState:
              final loadData = state as LoadedProductState;
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      ListView.builder(
                        itemCount: loadData.products.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          print("build");
                          final data = loadData.products[index];
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Colors.greenAccent, width: 2),
                            ),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(data.image),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  data.title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  data.description,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "\$${178}",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            bloc.add(
                                                WshListButtonClicked(type: 1));
                                          },
                                          icon:
                                              const Icon(Icons.favorite_border),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            bloc.add(
                                                WshListButtonClicked(type: 2));
                                          },
                                          icon: const Icon(Icons.shopping_cart),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      // BlocConsumer<TestBloc, TestState>(
                      //     listener: (context, state) {},
                      //     bloc: bloc,
                      //     builder: (context, state) {
                      //       switch (state.runtimeType) {
                      //         case CheckBoxState:
                      //           final states = state as CheckBoxState;

                      //           return CheckboxListTile(
                      //             value: states.isChecked,
                      //             title: const Text("Checkbox"),
                      //             controlAffinity:
                      //                 ListTileControlAffinity.platform,
                      //             onChanged: (value) {
                      //               bloc.add(CheckBoxCheckedEvent());
                      //             },
                      //           );

                      //         default:
                      //           return Container(
                      //             child: const Text("data"),
                      //           );
                      //       }
                      //     }),
                    ],
                  ),
                ),
              );
            default:
              return const SizedBox(
                height: 10,
                width: 10,
              );
          }
        },
      ),
    );
  }
}
