// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'batch_timeline_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BatchTimelineResponse _$BatchTimelineResponseFromJson(
    Map<String, dynamic> json) {
  return BatchTimelineResponse(
    message: json['message'] as String,
    timeline: (json['timeline'] as List)
        ?.map((e) => e == null
            ? null
            : BatchTimeline.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$BatchTimelineResponseToJson(
    BatchTimelineResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('timeline', instance.timeline);
  return val;
}

_$_BatchTimeline _$_$_BatchTimelineFromJson(Map<String, dynamic> json) {
  return _$_BatchTimeline(
    type: _$enumDecodeNullable(_$RawTypeEnumMap, json['type']),
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
    datum: json['datum'],
  );
}

Map<String, dynamic> _$_$_BatchTimelineToJson(_$_BatchTimeline instance) =>
    <String, dynamic>{
      'type': _$RawTypeEnumMap[instance.type],
      'createdAt': instance.createdAt?.toIso8601String(),
      'datum': instance.datum,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$RawTypeEnumMap = {
  RawType.VIDEO: 'VIDEO',
  RawType.MATERIAL: 'MATERIAL',
  RawType.ANNOUNCEMENT: 'ANNOUNCEMENT',
};
