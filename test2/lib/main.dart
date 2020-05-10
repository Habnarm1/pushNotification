import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:workmanager/workmanager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

//this is the name given to the background fetch
const simplePeriodicTask = "simplePeriodicTask";
// flutter local notification setup
void showNotification( v, flp) async {
  var android = AndroidNotificationDetails(
      'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
      priority: Priority.High, importance: Importance.Max);
  var iOS = IOSNotificationDetails();
  var platform = NotificationDetails(android, iOS);
  await flp.show(0, 'Virtual intelligent solution', '$v', platform,
      payload: 'VIS \n $v');
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager.initialize(callbackDispatcher, isInDebugMode: true);
  await Workmanager.registerPeriodicTask("5", simplePeriodicTask,
      existingWorkPolicy: ExistingWorkPolicy.replace,
      frequency: Duration(minutes: 15),//when should it check the link
      initialDelay: Duration(seconds: 5),//duration before showing the notification
      constraints: Constraints(
        networkType: NetworkType.connected,
      ));
  runApp(MyApp());
}

void callbackDispatcher() {
  Workmanager.executeTask((task, inputData) async {

    FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSetttings = InitializationSettings(android, iOS);
    flp.initialize(initSetttings);
   var response= await http.post('https://seeviswork.000webhostapp.com/api/testapi.php');
   print("here================");
   print(response);
    var convert = json.decode(response.body);
      if (convert['status']  == true) {
        showNotification(convert['msg'], flp);
      } else {
      print("no messgae");
      }


    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  MyApp();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HABNARM',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold( appBar:AppBar(title:Text("TESTING PUSH NOTIFICATION")),
              body: Align(
                alignment: Alignment.center,
                              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
       child: Text("VIS (VIRTUAL INTELLIGENCE SOLUTION)")
        ),
                ),
              )
        ));
  }
}






































//     var map = Map<dynamic, dynamic>();
//     map['userid'] =2.toString();// userid.toString();
//     map['shopid'] = 2.toString();//shopid.toString();
// var response= await http.post('http://localhost/youtube/testapi.php',body: map);


// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// import 'package:flutter/material.dart';
// import 'package:workmanager/workmanager.dart';

// //name this any name u like
// const simplePeriodicTask = "simplePeriodicTask";
// //this is the local flutter notification
// void showNotification( v,flp) async {
//     var android = AndroidNotificationDetails(
//         'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
//         priority: Priority.High, importance: Importance.Max);
//     var iOS = IOSNotificationDetails();
//     var platform = NotificationDetails(android, iOS);
//     await flp .show(
//         // 0, 'RSG Notification', '${v.msgApprove} ${v.msgMsg}', platform,
//         0, 'Daily notification', 'Worship Allah and do good deeds', platform,
//         // payload: '${v.msgApprove} \n ${v.msgMsg}');
//         payload: 'Humayroh');
//   }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
// //start d work manager
//   await Workmanager.initialize(callbackDispatcher,
//       isInDebugMode: false//this is for debuging, turn true in debug but false in live 
//       );
//       //this is the periodic calling
//   await Workmanager.registerPeriodicTask(
//     "5",//this means how many time it should show the notification once it get it
//     simplePeriodicTask,//this is d name of the background from d const we set above
//     existingWorkPolicy: ExistingWorkPolicy.replace,//in case of collision
//     frequency: Duration(minutes: 15),// this is when it should call the notification or action in the execute task in callBackdispatcher function
//       initialDelay: Duration(minutes: 1), //this is the interval to show the notification based on the number u set above, like 5 above once it show 1 it wait 1min nd show anoda 
//       constraints: Constraints(
//       networkType: NetworkType.connected,//this hecks that d network is on
//     )     
//   );
//   runApp(MyApp());
// }



// void callbackDispatcher() {
//   //this is where u call anything u wnt to happen in background
//   Workmanager.executeTask((task, inputData) async{
//  FlutterLocalNotificationsPlugin flp =
//     FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOS = IOSInitializationSettings();
//     var initSetttings = InitializationSettings(android, iOS);
//     flp .initialize(initSetttings);
//     try {
//  var response= await http.post('https://seeviswork.000webhostapp.com/appoint/apapi/allcountry.php');
//     var convert = json.decode(response.body);
//           if (convert != null) {
//             showNotification("love",flp);
//           } else {
//            print("yyyy");
//           }
//     }on SocketException catch (_) {
//    print("err");
//     } //simpleTask will be emitted here.
//     return Future.value(true);
//   });
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     //  appNotif();
//     return MaterialApp(
//       home: Scaffold(appBar: AppBar(title:Text("FINAL TEST")),)
//     );
//   }
// }

