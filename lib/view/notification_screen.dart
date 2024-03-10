import 'package:flutter/material.dart';
import 'package:raj_lines/res/colors.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back_ios_new_outlined)),
        centerTitle: true,
        title: const Text(
          'Notification',
          style: TextStyle(
              fontFamily: 'Poppins',
              color: AppColor.white,
              fontSize: 16,
              fontWeight: FontWeight.w400),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xff12C1B1), Color(0xff0C68AD)])),
        ),
      ),
    );
  }
}
