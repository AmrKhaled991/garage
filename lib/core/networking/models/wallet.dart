import 'package:garage/core/networking/base/decodable.dart';

class Wallet extends Decodable<Wallet>{
  Wallet({
      this.walletAmount, 
      this.transactions,});

  Wallet.fromJson(dynamic json) {
    walletAmount = json['wallet_amount'];
    if (json['transactions'] != null) {
      transactions = [];
      json['transactions'].forEach((v) {
        transactions?.add(Transaction.fromJson(v));
      });
    }
  }
  num? walletAmount;
  List<Transaction>? transactions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['wallet_amount'] = walletAmount;
    if (transactions != null) {
      map['transactions'] = transactions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  Wallet decode(json) {
    return Wallet.fromJson(json);
  }

}

class Transaction {
  Transaction({
      this.id, 
      this.name, 
      this.amount, 
      this.type, 
      this.orderId, 
      this.date, 
      this.createdAt,});

  Transaction.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    amount = json['amount'];
    type = json['type'];
    orderId = json['order_id'];
    date = json['date'];
    createdAt = json['created_at'];
  }
  num? id;
  String? name;
  String? amount;
  String? type;
  num? orderId;
  String? date;
  String? createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['amount'] = amount;
    map['type'] = type;
    map['order_id'] = orderId;
    map['date'] = date;
    map['created_at'] = createdAt;
    return map;
  }

}