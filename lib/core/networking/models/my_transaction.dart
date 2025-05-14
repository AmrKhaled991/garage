import 'package:garage/core/networking/base/decodable.dart';

class MyTransaction extends Decodable<MyTransaction>{
  MyTransaction({
      this.id, 
      this.serial, 
      this.totalPaidAmount, 
      this.currencyCode, 
      this.senderName, 
      this.receiverName, 
      this.paymentDate, 
      this.transferFees, 
      this.transferAmounts,});

  MyTransaction.fromJson(dynamic json) {
    id = json['id'];
    serial = json['serial'];
    totalPaidAmount = json['total_paid_amount'];
    currencyCode = json['currency_code'];
    senderName = json['sender_name'];
    receiverName = json['receiver_name'];
    paymentDate = json['payment_date'];
    transferFees = json['transfer_fees'];
    status = json['status'];
    if (json['transfer_amounts'] != null) {
      transferAmounts = [];
      json['transfer_amounts'].forEach((v) {
        transferAmounts?.add(TransferAmounts.fromJson(v));
      });
    }
  }
  num? id;
  String? serial;
  String? totalPaidAmount;
  String? currencyCode;
  String? senderName;
  String? receiverName;
  String? paymentDate;
  String? transferFees;
  String? status; //['pending', 'fail', 'success'];
  List<TransferAmounts>? transferAmounts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['serial'] = serial;
    map['total_paid_amount'] = totalPaidAmount;
    map['currency_code'] = currencyCode;
    map['sender_name'] = senderName;
    map['receiver_name'] = receiverName;
    map['payment_date'] = paymentDate;
    map['transfer_fees'] = transferFees;
    map['status'] = status;
    if (transferAmounts != null) {
      map['transfer_amounts'] = transferAmounts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  MyTransaction decode(json) {
    return MyTransaction.fromJson(json);
  }

}

class TransferAmounts {
  TransferAmounts({
      this.id, 
      this.transferTransactionId, 
      this.sentAmount, 
      this.sentCurrencyType, 
      this.receivedAmount, 
      this.receivedCurrencyTypeId, 
      this.sellingPrice, 
      this.buyingPrice,});

  TransferAmounts.fromJson(dynamic json) {
    id = json['id'];
    transferTransactionId = json['transfer_transaction_id'];
    sentAmount = json['sent_amount'];
    sentCurrencyType = json['sent_currency_type'];
    receivedAmount = json['received_amount'];
    receivedCurrencyTypeId = json['received_currency_type_id'];
    sellingPrice = json['selling_price'];
    buyingPrice = json['buying_price'];
  }
  num? id;
  num? transferTransactionId;
  String? sentAmount;
  String? sentCurrencyType;
  String? receivedAmount;
  String? receivedCurrencyTypeId;
  String? sellingPrice;
  String? buyingPrice;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['transfer_transaction_id'] = transferTransactionId;
    map['sent_amount'] = sentAmount;
    map['sent_currency_type'] = sentCurrencyType;
    map['received_amount'] = receivedAmount;
    map['received_currency_type_id'] = receivedCurrencyTypeId;
    map['selling_price'] = sellingPrice;
    map['buying_price'] = buyingPrice;
    return map;
  }

}