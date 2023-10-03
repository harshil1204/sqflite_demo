import 'package:firebase_messaging/firebase_messaging.dart';

class NotoficationServices {
  FirebaseMessaging firebaseMessaging=FirebaseMessaging.instance;
  void requestNotificationPermission() async{

    NotificationSettings notificationSettings=await firebaseMessaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if(notificationSettings.authorizationStatus==AuthorizationStatus.authorized)
      {
        print("user granted permission");
      }
    else if(notificationSettings.authorizationStatus==AuthorizationStatus.provisional)
      {
        print("user granted provisional");
      }
    else{
      print("user denied permission");
    }
  }

  void firebaseInit(){
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification!.title.toString());
      print(message.notification!.body.toString());
    });
  }

  Future<String> getDeviceToken() async{
    String? token=await firebaseMessaging.getToken();
    return token!;
  }

  void isTOkenRefresh(){
    firebaseMessaging.onTokenRefresh.listen((event) {
      event.toString();
      print("refresh");
    });
  }

}