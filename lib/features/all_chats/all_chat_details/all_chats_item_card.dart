import 'package:flutter/material.dart';
import 'package:garage/core/networking/models/chat_rooms/room.dart';
import 'package:garage/core/ui/my_image.dart';
import 'package:garage/theme/styles.dart';

class AllChatsItemCard extends StatelessWidget {
  final Room? room;
  const AllChatsItemCard({super.key, this.room});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: MyshapesStyle.PrimaryDecoration,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.zero,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: MyImage(
                    image:
                        room?.members?.first.image ??
                        "assets/images/bar_bg.png",
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            room?.members?.first.name ??
                                "شركة جراج أونلاين للصيانه",

                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Zain',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const CircleAvatar(
                            backgroundColor: Colors.red,
                            radius: 10,
                            child: Text(
                              "1",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Zain',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        room?.lastMessageBody ??
                            "نموذج افتراضي يوضع في التصاميم لتعرض على العميل ليتصور طريقه وضع النصوص.",
                        style: const TextStyle(
                          color: Color(0xFFCCCAC7),
                          fontSize: 12,
                          fontFamily: 'Zain',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        room?.lastMessageCreatedAt ?? '2 x 50 د.ك',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'Almarai',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
