import 'package:flutter/foundation.dart';
import 'package:flutter_pensil_app/helper/enum.dart';
import 'package:flutter_pensil_app/model/batch_meterial_model.dart';
import 'package:flutter_pensil_app/model/create_announcement_model.dart';
import 'package:flutter_pensil_app/model/video_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'batch_timeline_model.freezed.dart';
part 'batch_timeline_model.g.dart';

@JsonSerializable(nullable: true, includeIfNull: false)
class BatchTimelineResponse {
  BatchTimelineResponse({
    @required this.message,
    @required this.timeline,
  });

  final String message;
  final List<BatchTimeline> timeline;

  factory BatchTimelineResponse.fromJson(Map<String, dynamic> json) =>
      _$BatchTimelineResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BatchTimelineResponseToJson(this);
}

@Freezed(unionKey: 'type')
abstract class BatchTimeline with _$BatchTimeline {
  const BatchTimeline._();

  const factory BatchTimeline({
    @required RawType type,
    @required DateTime createdAt,
    @required dynamic datum,
  }) = _BatchTimeline;

  factory BatchTimeline.fromJson(Map<String, dynamic> json) => BatchTimeline(
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        datum: json["datum"] == null
            ? null
            : json["type"] == "video"
                ? VideoModel.fromJson(json["datum"])
                : json["type"] == "material"
                    ? BatchMaterialModel.fromJson(json["datum"])
                    : json["type"] == "announcement"
                        ? AnnouncementModel.fromJson(json["datum"])
                        : null,
      );
}
