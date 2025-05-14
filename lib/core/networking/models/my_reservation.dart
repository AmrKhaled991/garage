import 'package:garage/core/networking/base/decodable.dart';
import 'package:garage/core/networking/models/clinic.dart';
import 'package:garage/core/networking/models/doctor.dart';
import 'package:garage/core/networking/models/medical_condition.dart';


class MyReservation extends Decodable<MyReservation>{
  MyReservation({
      this.id, 
      this.price, 
      this.date, 
      this.time, 
      this.serviceName, 
      this.place, 
      this.doctor,
      this.familyMember, 
      this.isPast, 
      this.isRateBranch, 
      this.isRatePlace, });

  MyReservation.fromJson(dynamic json) {
    id = json['id'];
    price = json['price'];
    date = json['date'];
    time = json['time'];
    personsCount = json['persons_count'];
    serviceName = json['service_name'];
    status = json['status'];
    statusKey = json['status_key'];
    place = json['place'] != null ? Clinic.fromJson(json['place']) : null;
    doctor = json['doctor'] != null ? Doctor.fromJson(json['doctor']) : null;
    familyMember = json['family_member'];
    isPast = json['is_past'];
    isRateBranch = json['is_rate_branch'];
    isRatePlace = json['is_rate_place'];
    isPaid = json['is_paid'];
    finalPrice = json['final_price'];
    discountAmount = json['discount_amount'];
    medicalConditionsTotal = json['medical_conditions_total'];
    if (json['medical_conditions'] != null) {
      medicalConditions = [];
      json['medical_conditions'].forEach((v) {
        medicalConditions?.add(MedicalCondition.fromJson(v));
      });
    }
  }
  num? id;
  num? price;
  String? date;
  String? time;
  num? personsCount;
  String? serviceName;
  String? status;
  String? statusKey;
  Clinic? place;
  Doctor? doctor;
  List<MedicalCondition>? medicalConditions;
  dynamic familyMember;
  bool? isPast;
  bool? isRateBranch;
  bool? isRatePlace;
  bool? isPaid;
  dynamic finalPrice;
  dynamic discountAmount;
  dynamic medicalConditionsTotal;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['price'] = price;
    map['date'] = date;
    map['time'] = time;
    map['persons_count'] = personsCount;
    map['service_name'] = serviceName;
    map['status'] = status;
    map['status_key'] = statusKey;
    if (place != null) {
      map['place'] = place?.toJson();
    }
    if (doctor != null) {
      map['doctor'] = doctor?.toJson();
    }
    map['family_member'] = familyMember;
    map['is_past'] = isPast;
    map['is_rate_branch'] = isRateBranch;
    map['is_rate_place'] = isRatePlace;
    map['is_paid'] = isPaid;
    map['final_price'] = finalPrice;
    map['discount_amount'] = discountAmount;
    map['medical_conditions_total'] = medicalConditionsTotal;
    if (medicalConditions != null) {
      map['medical_conditions'] = medicalConditions?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  @override
  MyReservation decode(json) {
    return MyReservation.fromJson(json);
  }

}

class Branch {
  Branch({
      this.id, 
      this.image, 
      this.name, 
      this.notes, 
      this.showPrice, 
      this.services, 
      this.hours, 
      this.rate,});

  Branch.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    notes = json['notes'];
    showPrice = json['show_price'];
    if (json['services'] != null) {
      services = [];
      json['services'].forEach((v) {
        services?.add(Services.fromJson(v));
      });
    }
    if (json['hours'] != null) {
      hours = [];
      json['hours'].forEach((v) {
        hours?.add(Hours.fromJson(v));
      });
    }
    rate = json['rate'];
  }
  num? id;
  String? image;
  String? name;
  String? notes;
  bool? showPrice;
  List<Services>? services;
  List<Hours>? hours;
  num? rate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['name'] = name;
    map['notes'] = notes;
    map['show_price'] = showPrice;
    if (services != null) {
      map['services'] = services?.map((v) => v.toJson()).toList();
    }
    if (hours != null) {
      map['hours'] = hours?.map((v) => v.toJson()).toList();
    }
    map['rate'] = rate;
    return map;
  }

}

class Hours {
  Hours({
      this.day, 
      this.startTime, 
      this.endTime,});

  Hours.fromJson(dynamic json) {
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }
  String? day;
  String? startTime;
  String? endTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = day;
    map['start_time'] = startTime;
    map['end_time'] = endTime;
    return map;
  }

}

class Services {
  Services({
      this.id, 
      this.name, 
      this.price,});

  Services.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
  }
  num? id;
  String? name;
  num? price;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['price'] = price;
    return map;
  }


}