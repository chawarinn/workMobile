// ignore_for_file: must_be_immutable, unused_import

import 'dart:developer';

import 'package:flutter_application_1/models/response/tripGetIdxResponse.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';

class TripPage extends StatefulWidget {
  //Attribute of TripPage
  int idx = 0;
  TripPage({super.key, required this.idx});

  @override
  State<TripPage> createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {

late Future<void> loadData;

   String url = '';
   late TripsGetIdxRespon trip;

    @override
    void initState(){
    super.initState();
    loadData = loadDataAsync();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('รายละเอียดทริป'),
      ),
      body: FutureBuilder(
        future: loadData,
        builder: (context, snapshot){
       if(snapshot.connectionState != ConnectionState.done){
          return const Center(child: CircularProgressIndicator(),);
        }
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(
                trip.name,
                // ignore: prefer_const_constructors
                style: TextStyle(
                color: Colors.black, 
                fontSize: 20,
                fontWeight: FontWeight.bold,
                ),),
              Text(trip.country),
              Image.network(trip.coverimage),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('ราคา ${trip.price.toString()} บาท'),
                  Text('โซน${trip.destinationZone}'),
                ],
              ),
              Text(trip.detail),
              Center(
                child: FilledButton(
                  onPressed: () {},
                  child: const Text('จองทริปนี้'),
                  ),
              )
            ],),
          ),
        );
      }),
    );
  }
  Future<void> loadDataAsync() async{
    await Future.delayed(const Duration(seconds: 2));
    //get url 
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];
    //เรียก api/trips
    var data = await http.get(Uri.parse('$url/trips/${widget.idx}'));
    trip = tripsGetIdxResponFromJson(data.body);
  }
}