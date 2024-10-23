import 'package:get/get.dart';
import 'package:doctorappointmenapp/models/doctor/gride_model.dart';

class FavoritesController extends GetxController {
  var favoriteDoctors = <DoctorModel>[].obs;  // Observable list of favorite doctors

  void addFavorite(DoctorModel doctor) {
    if (!favoriteDoctors.contains(doctor)) {
      favoriteDoctors.add(doctor);
    }
  }

  void removeFavorite(DoctorModel doctor) {
    favoriteDoctors.remove(doctor);
  }

  bool isFavorite(DoctorModel doctor) {
    return favoriteDoctors.contains(doctor);
  }
}
