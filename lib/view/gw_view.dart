//EXAMPLE for fetch JSON from network

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:built_collection/built_collection.dart';

import '../model/mc_event.dart';

Future<BuiltList<McEvent>> fetchMcEvent() async {
  print('enter fetch mc event');
  // var resbody =
  //     "[{\"mcid\":1,\"fail\":\"motor break\",\"ts\":1543825211693},{\"mcid\":2,\"fail\":\"fail header\",\"ts\":1543825211692},{\"mcid\":3,\"fail\":\"unknown\",\"ts\":1543825211692}]";
  // var mcs = McEvent.listFromJson(resbody);
  // return mcs;

  final response = await http.get('http://198.10.10.71:3000/events');

  if (response.statusCode == 200) {
    print('got data');
    // If the call to the server was successful, parse the JSON
    return McEvent.listFromJson(response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load post');
  }
}

class GwView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GwView'),
      ),
      body: FutureBuilder(
        future: fetchMcEvent(),
        builder:
            (BuildContext context, AsyncSnapshot<BuiltList<McEvent>> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 0.7),
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      Image.network('http://198.10.10.71:3000/img'),
                      Text(snapshot.data[index].mcid.toString()),
                      Text(snapshot.data[index].fail),
                      Text(snapshot.data[index].ts.toString()),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data.length,
            );
            // return Text('FutureBuilder');
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
