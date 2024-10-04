import 'package:doctorappointmenapp/services/notification_auth.dart';
import 'package:doctorappointmenapp/utils/decode_patient_token.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final String userType = 'Patient';

  Future<List<dynamic>> fetchNotificationsWithUserId() async {
    String? userId = await TokenHelper.getPatientId();
    print('User ID in NotificationPage: $userId'); // Debugging line

    if (userId != null && userId.isNotEmpty) {
      return await fetchNotifications(userType, userId);
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchNotificationsWithUserId(),
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
                return ListTile(
                  title: Text(notification['title']),
                  subtitle: Text(notification['message']),
                );
              },
            );
          }
        },
      ),
    );
  }
}
