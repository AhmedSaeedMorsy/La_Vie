import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/qr_code/view_model/states.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeCubit extends Cubit<QrCodeStates> {
  QrCodeCubit() : super(QrCodeInitState());
  static QrCodeCubit get(context) => BlocProvider.of(context);
  Barcode? result;
  QRViewController? controller;
  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      emit(QrCodeSucccesState());
    });
  }
}
