// To parse this JSON data, do
//
//     final customersLoginPostRespone = customersLoginPostResponeFromJson(jsonString);

import 'dart:convert';

CustomersLoginPostRespone customersLoginPostResponeFromJson(String str) => 
CustomersLoginPostRespone.fromJson(json.decode(str));

String customersLoginPostResponeToJson(CustomersLoginPostRespone data) => 
json.encode(data.toJson());

class CustomersLoginPostRespone {
    String message;
    Customer customer;

    CustomersLoginPostRespone({
        required this.message,
        required this.customer,
    });

    factory CustomersLoginPostRespone.fromJson(Map<String, dynamic> json) => CustomersLoginPostRespone(
        message: json["message"],
        customer: Customer.fromJson(json["customer"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "customer": customer.toJson(),
    };
}

class Customer {
    int idx;
    String fullname;
    String phone;
    String email;
    String image;

    Customer({
        required this.idx,
        required this.fullname,
        required this.phone,
        required this.email,
        required this.image,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        idx: json["idx"],
        fullname: json["fullname"],
        phone: json["phone"],
        email: json["email"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "idx": idx,
        "fullname": fullname,
        "phone": phone,
        "email": email,
        "image": image,
    };
}
