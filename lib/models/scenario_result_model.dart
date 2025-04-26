import 'package:scenario_maker_app/models/scenario_request_model.dart';

class ScenarioResultModel {
  final String id;
  final String title;
  final String body;
  final ScenarioRequestModel request;

  ScenarioResultModel({
    required this.id,
    required this.title,
    required this.body,
    required this.request,
  });

  Map<String, dynamic> toJSON() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'request': request.toJSON(),
    };
  }

  static ScenarioResultModel fromJSON(Map<String, dynamic> json) {
    return ScenarioResultModel(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      request: ScenarioRequestModel.fromJSON(json['request']),
    );
  }
}