import 'package:flutter/material.dart';
import 'package:doctorappointmenapp/services/notification_auth.dart';

class NotificationPage extends StatefulWidget {
  final String userId; // You can still pass the userId dynamically

  NotificationPage({required this.userId});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Future<List<dynamic>> notifications;
  final String userType = 'Patient'; // Hardcoded as 'Patient'

  @override
  void initState() {
    super.initState();
    // Fetch notifications with the userType set as 'Patient'
    notifications = fetchNotifications(userType, widget.userId);
    print(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
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
                    // Handle what happens when notification is clicked
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
