import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/request/customerRegisterPostRequest.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  TextEditingController fullnameCtl =  TextEditingController();
  TextEditingController phoneCtl =  TextEditingController();
  TextEditingController emailCtl =  TextEditingController();
  TextEditingController imageCtl =  TextEditingController();
  TextEditingController passwordCtl =  TextEditingController();
  TextEditingController confirmPasswordCtl =  TextEditingController();
  String url = '';
   String text = '';

    @override
  void initState(){
    super.initState();
    Configuration.getConfig()
    .then(
      (value){
        url = value['apiEndpoint'];
        log(value['apiEndpoint']);
      },).catchError((err){
        log(err.toString());
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลงทะเบียนสมาชิกใหม่'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'ชื่อ-นามสกุล',
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: fullnameCtl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              const Text(
                'หมายเลขโทรศัพท์',
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: phoneCtl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              const Text(
                'อีเมล์',
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: emailCtl,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              const Text(
                'รหัสผ่าน',
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: passwordCtl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              const Text(
                'ยืนยันรหัสผ่าน',
                style: TextStyle(
                  color: Colors.black, 
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: TextField(
                  controller: confirmPasswordCtl,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1),
                    ),
                  ),
                ),
              ),
              Center(
                child: FilledButton(
                  onPressed: register, 
                  child: const Text('สมัครสมาชิก'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {}, 
                    child: const Text('หากมีบัญชีอยู่แล้ว?')
                  ),
                  TextButton(
                    onPressed: () {}, 
                    child: const Text('เข้าสู่ระบบ')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if(fullnameCtl.text.isNotEmpty &&
        phoneCtl.text.isNotEmpty &&
        emailCtl.text.isNotEmpty &&
        passwordCtl.text.isNotEmpty &&
        confirmPasswordCtl.text.isNotEmpty
      ){
    if(passwordCtl.text == confirmPasswordCtl.text){
      var data = CustomersRegisterPostRequest(
      fullname: fullnameCtl.text, 
      phone: phoneCtl.text, 
      email: emailCtl.text, 
      image: "http://202.28.34.197:8888/contents/4a00cead-afb3-45db-a37a-c8bebe08fe0d.png", 
      password: passwordCtl.text);
      log(url);
    http.post(Uri.parse('$url/customers'),
    headers: {"Content-Type" : "application/json; charset=utf-8"},
    body: jsonEncode(data))
      .then(
    (value){
      log("Login successful");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ));
    },
  ).catchError((eee){
   // ignore: prefer_interpolation_to_compose_strings
   log("Insert Error" + eee.toString());
  });
  }else{
     setState(() {
        text = 'password is not corected';
      });
  }
  }
}
}
