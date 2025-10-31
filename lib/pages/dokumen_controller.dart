import 'package:get/get.dart';

class DokumenModel {
  String title;
  String bab;
  String description;
  String status; 
  String fileName;
  String date; 
  String catatanDosen;

  DokumenModel({
    required this.title,
    required this.bab,
    required this.description,
    required this.status,
    required this.fileName,
    required this.date, 
    this.catatanDosen = "",
  });
}

class DokumenController extends GetxController {
  var menungguList = <DokumenModel>[].obs;
  var revisiList = <DokumenModel>[].obs;
  var selesaiList = <DokumenModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    menungguList.add(DokumenModel(
      title: "BAB III Analisis",
      bab: "BAB III",
      description: "Baru dikirim untuk dicek",
      status: "Menunggu",
      fileName: "bab3.pdf",
      date: "2025-09-20 20:00:00", 
    ));
    revisiList.add(DokumenModel(
      title: "BAB II Landasan Teori",
      bab: "BAB II",
      description: "Perlu perbaikan referensi",
      status: "Revisi",
      fileName: "bab2.pdf",
      date: "2025-09-19 19:00:00",
      catatanDosen: "Perbaiki referensi dan kutipan.",
    ));
    selesaiList.add(DokumenModel(
      title: "BAB I Pendahuluan",
      bab: "BAB I",
      description: "Sudah lengkap",
      status: "Selesai",
      fileName: "bab1.pdf",
      date: "2025-09-18 18:30:00",
    ));
  }

  void addDokumen(DokumenModel d) {
    if (d.status == "Menunggu") {
      menungguList.add(d);
    } else if (d.status == "Revisi") revisiList.add(d);
    else selesaiList.add(d);
  }

  void editDokumen(int index, DokumenModel d, String status) {
    menungguList.removeWhere((e) => e.title == d.title);
    revisiList.removeWhere((e) => e.title == d.title);
    selesaiList.removeWhere((e) => e.title == d.title);
    addDokumen(d);
  }

  void deleteDokumen(DokumenModel d) {
    menungguList.remove(d);
    revisiList.remove(d);
    selesaiList.remove(d);
  }
}
