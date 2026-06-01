import 'dart:convert';

class PaymentSheetResponseModel {
    String? clientSecret;
    String? paymentIntentId;

    PaymentSheetResponseModel({
        this.clientSecret,
        this.paymentIntentId,
    });

    PaymentSheetResponseModel copyWith({
        String? clientSecret,
        String? paymentIntentId,
    }) => 
        PaymentSheetResponseModel(
            clientSecret: clientSecret ?? this.clientSecret,
            paymentIntentId: paymentIntentId ?? this.paymentIntentId,
        );

    factory PaymentSheetResponseModel.fromRawJson(String str) => PaymentSheetResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PaymentSheetResponseModel.fromJson(Map<String, dynamic> json) => PaymentSheetResponseModel(
        clientSecret: json["client_secret"],
        paymentIntentId: json["payment_intent_id"],
    );

    Map<String, dynamic> toJson() => {
        "client_secret": clientSecret,
        "payment_intent_id": paymentIntentId,
    };
}
