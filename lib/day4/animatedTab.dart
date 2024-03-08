import 'package:flutter/material.dart';
import 'package:hundred_day/day4/data.dart';

import 'package:flutter/material.dart';

class AnimatedListTab extends StatefulWidget {
  const AnimatedListTab({Key? key}) : super(key: key);

  @override
  State<AnimatedListTab> createState() => _AnimatedListTabState();
}

class _AnimatedListTabState extends State<AnimatedListTab> {
  List<String> foodCategory = [];
  Map<String, List<Map<String, dynamic>>> categorizedFood = {};
  final ScrollController _mainScrollController = ScrollController();
  final ScrollController _categoryScrollController = ScrollController();
  int selectedCategoryIndex = 0;

  @override
  void initState() {
    super.initState();
    findCategory();
    groupedItem();

    _mainScrollController.addListener(() {
      // Calculate the visible area and adjust the selected category accordingly.
      double startPosition = 0;
      double endPosition = 0;
      double currentScrollPosition = _mainScrollController.position.pixels;

      for (int i = 0; i < foodCategory.length; i++) {
        final category = foodCategory[i];
        final categoryHeight =
            categorizedFood[category]!.length * 380.0; // Adjust this height

        startPosition = endPosition;
        endPosition = startPosition + categoryHeight;

        if (currentScrollPosition >= startPosition &&
            currentScrollPosition <= endPosition) {
          setState(() {
            selectedCategoryIndex = i;
          });

          // Scroll the category list view to show the selected category.
          _categoryScrollController
              .jumpTo(i * 50.0); // Adjust the offset as needed
          break;
        }
      }
    });
  }

  void findCategory() {
    for (var food in foodList) {
      String category = food['category'];
      if (!foodCategory.contains(category)) {
        foodCategory.add(category);
      }
    }
  }

  void groupedItem() {
    for (var item in foodList) {
      var category = item['category'];
      if (categorizedFood.containsKey(category)) {
        categorizedFood[category]!.add(item);
      } else {
        categorizedFood[category] = [item];
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          controller: _mainScrollController,
          slivers: <Widget>[
            const SliverAppBar(
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image(
                  image: AssetImage("asset/images/d.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 50.0,
                maxHeight: 50.0,
                child: Container(
                  color: Colors.white,
                  child: ListView.builder(
                    controller: _categoryScrollController,
                    itemCount: foodCategory.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          // Calculate the target position for the selected category.
                          double targetPosition = 0;
                          for (int i = 0; i < index; i++) {
                            final category = foodCategory[i];
                            final categoryHeight =
                                categorizedFood[category]!.length *
                                    380.0; // Adjust this height
                            targetPosition += categoryHeight;
                          }

                          // Animate to the target position.
                          _mainScrollController.animateTo(
                            targetPosition,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: selectedCategoryIndex == index
                                ? Colors.greenAccent
                                : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Text(
                            foodCategory[index],
                            style: TextStyle(
                              color: selectedCategoryIndex == index
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: categorizedFood.length,
                (context, index) {
                  final cat = categorizedFood.entries.elementAt(index);
                  final key = cat.key;
                  final item = cat.value;
                  print("cat$cat");
                  print(item);

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        key.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      ListView.builder(
                        itemCount: item.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final data = item[index];
                          return Container(
                            height: 380,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.greenAccent,
                                width: 2,
                              ),
                            ),
                            margin: const EdgeInsets.only(
                              bottom: 10,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("asset/images/d.jpg"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Text(
                                  data['name'],
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  data['description'],
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "\$${data['price']}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            // Handle favorite button click.
                                          },
                                          icon:
                                              const Icon(Icons.favorite_border),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // Handle cart button click.
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
                    ],
                  );
                  
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant _SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
