import 'dart:convert';

import 'package:flutter/material.dart';

List<Response> responseFromJson(String str) =>
    List<Response>.from(json.decode(str).map((x) => Response.fromJson(x)));

String responseToJson(List<Response> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Response with ChangeNotifier {
  Response({
    this.label,
    this.type,
    this.placeholder,
    this.value,
    this.options,
  });

  String? label;
  String? type;
  String? placeholder;
  dynamic value;
  List<Option>? options;

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        label: json["label"],
        type: json["type"],
        placeholder: json["placeholder"] == null ? null : json["placeholder"],
        value: json["value"],
        options: json["options"] == null
            ? null
            : List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "type": type,
        "placeholder": placeholder == null ? null : placeholder,
        "value": value,
        "options": options == null
            ? null
            : List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.key,
    this.value,
    this.checked,
  });

  int? key;
  String? value;
  bool? checked;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        key: json["key"],
        value: json["value"],
        checked: json["checked"] == null ? null : json["checked"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "checked": checked == null ? null : checked,
      };
}
