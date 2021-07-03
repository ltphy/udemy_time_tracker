class Person {
  final String? name;
  final int? age;
  final double? height;

  Person.age({required this.name})
      : age = 1,
        height = 2;

  Person({
    this.name,
    this.age,
    this.height,
  });
}

abstract class Student {
  void takeExam() {
    print('hello tak exame');
  }

  void goToSchool() {
    print('hello schorool');
  }
}

class Employee implements Student {
  double taxCode;
  double? salary;

  Employee({required this.taxCode, this.salary, name});

  set taxCodeV(double value) => taxCode = value;

  double get taxCodeC => taxCode;

  @override
  void goToSchool() {
    // TODO: implement goToSchool
  }

  @override
  void takeExam() {
    // TODO: implement takeExam
  }
}
