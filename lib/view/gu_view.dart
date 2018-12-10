import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../controller/gu_bloc.dart';

class GuView extends StatelessWidget {
  final gub = GuBloc();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: gub,
      builder: (BuildContext context, state) {
        return Column(
          children: <Widget>[
            Text('GuView'),
            RaisedButton(
              onPressed: () {
                gub.dispatch(EventGetMcEvent());
              },
              child: Text('Fetch Movie'),
            )
          ],
        );
      },
    );
  }
}
