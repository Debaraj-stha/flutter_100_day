void main() {
  Teacher t = Teacher();
  t.getName("haisha");

  t.getSubject("Nepali");
  t.getAge(44);
  t.displaySubject();
  t.displayAge();
  t.displayName();
  Student s = Student();
  s.getName("Deepa");
  s.getRoll(9);
  s.getAge(22);
  s.displayAge();
  s.displayName();
  s.displayRoll();
}

class Student with Name, Age {
  int? roll;
  void getRoll(int myroll) {
    roll = myroll;
  }

  void displayRoll() {
    print("subject no is $roll");
  }
}

class Teacher with Name, Age {
  String? subject;
  void getSubject(String mySubject) {
    subject = mySubject;
  }

  void displaySubject() {
    print("subject no is $subject");
  }
}

mixin Name {
  String? name;
  void getName(String myName) {
    name = myName;
  }

  void displayName() {
    print("name no is $name");
  }
}
mixin Age {
  int? age;
  void getAge(int myAge) {
    age = myAge;
  }

  void displayAge() {
    print("agge  is $age");
  }
}
