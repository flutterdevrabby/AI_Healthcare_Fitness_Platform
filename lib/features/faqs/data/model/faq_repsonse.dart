import 'dart:convert';

class FaqResponse {
  bool? status;
  String? message;
  int? code;
  Data? data;

  FaqResponse({this.status, this.message, this.code, this.data});

  FaqResponse copyWith({
    bool? status,
    String? message,
    int? code,
    Data? data,
  }) => FaqResponse(
    status: status ?? this.status,
    message: message ?? this.message,
    code: code ?? this.code,
    data: data ?? this.data,
  );

  factory FaqResponse.fromRawJson(String str) =>
      FaqResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FaqResponse.fromJson(Map<String, dynamic> json) => FaqResponse(
    status: json["status"],
    message: json["message"],
    code: json["code"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "code": code,
    "data": data?.toJson(),
  };
}

class Data {
  List<Faq>? faq;

  Data({this.faq});

  Data copyWith({List<Faq>? faq}) => Data(faq: faq ?? this.faq);

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    faq:
        json["faq"] == null
            ? []
            : List<Faq>.from(json["faq"]!.map((x) => Faq.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "faq": faq == null ? [] : List<dynamic>.from(faq!.map((x) => x.toJson())),
  };
}

class Faq {
  int? id;
  String? category;
  String? question;
  String? answer;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Faq({
    this.id,
    this.category,
    this.question,
    this.answer,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Faq copyWith({
    int? id,
    String? category,
    String? question,
    String? answer,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Faq(
    id: id ?? this.id,
    category: category ?? this.category,
    question: question ?? this.question,
    answer: answer ?? this.answer,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  factory Faq.fromRawJson(String str) => Faq.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Faq.fromJson(Map<String, dynamic> json) => Faq(
    id: json["id"],
    category: json["category"],
    question: json["question"],
    answer: json["answer"],
    status: json["status"],
    createdAt:
        json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt:
        json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "question": question,
    "answer": answer,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
