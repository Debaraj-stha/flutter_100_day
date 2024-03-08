void main() {
  B b = B(name: "manish", address: "Dharan", age: 12);
  b.displayDetails();
 
}

class A {
  String name;
  String address;
  int age;

  A({required this.name, required this.address, required this.age});
  void setDetails(String myName, String myAddress, int myAge) {
    name = myName;
    address = myAddress;
    age = myAge;
  }
}

class C {
  String phone;
  C({required this.phone});
  void setPhone(String myPhone) {
    phone = myPhone;
  }

  void showPhone() {
    print("phone is $phone");
  }
}

class B extends A {
  B({required super.name, required super.address, required super.age});
  void displayDetails() {
    print("age is ${age.toString()}");
    print("name is $name");
    print("address is $address");
  }
}

