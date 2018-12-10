library mc_event;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import './serializers.dart';

part 'mc_event.g.dart';

abstract class McEvent implements Built<McEvent, McEventBuilder> {
  McEvent._();

  factory McEvent([updates(McEventBuilder b)]) = _$McEvent;

  @BuiltValueField(wireName: 'mcid')
  int get mcid;
  @BuiltValueField(wireName: 'fail')
  String get fail;
  @BuiltValueField(wireName: 'ts')
  int get ts;
  String toJson() {
    return json.encode(serializers.serializeWith(McEvent.serializer, this));
  }

  static McEvent fromJson(String jsonString) {
    return serializers.deserializeWith(
        McEvent.serializer, json.decode(jsonString));
  }

  static BuiltList<McEvent> listFromJson(String jsonString) {
    return serializers.deserialize(json.decode(jsonString),
        specifiedType: FullType(BuiltList, [FullType(McEvent)]));
  }

  static Serializer<McEvent> get serializer => _$mcEventSerializer;
}
