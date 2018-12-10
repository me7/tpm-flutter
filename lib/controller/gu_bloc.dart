import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';

import '../model/mc_event.dart';
import '../service/web_client.dart';

abstract class GuEvent {}

class EventGetMcEvent extends GuEvent {}

class EventGetMachines extends GuEvent {}

class GuBloc extends Bloc<GuEvent, BuiltList<McEvent>> {
  @override
  get initialState => null;

  @override
  Stream<BuiltList<McEvent>> mapEventToState(
      BuiltList<McEvent> state, GuEvent event) async* {
    if (event is EventGetMachines) {
      print('get machine event');
    }

    if (event is EventGetMcEvent) {
      print('before gubloc');
      var wc = WebClient();
      var mcs = await wc.fetchMcEvent();
      print(mcs);
      print('after gubloc');
      yield mcs;
    }
  }
}
