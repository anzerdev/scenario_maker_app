import 'package:scenario_maker_app/services/helpers.dart';

class ScenarioRequestModel {
  final SocialPlatform platform;
  final String videoTheme;
  final String targetAudience;
  final int videoLengthInSeconds;
  final String contentStyle;
  final String callToAction;

  ScenarioRequestModel({
    required this.platform,
    required this.videoTheme,
    required this.targetAudience,
    required this.videoLengthInSeconds,
    required this.contentStyle,
    required this.callToAction,
  });

  get title => null;

  get body => null;

  get request => null;

  Map<String, dynamic> toJSON() {
    return {
      'platform': platform.toString(),
      'videoTheme': videoTheme,
      'targetAudience': targetAudience,
      'videoLengthInSeconds': videoLengthInSeconds,
      'contentStyle': contentStyle,
      'callToAction': callToAction,
    };
  }

  static ScenarioRequestModel fromJSON(Map<String, dynamic> json){
    return ScenarioRequestModel(
      platform: SocialPlatform.values.firstWhere((e) => e.toString() == json['platform']),
      videoTheme: json['videoTheme'],
      targetAudience: json['targetAudience'],
      videoLengthInSeconds: json['videoLengthInSeconds'],
      contentStyle: json['contentStyle'],
      callToAction: json['callToAction'],
    );
  }
}