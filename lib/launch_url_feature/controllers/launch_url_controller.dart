import 'package:url_launcher/url_launcher.dart';

class LaunchUrl {
  void launchLink(String link) async {
    final url = Uri.parse(link);

    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      //print("cannot launch $link");
    }
  }

  void launchEmail(String mail) async {
    final Uri url = Uri(
      scheme: 'mailto',
      path: mail,
      queryParameters: {
        'subject': '',
        'body': ''
      },
    );
    launchUrl(url);
  }
}
