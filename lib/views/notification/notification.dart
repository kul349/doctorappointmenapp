import 'package:doctorappointmenapp/models/doctor/notification_model.dart';
import 'package:doctorappointmenapp/services/notification_auth.dart'; // For fetching notifications
import 'package:doctorappointmenapp/utils/decode_patient_token.dart'; // For decoding patient token
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final String userType = 'Patient';
  List<NotificationModel> notifications = [];

  @override
  void initState() {
    super.initState();
    _loadNotifications(); // Load notifications when the page initializes
  }

  // Function to load notifications from the backend
  Future<void> _loadNotifications() async {
    String? userId = await TokenHelper.getPatientId();
    if (userId != null && userId.isNotEmpty) {
      List<NotificationModel> fetchedNotifications =
          await fetchNotifications(userType, userId);
      setState(() {
        notifications = fetchedNotifications;
      });
    }
  }

  // Function to delete notification from backend and update UI
  Future<void> _deleteNotification(String notificationId) async {
    String? userId = await TokenHelper.getPatientId();
    if (userId == null || userId.isEmpty) return;

    bool isDeleted = await deleteNotification(notificationId, userId);
    if (isDeleted) {
      setState(() {
        notifications
            .removeWhere((notification) => notification.id == notificationId);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: notifications.isEmpty
          ? const Center(child: Text('No notifications'))
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];

                return Dismissible(
                  key: Key(
                      notification.id!), // Unique key based on notification ID
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20.0),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    _deleteNotification(
                        notification.id!); // Delete the notification on swipe
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notification deleted')),
                    );
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person, color: Colors.white),
                      backgroundColor: Colors.blue,
                    ),
                    title: Text(notification.title),
                    subtitle: Text(notification.message),
                  ),
                );
              },
            ),
    );
  }
}
