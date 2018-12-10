import 'package:bloc/bloc.dart';

abstract class GtEvent {}

class EventGenString extends GtEvent {}

class GtBloc extends Bloc<GtEvent, int> {
  @override
  get initialState => 0;

  @override
  Stream<int> mapEventToState(int state, GtEvent event) async* {
    yield state + 1;
  }
}
