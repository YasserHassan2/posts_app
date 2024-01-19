// To parse this JSON data, do
//
//     final baseResponse = baseResponseFromJson(jsonString);

import 'dart:convert';

BaseResponse baseResponseFromJson(String str) =>
    BaseResponse.fromJson(json.decode(str));

String baseResponseToJson(BaseResponse data) => json.encode(data.toJson());

class BaseResponse {
  int? statusCode;
  String? statusMessage;
  bool? success;

  BaseResponse({
    this.statusCode,
    this.statusMessage,
    this.success,
  });

  factory BaseResponse.fromJson(Map<String, dynamic> json) => BaseResponse(
        statusCode: json["status_code"],
        statusMessage: json["status_message"],
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode,
        "status_message": statusMessage,
        "success": success,
      };
}
