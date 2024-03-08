import 'dart:typed_data';

class Person {
  Person(
      {required this.id,
      required this.name,
      required this.template,
      required this.image});
  int id;
  String name;
  ByteData template;
  ByteData image;
  factory Person.fromJson(Map<String, dynamic> json) => Person(
      id: json['id'],
      name: json['name'],
      template: json['template'],
      image: json['image']);
  Map<String, dynamic> toJson() =>
      {"id": id, "name": name, "template": template, "image": image};
}
