import 'package:get/get.dart';

class DoctorMenuController extends GetxController {
  // Observable list of doctor menu items
  var doctorMenu = <DoctorMenu>[
    DoctorMenu(
        name: 'Consultation', image: 'lib/assets/svg/img-consultation.svg'),
    DoctorMenu(name: 'Dental', image: 'lib/assets/svg/img-dental.svg'),
    DoctorMenu(name: 'Heart', image: 'lib/assets/svg/img-heart.svg'),
    DoctorMenu(name: 'Hospitals', image: 'lib/assets/svg/img-hospital.svg'),
    DoctorMenu(name: 'Medicines', image: 'lib/assets/svg/img-medicine.svg'),
    DoctorMenu(name: 'Physician', image: 'lib/assets/svg/img-physician.svg'),
    DoctorMenu(name: 'Skin', image: 'lib/assets/svg/img-skin.svg'),
    DoctorMenu(name: 'Surgeon', image: 'lib/assets/svg/img-surgeon.svg'),
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Static data is provided, no need to fetch anything
  }
}

class DoctorMenu {
  final String name;
  final String image;

  DoctorMenu({required this.name, required this.image});
}
