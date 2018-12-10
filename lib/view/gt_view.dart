// Input Form
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/gt_bloc.dart';
import '../widget/barcode_scan.dart';

class GtView extends StatefulWidget {
  // final GtBloc gtBloc;
  @override
  GtViewState createState() {
    return new GtViewState();
  }
}

class GtViewState extends State<GtView> {
  final _formKey = GlobalKey<FormState>();
  bool _urgent = false;

  void onSubmit() {
    if (_formKey.currentState.validate()) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Form is validate'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // final gtb = BlocProvider.of<GtBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('GT View Screen X'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              BarcodeScannerWidget(
                  title: 'Machine ID', validator: validateBarcode),
              BarcodeScannerWidget(
                  title: 'Failure ID', validator: validateBarcode),
              BarcodeScannerWidget(
                  title: 'Operator ID', validator: validateBarcode),
              SwitchListTile(
                title: Text('Urgent'),
                value: _urgent,
                onChanged: (bool value) {
                  setState(() {
                    _urgent = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Note - อื่นๆ',
                  hintText: 'ระบุอาการเสียเพิ่มเติม',
                  icon: Icon(Icons.note),
                ),
                validator: validateNote,
              ),
              RaisedButton(
                child: Text('Submit Data'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String validateNote(String value) {
  if (value.isEmpty) {
    return 'Cannot be blank';
  }
  return null;
}

String validateBarcode(String value) {
  if (value == '') {
    return 'Barcode is blank';
  } else if (value.startsWith('Error: ')) {
    return 'error during scan barcode';
  }
  return null;
}
