// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'batch_timeline_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
BatchTimeline _$BatchTimelineFromJson(Map<String, dynamic> json) {
  return _BatchTimeline.fromJson(json);
}

/// @nodoc
class _$BatchTimelineTearOff {
  const _$BatchTimelineTearOff();

// ignore: unused_element
  _BatchTimeline call(
      {@required RawType type,
      @required DateTime createdAt,
      @required dynamic datum}) {
    return _BatchTimeline(
      type: type,
      createdAt: createdAt,
      datum: datum,
    );
  }

// ignore: unused_element
  BatchTimeline fromJson(Map<String, Object> json) {
    return BatchTimeline.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $BatchTimeline = _$BatchTimelineTearOff();

/// @nodoc
mixin _$BatchTimeline {
  RawType get type;
  DateTime get createdAt;
  dynamic get datum;

  Map<String, dynamic> toJson();
  $BatchTimelineCopyWith<BatchTimeline> get copyWith;
}

/// @nodoc
abstract class $BatchTimelineCopyWith<$Res> {
  factory $BatchTimelineCopyWith(
          BatchTimeline value, $Res Function(BatchTimeline) then) =
      _$BatchTimelineCopyWithImpl<$Res>;
  $Res call({RawType type, DateTime createdAt, dynamic datum});
}

/// @nodoc
class _$BatchTimelineCopyWithImpl<$Res>
    implements $BatchTimelineCopyWith<$Res> {
  _$BatchTimelineCopyWithImpl(this._value, this._then);

  final BatchTimeline _value;
  // ignore: unused_field
  final $Res Function(BatchTimeline) _then;

  @override
  $Res call({
    Object type = freezed,
    Object createdAt = freezed,
    Object datum = freezed,
  }) {
    return _then(_value.copyWith(
      type: type == freezed ? _value.type : type as RawType,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      datum: datum == freezed ? _value.datum : datum as dynamic,
    ));
  }
}

/// @nodoc
abstract class _$BatchTimelineCopyWith<$Res>
    implements $BatchTimelineCopyWith<$Res> {
  factory _$BatchTimelineCopyWith(
          _BatchTimeline value, $Res Function(_BatchTimeline) then) =
      __$BatchTimelineCopyWithImpl<$Res>;
  @override
  $Res call({RawType type, DateTime createdAt, dynamic datum});
}

/// @nodoc
class __$BatchTimelineCopyWithImpl<$Res>
    extends _$BatchTimelineCopyWithImpl<$Res>
    implements _$BatchTimelineCopyWith<$Res> {
  __$BatchTimelineCopyWithImpl(
      _BatchTimeline _value, $Res Function(_BatchTimeline) _then)
      : super(_value, (v) => _then(v as _BatchTimeline));

  @override
  _BatchTimeline get _value => super._value as _BatchTimeline;

  @override
  $Res call({
    Object type = freezed,
    Object createdAt = freezed,
    Object datum = freezed,
  }) {
    return _then(_BatchTimeline(
      type: type == freezed ? _value.type : type as RawType,
      createdAt:
          createdAt == freezed ? _value.createdAt : createdAt as DateTime,
      datum: datum == freezed ? _value.datum : datum as dynamic,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_BatchTimeline extends _BatchTimeline with DiagnosticableTreeMixin {
  const _$_BatchTimeline(
      {@required this.type, @required this.createdAt, @required this.datum})
      : assert(type != null),
        assert(createdAt != null),
        assert(datum != null),
        super._();

  factory _$_BatchTimeline.fromJson(Map<String, dynamic> json) =>
      _$_$_BatchTimelineFromJson(json);

  @override
  final RawType type;
  @override
  final DateTime createdAt;
  @override
  final dynamic datum;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'BatchTimeline(type: $type, createdAt: $createdAt, datum: $datum)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'BatchTimeline'))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('datum', datum));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BatchTimeline &&
            (identical(other.type, type) ||
                const DeepCollectionEquality().equals(other.type, type)) &&
            (identical(other.createdAt, createdAt) ||
                const DeepCollectionEquality()
                    .equals(other.createdAt, createdAt)) &&
            (identical(other.datum, datum) ||
                const DeepCollectionEquality().equals(other.datum, datum)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(type) ^
      const DeepCollectionEquality().hash(createdAt) ^
      const DeepCollectionEquality().hash(datum);

  @override
  _$BatchTimelineCopyWith<_BatchTimeline> get copyWith =>
      __$BatchTimelineCopyWithImpl<_BatchTimeline>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_BatchTimelineToJson(this);
  }
}

abstract class _BatchTimeline extends BatchTimeline {
  const _BatchTimeline._() : super._();
  const factory _BatchTimeline(
      {@required RawType type,
      @required DateTime createdAt,
      @required dynamic datum}) = _$_BatchTimeline;

  factory _BatchTimeline.fromJson(Map<String, dynamic> json) =
      _$_BatchTimeline.fromJson;

  @override
  RawType get type;
  @override
  DateTime get createdAt;
  @override
  dynamic get datum;
  @override
  _$BatchTimelineCopyWith<_BatchTimeline> get copyWith;
}
