import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sqflite_demo/database_helper.dart';

import 'notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  NotoficationServices notoficationServices=NotoficationServices();


  @override
  void initState() {
    notoficationServices.firebaseInit();
    notoficationServices.requestNotificationPermission();
    notoficationServices.getDeviceToken().then((value){
      print("device token:");
      print(value);
    });
    // TODO: implement initState
    super.initState();
  }




  final dbhelper=DatabaseHelper.instance;
  void inserdata() async{
    Map<String,dynamic> row={
      DatabaseHelper.columnName:"dhrey",
      DatabaseHelper.columnAge:20,
    };
    final id= await dbhelper.insert(row);
    print(id);
  }

  void queryall() async{
    var allrow= await dbhelper.query();
    allrow.forEach((element) {
      print(element);
    });
  }

  void queryspeci() async{
    var allrow= await dbhelper.queryspecific(20);
    allrow.forEach((element) {
      print(element);
    });
  }

  void delete()async{
    var id=await dbhelper.deletedata(2);
    print(id);
  }

  void update()async{
    var row=await dbhelper.update(4);
    print(row);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Sqflite Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed:inserdata,
              child: Text("Insert"),
            ),
            ElevatedButton(onPressed: queryall,
              child: Text("Quary"),
            ),
            ElevatedButton(onPressed: queryspeci,
              child: Text("Quary specific"),
            ),
            ElevatedButton(onPressed: update,
              child: Text("update"),
            ),
            ElevatedButton(onPressed: delete,
              child: Text("delete"),
            )


          ],
        ),
      ),
    );
  }
}
