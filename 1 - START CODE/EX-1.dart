enum Skill {
  FLUTTER(5000),
  DART(3000),
  OTHER(1000);

  final int bonus;
  const Skill(this.bonus);
}

class Address {
  final String _street;
  final String _city;
  final String _zipCode;

  String get street => _street;
  String get city => _city;
  String get zipCode => _zipCode;

  Address(this._street, this._city, this._zipCode);
}

class Employee {
  final _name;
  final _baseSalary;
  //New attributes
  final List<Skill> _skill;
  Address _address;
  int _yearOfExperience;

  Employee(
    this._name,
    this._baseSalary,
    this._yearOfExperience,
    this._skill,
    this._address,
  );
  Employee.mobileDeveloper(
    this._name,
    this._baseSalary,
    this._yearOfExperience,
    this._address,
  ) : this._skill = [Skill.DART, Skill.FLUTTER];

  Employee.otherDeveloper(
    this._name,
    this._baseSalary,
    this._yearOfExperience,
    this._address,
  ) : this._skill = [Skill.OTHER];

  int computeSalary() {
    return _baseSalary +
        (_yearOfExperience * 2000) +
        _skill.fold(0, (sum, skill) => sum + skill.bonus);
  }

  String get name => _name;
  String get baseSalary => _baseSalary;
  int get yearOfExperience => _yearOfExperience;
  List get skill => _skill;
  Address get address => _address;

  void printDetails() {
    print('Employee: $_name\n');
    print('Base Salary: \$${_baseSalary}\n');
    print('Years of Experience: $_yearOfExperience\n');
    print('Skill: ${_skill.map((s) => s.name).join(', ')}\n');
    print(
      'Address: ${_address.street}, ${_address.city}, ${_address.zipCode}\n',
    );
    print('Total Salary: ${computeSalary()}\n');
  }
}

void main() {
  var addr1 = Address('60m', 'Phnom Penh', '12999');
  var emp1 = Employee('Sokea', 40000, 4, [Skill.DART, Skill.OTHER], addr1);
  emp1.printDetails();

  var emp2 = Employee('Ronan', 45000, 2, [Skill.FLUTTER], addr1);
  emp2.printDetails();

  var emp3 = Employee.mobileDeveloper("Bn", 120000, 1, addr1);
  emp3.printDetails();

  var emp4 = Employee.otherDeveloper("Ben", 2000000, 7, addr1);
  emp4.printDetails();
}
