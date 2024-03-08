void main() {
  C c = C(address: "Dharan", name: "Jeevan", age: 22);
  c.address = "dharan";
  c.age = 66;
  c.name = "mandip";
  c.displayDetails();
}

class A {
  String name;
  int age;
  A({required this.name, required this.age});
  displayDetails() => print("Name is $name and age is $age\n");
}

class B {
  String address;
  B({required this.address});
  displayDetailsB() => print("Address is $address");
}

class C implements A, B {
  @override
  String address = "";

  @override
  int age = 11;

  @override
  String name = "";
  C({required name, required address, required age}) {
    this.name = name;
    this.address = address;
    this.age = age;
  }
  @override
  displayDetails() {
    print("name is $name");
    print("age is $age");
    print("address is $address");
  }

  @override
  displayDetailsB() {}
}
