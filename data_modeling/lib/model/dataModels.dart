import 'package:flutter/material.dart';

List<Student> defaultStudents = [
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
  Student("1030121", [], "1030121", "1030121", "1030121", "1030121",
      "1030121  ", "1030121"),
];

class Person {
  String name;
  String phoneNumber;
  String address;
  String bloodGroup;
  String emergencyNumber;
  String department;
  Person({
    @required this.name,
    @required this.phoneNumber,
    @required this.address,
    @required this.bloodGroup,
    @required this.emergencyNumber,
    @required this.department,
  });
}

class Student extends Person {
  String id;
  List<String> courseList;

  Student(
    String id,
    List<String> courseList,
    String name,
    String phoneNumber,
    String address,
    String bloodGroup,
    String emergencyNumber,
    String department,
  ) : super(
          name: name,
          phoneNumber: phoneNumber,
          address: address,
          bloodGroup: bloodGroup,
          emergencyNumber: emergencyNumber,
          department: department,
        ) {
    this.id = id;
    this.courseList = courseList;
  }
}

class Admin extends Person {
  String type;
  String accessPower;
}

class Faculty extends Person {
  String initial;
  List<String> takingCourse;
  String roomNumber;
}

class Staff extends Person {
  String tableAddress;
}

// class Animal {
//   String breed;
//   Color color;
//   Animal({
//     @required String breed,
//     @required Color color,
//   }) {
//     this.breed = breed;
//     this.color = color;
//     print("Animal Class constructor");
//   }
// }

// class Dog extends Animal {
//   String walk;
//   Dog({@required String walk, @required String breed, @required Color color})
//       : super(
//           breed: breed,
//           color: color,
//         ) {
//     this.walk = walk;
//     print("Dog Constructor");
//   }

//   void bark() {
//     print("Dog is barking");
//   }
// }

// class Cat extends Animal {
//   String food;

//   Cat({
//     @required String food,
//   }) {
//     this.food = food;
//     print("Cat Constructor");
//   }

//   void meow() {
//     print("cat is meowing");
//   }
// }
