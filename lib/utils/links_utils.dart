import 'package:garage/utils/utlis.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkHelper {
  static Future<void> openWhatsApp({String? phoneNumber, String? link}) async {
    String? whatsappUrl =
        link ?? (phoneNumber != null ? "https://wa.me/$phoneNumber" : null);

    if (whatsappUrl == null || whatsappUrl.isEmpty) {
      _showErrorMessage('invalid_whatsapp_url'.tr);
      throw "A valid phone number or link must be provided to open WhatsApp.";
    }

    await _launchUrl(whatsappUrl);
  }

  static Future<void> openLink(String url) async {
    if (url.isEmpty) {
      _showErrorMessage('invalid_url'.tr);
      throw "Invalid URL provided.";
    }

    await _launchUrl(url);
  }

  static Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showErrorMessage('cannot_open_link'.tr);

      throw "Could not launch the provided link.";
    }
  }

  static void _showErrorMessage(String message) {
    Utils.showSnackBar(message);
  }
}
