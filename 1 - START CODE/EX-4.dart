import 'dart:ffi';

enum DeliveryType { PICKUP, DELIVERY }

enum PaymentMethod { CASH, CREDIT_CARD, WALLET }

class Address {
  final String _street;
  final String _city;
  final String _zipcode;

  Address(this._street, this._city, this._zipcode);
}

class Customer {
  String _name;
  String _phoneNumber;
  String _email;
  Address _address;
  final List<Order> _orders = [];

  Customer(this._name, this._phoneNumber, this._email, this._address);

  void createOrder(Order order) {
    _orders.add(order);
    print('You successfuly created an order!\n');
  }

  void cancelOrder(int id) {
    _orders.removeWhere((e) => e.id == id);
    print('Order #$id has been removed!\n');
  }
}

class Order {
  static int nextID = 0;
  final int _id;
  final String date;
  final DeliveryType _deliveryType;
  final Address _address;
  Payment? _payment;
  final List<OrderItem> _items = [];

  Order(this.date, this._deliveryType, this._address) : this._id = nextID {
    nextID++;
  }

  int get id => _id;

  void addItem(OrderItem item) {
    _items.add(item);
    print('Added ${item.productName} (x${item.quantity})');
  }

  double get total {
    return _items.fold(0, (sum, item) => sum + item.subTotal);
  }

  void checkout(Payment payment) {
    _payment = payment;
    if (payment.amount >= total) {
      payment.processPayment();
      print('Order #$_id has been checked out successfully!');
    } else {
      print(
        'Payment failed: not enough funds. Total: \$${total}, Paid: \$${payment.amount}',
      );
    }
  }

  void displayOrderDetail() {
    print('--- Order #$_id ---');
    print('Date: $date');
    print('Delivery Type: $_deliveryType');
    print('Address: ${_address._street}, ${_address._city}, ${_address._zipcode}');
    print('Items:');
    for (var item in _items) {
      print('- ${item.productName} x${item.quantity} = \$${item.subTotal}');
    }
    print('Total Amount: \$${total}');
    if (_payment != null) {
      print('Payment Method: ${_payment!.method.name}, Paid: ${_payment!.isPaid}');
    }
    print('-------------------\n');
  }
}

class OrderItem {
  Product _product;
  int _quantity;

  OrderItem(this._product, this._quantity);

  double get subTotal => this._product._price * _quantity;
  String get productName => this._product.name;
  int get quantity => this._quantity;
}

class Product {
  final String _name;
  double _price;

  Product(this._name, this._price);

  double get price => _price;
  String get name => this._name;
}

class Payment {
  final PaymentMethod _method;
  final double _amount;
  bool _isPaid = false;

  Payment(this._method, this._amount);

  PaymentMethod get method => _method;
  double get amount => _amount;
  bool get isPaid => _isPaid;

  void processPayment() {
    _isPaid = true;
    print('Payment of \$$_amount via ${_method.name} processed successfully!');
  }
}

void main() {
  Product pro1 = Product('Ramen', 20);
  Product pro2 = Product('Coke', 5);

  Address add1 = Address('1 st', 'Phnom Penh', '897770');
  Customer cus1 = Customer('Ben', '097876633', 'bczin@gmail.com', add1);

  Order order1 = Order('2025-10-15', DeliveryType.DELIVERY, add1);
  order1.addItem(OrderItem(pro1, 2));
  order1.addItem(OrderItem(pro2, 3));

  cus1.createOrder(order1);
  Payment payment1 = Payment(PaymentMethod.CREDIT_CARD, 60);
  order1.checkout(payment1);

  order1.displayOrderDetail();
  cus1.cancelOrder(0);
}
