import 'package:flutter/material.dart';

import 'app/my_app.dart';
import 'data/network/local/shared_pref.dart';
import 'data/network/remote/dio.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  runApp(MyApp());
}
