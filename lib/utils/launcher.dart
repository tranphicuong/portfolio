import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import '../data/portfolio_data.dart';
//mo file cv pdf trong tab moi cua trinh duyet
Future<void> openCV(BuildContext context) async{
  if(!kIsWeb){
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Chức năng này chỉ khả dụng trên web'),
        behavior: SnackBarBehavior.floating,
      ),
    );
    return;
  }
  //mo file cv pdf trong tab moi cua trinh duyet
  await openLink(context, Uri.base.resolve(PortfolioData.cvFilePath).toString());
}
//mo lien ket trong tab moi cua trinh duyet
Future<void> openLink(BuildContext context, String url) async {
  final uri = Uri.tryParse(url);
  var success = false;

  if (uri != null) {
    try {
      success = await launchUrl(uri, mode: LaunchMode.externalApplication);
    } catch (_) {
      success = false;
    }
  }

  if (!success && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Không thể mở liên kết: $url'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
