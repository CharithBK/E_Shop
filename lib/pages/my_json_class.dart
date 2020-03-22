// To parse this JSON data, do
//
//     final myJsonClass = myJsonClassFromJson(jsonString);
import 'login.dart';

import 'dart:convert';

MyJsonClass myJsonClassFromJson(String str) {
    final jsonData = json.decode(str);
    return MyJsonClass.fromJson(jsonData);
}

String myJsonClassToJson(MyJsonClass data) {
    final dyn = data.toJson();
    return json.encode(dyn);
}

class MyJsonClass {
    String total;
    List<Result> results;

    MyJsonClass({
        this.total,
        this.results,
    });

    factory MyJsonClass.fromJson(Map<String, dynamic> json) => new MyJsonClass(
        total: json["total"] == null ? null : json["total"],
        results: json["results"] == null ? null : new List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total == null ? null : total,
        "results": results == null ? null : new List<dynamic>.from(results.map((x) => x.toJson())),
    };
}

class Result {
    String id;
    String date;
    String reg;
    String start;
    String end;

    Result({
        this.id,
        this.date,
        this.reg,
        this.start,
        this.end,
    });

    factory Result.fromJson(Map<String, dynamic> json) => new Result(
        id: json["ID"] == null ? null : json["ID"],
        date: json["DATE"] == null ? null : json["DATE"],
        reg: json["REG"] == null ? null : json["REG"],
        start: json["START"] == null ? null : json["START"],
        end: json["END"] == null ? null : json["END"],
    );

    Map<String, dynamic> toJson() => {
        "ID": id == null ? null : id,
        "DATE": date == null ? null : date,
        "REG": reg == null ? null : reg,
        "START": start == null ? null : start,
        "END": end == null ? null : end,
    };
}
