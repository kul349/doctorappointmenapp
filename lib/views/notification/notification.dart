import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  final String? payload; // Make payload nullable

  const NotificationView({super.key, this.payload});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notification"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text(payload ?? "No notification data"), // Handle null payload
            ],
          ),
        ),
      ),
    );
  }
}
