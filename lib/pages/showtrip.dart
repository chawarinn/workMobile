
// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/response/tripsGetRes.dart';
import 'package:flutter_application_1/pages/login.dart';
import 'package:flutter_application_1/pages/profile.dart';
import 'package:flutter_application_1/pages/trip.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/config.dart';

class ShowTripPage extends StatefulWidget {
  int idx = 0;
  ShowTripPage({super.key, required this.idx});

  @override
  State<ShowTripPage> createState() => _ShowTripPageState();
}

class _ShowTripPageState extends State<ShowTripPage> {

//3 ใช้ loadDataAsync
late Future<void> loadData;

   String url = '';
   List<TripsGetResponse> trips = [];
    @override
    void initState(){
    super.initState();
    // Configuration.getConfig()
    // .then(
    //   (value){
    //     url = value['apiEndpoint'];
    //     log(value['apiEndpoint']);
    //   },).catchError((err){
    //     log(err.toString());
    //   });
    loadData = loadDataAsync();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายการทริป'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              log(value); 
              if(value == 'profile'){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => ProfilePage(idx: widget.idx),
              ));
              }else if(value == 'logout'){
                Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => LoginPage(),
              ));
              }       
            },
            itemBuilder: (context) => [
              const PopupMenuItem<String>(
                value: 'profile',
                child: Text('ข้อมูลส่วนตัว'),
              ),
              const PopupMenuItem<String>(
                value: 'logout',
                child: Text('ออกจากระบบ'),
              ),
            ],
          ),
        ],
      ),
      body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const Text(
                 'ปลายทาง',
                   style: TextStyle(
                     color: Colors.black, 
                     fontSize: 15),
           ),
           SingleChildScrollView(
            scrollDirection: Axis.horizontal,
             child: Padding(
                 padding: const EdgeInsets.symmetric(horizontal: 20),
                 child :Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   FilledButton(
                     onPressed: () => gettrip(null), 
                     child: const Text('ทั้งหมด')),
                   FilledButton(
                     onPressed: () => gettrip('เอเชีย'), 
                     child: const Text('เอเชีย')),
                   FilledButton(
                     onPressed: () => gettrip('ยุโรป'), 
                     child: const Text('ยุโรป')),
                   FilledButton(
                     onPressed: () => gettrip('เอเชียตะวันออกเฉียงใต้'), 
                     child: const Text('อาเซียน')),
                  FilledButton(
                     onPressed: () => gettrip('ประเทศไทย'), 
                     child: const Text('ประเทศไทย')),
                  // FilledButton(
                  //    onPressed: () {}, 
                  //    child: const Text('อาเซียน')),
                 ],
               ),
             ),
           ),
           Expanded(
             child: SingleChildScrollView(
               child: 
               //1.สร้าง FutureBuilder
               FutureBuilder(
                future: loadData,
                 builder: (context, snapshot) {
                  if(snapshot.connectionState != ConnectionState.done){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                   return Column(
                    children: trips
                    .map(
                      (trip) => 
                                          Card(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                       Text(
                                          trip.name,
                                          style: TextStyle(
                                          color: Colors.black, 
                                          fontSize: 20),
                                      ),
                                      Row(
                                        children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.network(trip.coverimage,width: 180),
                                        ),
                                          Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                              Text('ประเทศ${trip.country}'),
                                              Text('ระยะเวลา ${trip.duration} วัน'),
                                              Text('ราคา ${trip.price} บาท'),
                                              FilledButton(
                                            onPressed: ()=> goToTripPage(trip.idx), 
                                            child: const Text('รายละเอียดเพิ่มเติม')),
                                           ],
                                         ),  
                                        ],  
                                      ),
                                    ],
                                  ),
                                ),  
                    ).toList(),
                   );
                 }
               ),
             ),
           ),  
         ],  
       )
    );
  }

//2 สร้างFutureใช้โหลดข้อมูล
Future<void> loadDataAsync() async{
 await Future.delayed(const Duration(seconds: 2));
//get url 
var value = await Configuration.getConfig();
url = value['apiEndpoint'];
//เรียก api/trips
var data = await http.get(Uri.parse('$url/trips'));
trips = tripsGetResponseFromJson(data.body);
}

void gettrip(String? zone) async {
    http.get(Uri.parse('$url/trips')).then(
      (value){
          trips = tripsGetResponseFromJson(value.body);
          List<TripsGetResponse> filteredTrips = [];
          if(zone != null){
            log(zone);
            for(var trip in trips){
              if(trip.destinationZone == zone){
                log('hhhh');
                filteredTrips.add(trip);
              }
            }
            trips = filteredTrips;
          } else {
            trips = tripsGetResponseFromJson(value.body);
          }
          log(trips.length.toString());
          log(zone.toString());
          setState(() {
    });
      },
    ).catchError((eee){
      log(eee.toString());
    });
}
  
  goToTripPage(int idx) {
     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TripPage(idx: idx),
        ));
  }
}