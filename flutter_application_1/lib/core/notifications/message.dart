import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//import 'package:messaging_noti/serverkey.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  Map payload={};
  @override
  Widget build(BuildContext context) {
    final data=ModalRoute.of(context)!.settings.arguments;
    if(data is RemoteMessage){
      payload=data.data;
    }
    if(data is NotificationResponse){
      payload=jsonDecode(data.payload!);
    }
    return Scaffold(
      appBar: AppBar(title:const Text("Your Message")),
      body: Column(
        children: [
          
          Center(
            child: Text('The Data is : ${payload.toString()}'),
          ),
        ],
      ),
    );
  }
}