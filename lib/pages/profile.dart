// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/response/customerGetIdxResdart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  int idx = 0;
  ProfilePage({super.key, required this.idx});
  
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
TextEditingController fullnameCtl =  TextEditingController();
  TextEditingController phoneCtl =  TextEditingController();
  TextEditingController emailCtl =  TextEditingController();
  TextEditingController imageCtl =  TextEditingController();

class _ProfilePageState extends State<ProfilePage> {
late CustomerGetIdxRespon customer;
late Future<void> loadData;
String url ='';

    @override
    void initState(){
    super.initState();
    loadData = loadDataAsync();
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ข้อมูลส่วนตัว'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
  log(value);
  if (value == 'delete') {
	showDialog(
	  context: context,
	  builder: (context) => SimpleDialog(
		children: [
		  const Padding(
			padding: EdgeInsets.all(16.0),
			child: Text(
			  'ยืนยันการยกเลิกสมาชิก?',
			  style: TextStyle(
				  fontSize: 14, fontWeight: FontWeight.bold),
			),
		  ),
		  Row(
			mainAxisAlignment: MainAxisAlignment.spaceAround,
			children: [
			  TextButton(
				  onPressed: () {
					Navigator.pop(context);
				  },
				  child: const Text('ปิด')),
			  FilledButton(
				  onPressed: () {}, child: const Text('ยืนยัน'))
			],
		  ),
		],
	  ),
	);
  }
},
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('ยกเลิกสมาชิก'),

              ),
            ],
          ),
        ],
      ),
      body: FutureBuilder(
        future: loadData ,
        builder: (context, snapshot){
          if(snapshot.connectionState != ConnectionState.done){
          return const Center(child: CircularProgressIndicator(),);
        }
        fullnameCtl.text = customer.fullname;
        phoneCtl.text = customer.phone;
        emailCtl.text = customer.email;
        imageCtl.text = customer.image;
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              SizedBox(width: 200, child: Image.network(customer.image),),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ชื่อ-นามสกุล'),
                    TextField(
                      controller: fullnameCtl ,
                    )
                  ],
                 ),
               ),
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('หมายเลขโทรศัพท์'),
                    TextField(
                      controller: phoneCtl ,
                    )
                  ],
                 ),
               ),
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('อีเมล'),
                    TextField(
                      controller: emailCtl ,
                    )
                  ],
                 ),
               ),
                Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('รูปภาพ'),
                    TextField(
                      controller: imageCtl ,
                    )
                  ],
                 ),
               ),
               Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child: Center(
                    child: FilledButton(
                      onPressed: update,
                      child: const Text('บันทึกข้อมูล'),
                      ),
                  ),
               )               
            ],),
          ),
        );
        },),
    );
  }
  Future<void> loadDataAsync() async{
    await Future.delayed(const Duration(seconds: 2));
    //get url 
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    //เรียก api/trips
    var data = await http.get(Uri.parse('$url/customers/${widget.idx}'));
    customer = customerGetIdxResponFromJson(data.body);
    log(customer.fullname);
  }
  void update() async{
    var json ={
	"fullname": fullnameCtl.text,
	"phone": phoneCtl.text,
	"email": emailCtl.text,
	"image": imageCtl.text,
};
var value = await Configuration.getConfig();
var url = value['apiEndpoint'];
try{
var data = await http.put(Uri.parse('$url/customers/${widget.idx}'),
headers: {"Content-Type" : "application/json; charset=utf-8"},
body: jsonEncode(json));
log(data.body);
showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('สำเร็จ'),
          content: const Text('บันทึกข้อมูลเรียบร้อย'),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
}catch (err) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('บันทึกข้อมูลไม่สำเร็จ ' + err.toString()),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    }
  }

  void delete() async{
    var value = await Configuration.getConfig();
    var url = value['apiEndpoint'];
    try{
      var data = await http.delete(Uri.parse('$url/customers/${widget.idx}'));
      showDialog(
        context: context, 
        builder: (context)=>AlertDialog(
          title: Text('สำเร็จ'),
          content: Text('ลบข้อมูลเรียบร้อย'),
          actions: [
            FilledButton(
            onPressed: (){
              Navigator.popUntil(
                context, 
              (route)=>route.isFirst,
              );
            }, 
            child: Text('ปิด'))
          ],
        ));
    }catch(err){
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('ผิดพลาด'),
          content: Text('บันทึกข้อมูลไม่สำเร็จ ' + err.toString()),
          actions: [
            FilledButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('ปิด'))
          ],
        ),
      );
    }
  }
}