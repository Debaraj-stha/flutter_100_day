import 'package:flutter/material.dart';
import 'package:hundred_day/day2/cart/bloc/cart_bloc_bloc.dart';
import 'package:hundred_day/day2/home/bloc/home_bloc_bloc.dart';
import 'package:hundred_day/day2/home/model/homeProductData.dart';
import 'package:hundred_day/day2/wishlist/bloc/wish_list_bloc.dart';

class WishListProductCard extends StatelessWidget {
  const WishListProductCard(
      {super.key, required this.data, required this.bloc});
  final ProductData data;
  final WishListBloc bloc;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.greenAccent, width: 2)),
      margin: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(data.image), fit: BoxFit.cover)),
          ),
          Text(
            data.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Text(
            data.description,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(data.id.toString()),
              Text(
                "\$${data.price}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        bloc.add(DeleteButtonClickedEvent(id: data.id));
                      },
                      icon: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      )),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
