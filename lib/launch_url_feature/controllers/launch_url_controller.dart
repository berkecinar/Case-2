import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  void launchEmail(String mail) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: mail,
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      //print('cannot launc $mail');
    }
  }
}
