import 'package:doctorappointmenapp/controllers/favorites_doctor_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';

class FavoritesPage extends StatelessWidget {
  final FavoritesController favoritesController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favorites'),
        backgroundColor: Colors.green,
      ),
      body: Obx(() {
        if (favoritesController.favoriteDoctors.isEmpty) {
          return const Center(child: Text('No favorite doctors added.'));
        }

        return ListView.builder(
          itemCount: favoritesController.favoriteDoctors.length,
          itemBuilder: (context, index) {
            final DoctorModel doctor = favoritesController.favoriteDoctors[index];

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 3,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: doctor.avatar.isNotEmpty
                      ? NetworkImage(doctor.avatar)
                      : const AssetImage('assets/placeholder.png')
                          as ImageProvider,
                ),
                title: Text(doctor.fullName),
                subtitle: Text(doctor.specialization),
                trailing: IconButton(
                  icon: const Icon(Icons.favorite, color: Colors.red),
                  onPressed: () {
                    favoritesController.removeFavorite(doctor);
                  },
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
