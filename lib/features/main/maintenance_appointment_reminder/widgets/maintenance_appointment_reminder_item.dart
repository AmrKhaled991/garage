import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/reminder/reminder.dart';
import 'package:garage/theme/styles.dart';
import 'package:get/get.dart';

class MaintenanceAppointmentReminderItem extends StatelessWidget {
  final Reminder item;
  const MaintenanceAppointmentReminderItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: MyshapesStyle.PrimaryDecoration,
      child: Column(
        spacing: 4,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.title ?? "موعد تغيير زيت للسيارة ",
            style: const TextStyle(
              color: Color(0xFFF7F8F9),
              fontSize: 20,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            item.description ??
                "وريم إيبسوم هو نص مؤقت يستخدم في التصميم والنشر لإظهار شكل الوثيقة أو الخط دون الاعتماد على محتوى معنوي. قد يستخدم لوريم إيبسوم كنص بديل قبل وضع النص",

            style: const TextStyle(
              color: Color(0xFFCCCAC7),
              fontSize: 14,
              fontFamily: 'Zain',
              fontWeight: FontWeight.w400,
              height: 1.50,
            ),
          ),

          Container(
            padding: const EdgeInsets.all(8),
            width: double.infinity,

            decoration: MyshapesStyle.lightGrayDecoration,
            child: Text(
              "${"تاريخ الطلب:".tr} ${item.date.toString().substring(0, 10)}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontFamily: 'Zain',
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
