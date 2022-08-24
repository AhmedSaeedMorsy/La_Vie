import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:la_vie/presentation/qr_code/view_model/cubit.dart';
import 'package:la_vie/presentation/qr_code/view_model/states.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrCodeScreen extends StatelessWidget {
  QrCodeScreen({Key? key}) : super(key: key);
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QrCodeCubit(),
      child: BlocBuilder<QrCodeCubit,QrCodeStates>(
        builder: (context, state) {
          return Scaffold(
            body: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: QrCodeCubit.get(context).onQRViewCreated,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Center(
                    child: (QrCodeCubit.get(context).result != null)
                        ? Text(
                            ' Data: ${QrCodeCubit.get(context).result!.code}')
                        : Text('Scan a code'),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
