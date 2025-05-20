import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:garage/utils/utlis.dart';
import 'my_clickable.dart';
import 'my_image.dart';

class SocialButton extends StatelessWidget {
  final SocialButtonType type;
  final String? link;

  const SocialButton({Key? key, required this.type, this.link})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: link?.isNotEmpty == true && link != "#",
      child: Container(
        width: 40.r,
        height: 40.r,
        margin: EdgeInsetsDirectional.only(
          start: 5.w,
          end: 5.w,
          bottom: 5.h,
          top: 5.h,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: _getBackgroundGradient(),
          color: _getBackgroundColor(),
        ),
        child: MyClickable(
          cornerRadius: 20.r,
          child: MyImage(
            image: _getImagePath(),
            width: 40.r,
            height: 40.r,
            padding: _getImagePadding(),
          ),
          onPressed: () => Utils.customLaunch(_wrapLink()),
        ),
      ),
    );
  }

  Gradient? _getBackgroundGradient() {
    switch (type) {
      case SocialButtonType.CALL:
        return const LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [Color(0xFF33BEF0), Color(0xFF0A85D9)],
        );
      case SocialButtonType.FACEBOOK:
        return const LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            Color(0xFF4676ED),
            Color(0xFF436DE4),
            Color(0xFF3B54CD),
            Color(0xFF2F2DA8),
            Color(0xFF2B1E99),
          ],
        );
      case SocialButtonType.WHATSAPP:
        return const LinearGradient(
          begin: FractionalOffset.topRight,
          end: FractionalOffset.bottomLeft,
          colors: [Color(0xFF60FC7C), Color(0xFF4AB161)],
        );
      case SocialButtonType.INSTAGRAM:
        return const LinearGradient(
          begin: FractionalOffset.bottomLeft,
          end: FractionalOffset.topRight,
          colors: [
            Color(0xFFFBE18A),
            Color(0xFFFCBB45),
            Color(0xFFF75274),
            Color(0xFFD53692),
            Color(0xFF8F39CE),
            Color(0xFF5B4FE9),
          ],
        );
      case SocialButtonType.TWITTER:
        return const LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [Color(0xFF2aa4f4), Color(0xFF007ad9)],
        );
      case SocialButtonType.YOUTUBE:
        return const LinearGradient(
          begin: FractionalOffset.topLeft,
          end: FractionalOffset.bottomRight,
          colors: [
            Color(0xFFf32536),
            Color(0xFFea2434),
            Color(0xFFdc2231),
            Color(0xFFc8202c),
            Color(0xFFae1e25),
            Color(0xFF8f1a1d),
          ],
        );
      case SocialButtonType.SNAPCHAT:
        return const LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [Color(0xFFfede00), Color(0xFFffd000)],
        );
      case SocialButtonType.TIKTOK:
        return const LinearGradient(
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          colors: [Color(0xFF4c4c4c), Color(0xFF343434)],
        );
      default:
        return null;
    }
  }

  Color? _getBackgroundColor() {
    switch (type) {
      case SocialButtonType.LINKEDIN:
        return const Color(0xFF0078d4);
      default:
        return null;
    }
  }

  String? _getImagePath() {
    switch (type) {
      case SocialButtonType.CALL:
        return "assets/images/ic_call.svg";
      case SocialButtonType.FACEBOOK:
        return "assets/images/ic_facebook.svg";
      case SocialButtonType.WHATSAPP:
        return "assets/images/ic_whatsapp.svg";
      case SocialButtonType.INSTAGRAM:
        return "assets/images/ic_instagram.svg";
      case SocialButtonType.TWITTER:
        return "assets/images/ic_twitter.svg";
      case SocialButtonType.LINKEDIN:
        return "assets/images/ic_linkedin.svg";
      case SocialButtonType.YOUTUBE:
        return "assets/images/youtube.png";
      case SocialButtonType.SNAPCHAT:
        return "assets/images/ic_snapchat.svg";
      case SocialButtonType.TIKTOK:
        return "assets/images/ic_tiktok.svg";
      default:
        return null;
    }
  }

  EdgeInsetsGeometry? _getImagePadding() {
    switch (type) {
      case SocialButtonType.CALL:
        return EdgeInsets.all(10.r);
      case SocialButtonType.WHATSAPP:
        return EdgeInsets.all(7.5.r);
      default:
        return null;
    }
  }

  String? _wrapLink() {
    switch (type) {
      case SocialButtonType.CALL:
        return "tel://$link";
      case SocialButtonType.WHATSAPP:
        return "https://api.whatsapp.com/send?phone=$link";
      default:
        return link;
    }
  }
}

enum SocialButtonType {
  CALL,
  FACEBOOK,
  WHATSAPP,
  INSTAGRAM,
  TWITTER,
  LINKEDIN,
  YOUTUBE,
  SNAPCHAT,
  TIKTOK,
}
