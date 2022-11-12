import 'package:url_launcher/url_launcher.dart';

class FeedUtils {
  static final FeedUtils _feedUtils = FeedUtils._privateConstructor();

  factory FeedUtils() => _feedUtils;

  FeedUtils._privateConstructor();

  Future<void> goToUrl({required String url}) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $uri';
    }
  }
}