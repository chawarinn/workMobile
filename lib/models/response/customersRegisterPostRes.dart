// To parse this JSON data, do
//
//     final customersRegisterPostResponse = customersRegisterPostResponseFromJson(jsonString);

import 'dart:convert';

CustomersRegisterPostResponse customersRegisterPostResponseFromJson(String str) => CustomersRegisterPostResponse.fromJson(json.decode(str));

String customersRegisterPostResponseToJson(CustomersRegisterPostResponse data) => json.encode(data.toJson());

class CustomersRegisterPostResponse {
    String message;
    int id;

    CustomersRegisterPostResponse({
        required this.message,
        required this.id,
    });

    factory CustomersRegisterPostResponse.fromJson(Map<String, dynamic> json) => CustomersRegisterPostResponse(
        message: json["message"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
    };
}
