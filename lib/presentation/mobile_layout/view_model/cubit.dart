import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:la_vie/presentation/home_screen/view/home_screen.dart';
import 'package:la_vie/presentation/mobile_layout/view_model/states.dart';
import 'package:la_vie/presentation/notification/view/notification.dart';
import 'package:la_vie/presentation/qr_code/view/qr_code.dart';

import '../../profile/view/profile.dart';
import '../../shop/view/shop.dart';

class MobileCubit extends Cubit<MobileLayOutStates> {
  MobileCubit() : super(MobileLayOutInitState());

  static MobileCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(ChangeBottonNavigateIndex());
  }

  List<Widget> bottomNavItem = const [
    HomeScreen(),
    ShopScreen(),
    QrCodeScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];
}
