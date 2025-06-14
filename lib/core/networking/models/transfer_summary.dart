import 'package:garage/core/networking/base/decodable.dart';

class TransferSummary extends Decodable<TransferSummary> {
  TransferSummary({
    this.sentAmount,
    this.transferFees,
    this.totalPaid,
    this.sellingPrice,
    this.receivedPrice,
    this.sendCurrency,
    this.receivedCurrency,
  });

  TransferSummary.fromJson(dynamic json) {
    sentAmount = json['sent_amount'];
    transferFees = json['transfer_fees'];
    totalPaid = json['total_paid'];
    sellingPrice = json['selling_price'];
    receivedPrice = json['received_price'];
    sendCurrency = json['sendCurrency'];
    receivedCurrency = json['receivedCurrency'];
  }
  dynamic sentAmount;
  dynamic transferFees;
  dynamic totalPaid;
  dynamic sellingPrice;
  dynamic receivedPrice;
  String? sendCurrency;
  String? receivedCurrency;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sent_amount'] = sentAmount;
    map['transfer_fees'] = transferFees;
    map['total_paid'] = totalPaid;
    map['selling_price'] = sellingPrice;
    map['received_price'] = receivedPrice;
    map['sendCurrency'] = sendCurrency;
    map['receivedCurrency'] = receivedCurrency;
    return map;
  }

  @override
  TransferSummary decode(json) {
    return TransferSummary.fromJson(json);
  }
}
