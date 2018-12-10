// GENERATED CODE - DO NOT MODIFY BY HAND

part of mc_event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_catches_without_on_clauses
// ignore_for_file: avoid_returning_this
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first
// ignore_for_file: unnecessary_const
// ignore_for_file: unnecessary_new
// ignore_for_file: test_types_in_equals

Serializer<McEvent> _$mcEventSerializer = new _$McEventSerializer();

class _$McEventSerializer implements StructuredSerializer<McEvent> {
  @override
  final Iterable<Type> types = const [McEvent, _$McEvent];
  @override
  final String wireName = 'McEvent';

  @override
  Iterable serialize(Serializers serializers, McEvent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'mcid',
      serializers.serialize(object.mcid, specifiedType: const FullType(int)),
      'fail',
      serializers.serialize(object.fail, specifiedType: const FullType(String)),
      'ts',
      serializers.serialize(object.ts, specifiedType: const FullType(int)),
    ];

    return result;
  }

  @override
  McEvent deserialize(Serializers serializers, Iterable serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new McEventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'mcid':
          result.mcid = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'fail':
          result.fail = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'ts':
          result.ts = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
      }
    }

    return result.build();
  }
}

class _$McEvent extends McEvent {
  @override
  final int mcid;
  @override
  final String fail;
  @override
  final int ts;

  factory _$McEvent([void updates(McEventBuilder b)]) =>
      (new McEventBuilder()..update(updates)).build();

  _$McEvent._({this.mcid, this.fail, this.ts}) : super._() {
    if (mcid == null) {
      throw new BuiltValueNullFieldError('McEvent', 'mcid');
    }
    if (fail == null) {
      throw new BuiltValueNullFieldError('McEvent', 'fail');
    }
    if (ts == null) {
      throw new BuiltValueNullFieldError('McEvent', 'ts');
    }
  }

  @override
  McEvent rebuild(void updates(McEventBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  McEventBuilder toBuilder() => new McEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is McEvent &&
        mcid == other.mcid &&
        fail == other.fail &&
        ts == other.ts;
  }

  @override
  int get hashCode {
    return $jf($jc($jc($jc(0, mcid.hashCode), fail.hashCode), ts.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('McEvent')
          ..add('mcid', mcid)
          ..add('fail', fail)
          ..add('ts', ts))
        .toString();
  }
}

class McEventBuilder implements Builder<McEvent, McEventBuilder> {
  _$McEvent _$v;

  int _mcid;
  int get mcid => _$this._mcid;
  set mcid(int mcid) => _$this._mcid = mcid;

  String _fail;
  String get fail => _$this._fail;
  set fail(String fail) => _$this._fail = fail;

  int _ts;
  int get ts => _$this._ts;
  set ts(int ts) => _$this._ts = ts;

  McEventBuilder();

  McEventBuilder get _$this {
    if (_$v != null) {
      _mcid = _$v.mcid;
      _fail = _$v.fail;
      _ts = _$v.ts;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(McEvent other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$McEvent;
  }

  @override
  void update(void updates(McEventBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$McEvent build() {
    final _$result = _$v ?? new _$McEvent._(mcid: mcid, fail: fail, ts: ts);
    replace(_$result);
    return _$result;
  }
}
