import 'dart:io';

import '../mobile_layout/view/mobile_layout.dart';
import '../web_layout/web_layout.dart';

getPlatform() {
  if (Platform.isAndroid || Platform.isIOS) {
    return MobileLayoutScreen;
  } else {
    return WebLayoutScreen;
  }
}
