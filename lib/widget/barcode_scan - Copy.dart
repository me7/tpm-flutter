import 'package:flutter/material.dart';

Future<String> scanBarcode() async {
  await new Future.delayed(Duration(seconds: 2));
  print('enter scanbarcode');
  return '1D332145';
}

class CounterFormField extends FormField<int> {
  CounterFormField(
      {FormFieldSetter<int> onSaved,
      FormFieldValidator<int> validator,
      int initialValue = 0,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            autovalidate: autovalidate,
            builder: (FormFieldState<int> state) {
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      state.didChange(state.value - 1);
                    },
                  ),
                  Text(state.value.toString()),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      state.didChange(state.value + 1);
                    },
                  ),
                ],
              );
            });
}

class BarcodeScanner extends FormField<String> {
  // _BarcodeScannerState createState() => _BarcodeScannerState();

}

class _BarcodeScannerState extends State<BarcodeScanner> {
  String barcodeText = 'Press To Scan';
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text('Machine ID'),
        SizedBox(width: 16),
        RaisedButton.icon(
          icon: Icon(Icons.people),
          label: Text(barcodeText),
          onPressed: () async {
            String bc = await scanBarcode();
            setState(() {
              barcodeText = bc;
            });
          },
        ),
      ],
    );
  }
}
