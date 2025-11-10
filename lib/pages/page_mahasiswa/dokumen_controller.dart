import 'package:get/get.dart';

class DokumenModel {
  String title;
  String bab;
  String description;
  String status;
  String fileName;
  String date;
  String catatanDosen;
  String fileRevisi;

  DokumenModel({
    required this.title,
    required this.bab,
    required this.description,
    required this.status,
    required this.fileName,
    required this.date,
    this.catatanDosen = "",
    this.fileRevisi = "",
  });
}

class DokumenController extends GetxController {
  var menungguList = <DokumenModel>[].obs;
  var revisiList = <DokumenModel>[].obs;
  var selesaiList = <DokumenModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    // Data contoh
    menungguList.add(
      DokumenModel(
        title: "BAB III Analisis",
        bab: "BAB III",
        description: "Baru dikirim untuk dicek",
        status: "Menunggu",
        fileName: "bab3.pdf",
        date: "2025-09-20 20:00:00",
      ),
    );

    revisiList.add(
      DokumenModel(
        title: "BAB II Landasan Teori",
        bab: "BAB II",
        description: "Perlu perbaikan referensi",
        status: "Revisi",
        fileName: "bab2.pdf",
        date: "2025-09-19 19:00:00",
        catatanDosen: "Perbaiki referensi dan kutipan.",
        fileRevisi: "revisi_bab2.pdf",
      ),
    );

    selesaiList.add(
      DokumenModel(
        title: "BAB I Pendahuluan",
        bab: "BAB I",
        description: "Sudah lengkap",
        status: "Selesai",
        fileName: "bab1.pdf",
        date: "2025-09-18 18:30:00",
      ),
    );
  }

  /// Tambah dokumen ke list sesuai status
  void addDokumen(DokumenModel d) {
    switch (d.status) {
      case "Menunggu":
        menungguList.add(d);
        break;
      case "Revisi":
        revisiList.add(d);
        break;
      default:
        selesaiList.add(d);
    }
  }

  /// Edit dokumen (hapus versi lama berdasarkan title)
  void editDokumen(DokumenModel d) {
    menungguList.removeWhere((e) => e.title == d.title);
    revisiList.removeWhere((e) => e.title == d.title);
    selesaiList.removeWhere((e) => e.title == d.title);

    addDokumen(d);
  }

  /// Hapus dokumen dari semua list
  void deleteDokumen(DokumenModel d) {
    menungguList.remove(d);
    revisiList.remove(d);
    selesaiList.remove(d);
  }
}
