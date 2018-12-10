import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './controller/gt_bloc.dart';
import './controller/gu_bloc.dart';

import './view/mc_event_list.dart';
import './view/gt_view.dart';
import './view/gu_view.dart';
import './view/gw_view.dart';

import './service/web_client.dart';
import 'package:built_collection/built_collection.dart';
import './model/mc_event.dart';

void main() async {
  // var wc = WebClient();
  // var mcs = await wc.fetchMcEvent();
  runApp(TPMApp());
}

class TPMApp extends StatelessWidget {
  // final BuiltList<McEvent> mcs;
  // TPMApp();
  @override
  Widget build(BuildContext context) {
    final GtBloc gtBloc = GtBloc();
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.brown,
        fontFamily: 'Kanit',
      ),
      title: 'TPM Plus App',
      home: BlocProvider(
        child: GtView(),
        bloc: gtBloc,
      ),
    );
  }
}
