class Products {
  int id;
  String title;
  // double price; // Change the type to double
  String description;
  String category;
  String image;
  // Rating rating;

  Products({
    required this.category,
    required this.image,
    required this.id,
    required this.title,
    // required this.price,
    required this.description,
    // required this.rating,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        id: json['id'],
        category: json['category'],
        title: json['title'],
        // price: (json['price'] is int)
        //     ? json['price'].toDouble()
        //     : json['price'], // Handle both int and double values
        description: json['description'],
        image: json['image'],
        // rating: Rating.fromJson(json['rating']
        // ),
      );
}

// class Rating {
//   Rating({required this.rate, required this.count});
//   int count;
//   int rate;
//   factory Rating.fromJson(Map<String, dynamic> json) =>
//       Rating(rate: json['rate'], count: json['count']);
// }
