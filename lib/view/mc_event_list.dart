import 'package:flutter/material.dart';
import '../service/web_client.dart';
import 'package:built_collection/built_collection.dart';
import '../model/mc_event.dart';

Future<String> futureString() async {
  await Future.delayed(Duration(seconds: 5));
  return 'Future String';
}

Future<String> mcEventList() async {
  var wc = WebClient();
  await Future.delayed(Duration(seconds: 2));
  //var mcs = await wc.fetchMcEvent();
  return 'MC Event List';
}

class McEventList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Mc Event List'),
        ),
        body: FutureBuilder(
          future: mcEventList(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              return Text(snapshot.data);
            } else {
              return CircularProgressIndicator();
            }
          },
        ));
  }
}
