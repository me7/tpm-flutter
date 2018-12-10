library serializers;

import 'package:built_collection/built_collection.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:built_value/serializer.dart';
import './mc_event.dart';

part 'serializers.g.dart';

/// Collection of generated serializers for the built_value.
@SerializersFor(const [
  McEvent,
])
final Serializers serializers = (_$serializers.toBuilder()
      ..addBuilderFactory(FullType(BuiltList, [FullType(McEvent)]),
          () => new ListBuilder<McEvent>())
      ..addPlugin(StandardJsonPlugin()))
    .build();
