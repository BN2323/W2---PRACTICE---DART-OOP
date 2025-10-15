class BankAccount {
  // TODO
  final String _name;
  final int _accountID;
  double _balance = 0;
 
  BankAccount(this._accountID, this._name);

  int get accountID => _accountID;

  double get balance => _balance;

  void withdraw(double amount) {
    if (amount > 0) {
      if (_balance >= 0 && _balance >= amount) {
        _balance -= amount;
        print('You successfuly withdraw your money!');
      } else {
        throw Exception("Invalid withdrawal! You don't have enough amount!");
      }
    } else {
      print('Invalid amount!');
    }
  }

  void credit(double amount) {
    if (amount > 0) {
      _balance += amount;
      print('You successfuly deposit your money!');
    } else {
      throw Exception('Invalid amount!');
    }
  }
}

class Bank {
  // TODO
  final String _name;
  List<BankAccount> _bankAccounts = [];

  Bank({required String name}) : _name = name;

  BankAccount createAccount(int accountID, String accounOwner) {
    if (_bankAccounts.any((e) => e.accountID == accountID)) {
      throw Exception('Id is taken! Choose a unique one!');
    }
    print('You successfuly created an account ${accounOwner}!');

    BankAccount account = BankAccount(accountID, accounOwner);
    _bankAccounts.add(account);
    return account;
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}