import 'package:flutter/material.dart';
import 'package:hundred_day/day2/home/bloc/home_bloc_bloc.dart';
import 'package:hundred_day/day2/home/model/homeProductData.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.data, required this.bloc});
  final ProductData data;
  final HomeBlocBloc bloc;
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
              Text(
                "\$${data.price}",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        bloc.add(HomeProductWishListButtonClickedEvent(
                            productData: data, id: data.id));
                      },
                      icon: const Icon(Icons.favorite_border)),
                  IconButton(
                      onPressed: () {
                        bloc.add(HomeProductCartButtonClickedEvent(
                            productData: data, id: data.id));
                      },
                      icon: const Icon(Icons.shopping_cart))
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
