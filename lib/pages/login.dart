// // import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:flutter/widgets.dart';
// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: 
//       //  SizedBox(
//       //   width:MediaQuery.of(context).size.width,
//       //   child:Container(
//       //   color: Colors.amber,
//       //   child: Column(
//       //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//       //     children: [
//       //       Row(
//       //         mainAxisAlignment: MainAxisAlignment.start,
//       //         children: [
//       //           SizedBox(
//       //             width: 100,
//       //             height: 100,
//       //             child: Container(
//       //               color: Colors.blue,
//       //               ),
//       //             ),
//       //         ],
//       //       ),
//       //         Row(
//       //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       //           children: [
//       //             Row(
//       //               children: [
//       //                 SizedBox(
//       //                 width: 100,
//       //                 height: 100,
//       //                 child: Container(
//       //                   color: Colors.purple,
//       //                   ),
//       //                 ),
//       //               ],
//       //             ),
//       //           Row(
//       //             children: [
//       //             SizedBox(
//       //             width: 100,
//       //             height: 100,
//       //             child: Container(
//       //               color: Colors.red,
//       //               ),
//       //             ),
//       //              SizedBox(
//       //             width: 100,
//       //             height: 100,
//       //             child: Container(
//       //               color: Colors.green,
//       //               ),
//       //             ),
//       //                                 ],
//       //                               ),
//       //           ],
//       //         ),   
//       //     ],
//       //   ),
//       // ),
//       // ),
//     Column(
//       children: <Widget>[
//         const Text(
//           'Hello world',
//           style: TextStyle(
//             color: Colors.red, 
//             fontSize: 40, 
//             fontWeight: FontWeight.bold),
//           ),
//         const Padding(
//             padding: EdgeInsets.all(8.0),
//             child: TextField(decoration: InputDecoration(border: OutlineInputBorder(borderSide: BorderSide(width: 1))),   
//             ),
//           ),
//           Expanded(child:SingleChildScrollView(
//             child: Column(
//               children: [
//                 ElevatedButton(onPressed: (){}, child: const Text('ElevatedButton')),
//                 FilledButton(onPressed: (){}, child: const Text('FilledButton')),
//                 OutlinedButton(onPressed: (){}, child: const Text('OutlinedButton')),
//                 TextButton(onPressed: (){}, child: const Text('TextButton')),
//                 // ignore: prefer_const_constructors
//                 IconButton(onPressed: (){}, icon: Icon(Icons.file_download)),
//                 Image.asset('assets/images/butterbear.jpg'),
//                 Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2-TVphB148wg1omRxgqXTMk9lDbLyunCmdw&s')
//               ],
//             ),
//           ),
//           ),
//       ],
//     )
//   );}
// }

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/config/internal_config.dart';
import 'package:flutter_application_1/models/request/customerLoginPostReq.dart';
import 'package:flutter_application_1/models/response/customersLoginPostRes.dart';
import 'package:flutter_application_1/pages/register.dart';
import 'package:flutter_application_1/pages/showtrip.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String text = '';
  int n = 0;
  String url = '';
  String phoneNunmber = '';
  TextEditingController phoneCtl =  TextEditingController();
  TextEditingController passwordCtl =  TextEditingController();

 
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
      appBar: AppBar(),
      body: 
    
    SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onDoubleTap: () {
              log('Image double tap');
            },
            child: Image.asset('assets/images/logo.png')),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                'หมายเลขโทรศัพท์',
                  style: TextStyle(
                    color: Colors.black, 
                    fontSize: 15),
                  ),
                  TextField(
                    // onChanged: (value) {
                    //   log(value);
                    // },
                    obscureText: true,
                    controller: phoneCtl,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                      borderSide: BorderSide(width: 1))),
                      
                  ),
                    const Text(
                    'รหัสผ่าน',
                      style: TextStyle(
                        color: Colors.black, 
                        fontSize: 15),
                      ),
                TextField(
                   obscureText: true,
                   controller: passwordCtl,
                  decoration: const InputDecoration(
                    border: const OutlineInputBorder(
                    borderSide: BorderSide(width: 1))),
                ),
              ],
            ),
          ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child :Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => register(), 
                  child: const Text('ลงทะเบียนใหม่')),
                FilledButton(
                  onPressed: () => login(), 
                  child: const Text('เข้าสู่ระบบ')),
              ],
            ),
          ),
          Text(text)
        ],
      ),
    )
  );}

//  void register() {
//     log('This is Register button');
//     setState(() {
//       text = 'Hello world!!!';
//     });
//   }

  void register() {
    log(phoneNunmber);
    Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (context) => const RegisterPage(),
        ));
  }

  //  void login() {
  //   setState(() {
  //     n=n+1;
  //     text = 'Login time : $n';
  //   });
  //   log(phoneCtl.text);
  //   if(phoneCtl.text == "0812345678" && passwordCtl.text == "1234"){
  //     setState(() {
  //       text = '';
  //     });
  //     Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const ShowTripPage(),
  //       ));
  //   }
  //   else{
  //     setState(() {
  //       text = 'password is not corected';
  //     });
  //   }
  //  }

  void login() {
  //Call login api
  //var data = {"phone" : "0817399999", "password" :"1111"};

  //Create object (request Model)
  var data = CustomersLoginPostRequest(phone: phoneCtl.text, password: passwordCtl.text);
  
  // var data = CustomersLoginPostRequest(phone: "0817399999", password: "1111");
  // http.post(Uri.parse('$url/customers/login'),
  http.post(Uri.parse('$API_ENDPOINT/customers/login'),
    headers: {"Content-Type" : "application/json; charset=utf-8"},
    body: jsonEncode(data))
    .then(
    (value){
      //Convert json String to Object (Model)
      CustomersLoginPostRespone customer = customersLoginPostResponeFromJson(value.body);
      log(customer.customer.email);
      //Convert Json String to Map<String, String>
      // var jsonRes = jsonDecode(value.body);
      // log(jsonRes['customer']['email']);
        Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ShowTripPage(idx: customer.customer.idx),
        ));
        setState(() {
        text = ' ';
      });
    },
  ).catchError((eee){
    log(eee.toString());
    setState(() {
        text = 'password is not corected';
      });
  });
  }

  //ยังไม่แก้
  // void login() {
  //   var data = CustomersLoginPostRequest(phone: phoneCtl.text, password: passwordCtl.text);
  
  // // var data = CustomersLoginPostRequest(phone: "0817399999", password: "1111");
  // http.post(Uri.parse('http://10.34.40.60:3000/customers/login'),
  //   headers: {"Content-Type" : "application/json; charset=utf-8"},
  //   body: jsonEncode(data))
  //   .then(
  //   (value){
  //     //Convert json String to Object (Model)
  //     CustomersLoginPostRespone customer = customersLoginPostResponeFromJson(value.body);
  //     log(customer.customer.email);
  //     //Convert Json String to Map<String, String>
  //     // var jsonRes = jsonDecode(value.body);
  //     // log(jsonRes['customer']['email']);
  //       Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => const ShowTripPage(),
  //       ));
  //       setState(() {
  //       text = ' ';
  //     });
  //   },
  // ).catchError((eee){
  //   log(eee.toString());
  //   setState(() {
  //       text = 'password is not corected';
  //     });
  // });
  // }
}