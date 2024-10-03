import 'package:doctorappointmenapp/services/notification_auth.dart';
import 'package:flutter/material.dart';

class DoctorNotificationPage extends StatefulWidget {
  final String userId;

  DoctorNotificationPage({required this.userId});

  @override
  _DoctorNotificationPageState createState() => _DoctorNotificationPageState();
}

class _DoctorNotificationPageState extends State<DoctorNotificationPage> {
  late Future<List<dynamic>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = fetchNotifications(
        'Doctor', widget.userId); // Fetch notifications for Doctor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Notifications'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];
                return ListTile(
                  title: Text(notification['title']),
                  subtitle: Text(notification['message']),
                  onTap: () {
                    // Handle notification click
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
