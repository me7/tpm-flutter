import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

Future scanBarcode() async {
  try {
    String barcode = await BarcodeScanner.scan();
    return barcode;
  } on PlatformException catch (e) {
    if (e.code == BarcodeScanner.CameraAccessDenied) {
      return 'Error: User not allow app to use camera';
    } else {
      return 'unknown error $e';
    }
  } on FormatException {
    return 'Error: User cancel scanning';
  } catch (e) {
    return 'Error: unknown error $e';
  }
}

class BarcodeScannerWidget extends FormField<String> {
  final String title;
  BarcodeScannerWidget(
      {this.title,
      FormFieldSetter<String> onSaved,
      FormFieldValidator<String> validator,
      String initialValue = '',
      bool autovalidate = false})
      : super(
            initialValue: initialValue,
            onSaved: onSaved,
            validator: validator,
            autovalidate: autovalidate,
            builder: (FormFieldState<String> state) {
              return ListTile(
                title: Text(title),
                trailing: IconButton(
                  icon: Icon(Icons.find_in_page),
                  onPressed: () async {
                    String code = await scanBarcode();
                    state.didChange(code);
                  },
                ),
                subtitle: Text(state.value),
              );
            });
}
