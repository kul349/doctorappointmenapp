import 'package:doctorappointmenapp/models/doctor/notification_model.dart';
import 'package:doctorappointmenapp/services/notification_auth.dart';
import 'package:flutter/material.dart';

// DoctorNotificationPage to display doctor-specific notifications
class DoctorNotificationPage extends StatefulWidget {
  final String userId;

  const DoctorNotificationPage({super.key, required this.userId});

  @override
  _DoctorNotificationPageState createState() => _DoctorNotificationPageState();
}

class _DoctorNotificationPageState extends State<DoctorNotificationPage> {
  late Future<List<NotificationModel>> notifications;

  @override
  void initState() {
    super.initState();
    notifications = fetchNotifications(
        'Doctor', widget.userId); // Fetch doctor-specific notifications
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Doctor Notifications'),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: notifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No notifications'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final notification = snapshot.data![index];

                return Dismissible(
                  key: Key(notification.id), // Unique key for each notification
                  direction: DismissDirection
                      .endToStart, // Allow dismissal from right to left
                  onDismissed: (direction) {
                    setState(() {
                      // Remove the dismissed notification from the list
                      snapshot.data!.removeAt(index);
                    });

                    // Optionally, you can call an API to delete the notification
                    deleteNotification(notification.id);

                    // Show a confirmation Snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Notification dismissed')),
                    );
                  },
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  child: ListTile(
                    title: Text(notification.title),
                    subtitle: Text(notification.message),
                    onTap: () {
                      // Handle notification click (e.g., navigate to a detail page)
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  // Simulated function to delete a notification (can be replaced with API call)
  Future<void> deleteNotification(String notificationId) async {
    // Add your deletion logic here
    print("Deleted notification with ID: $notificationId");
  }
}
