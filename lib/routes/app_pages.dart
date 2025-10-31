import 'package:get/get.dart';
import 'package:inta301/pages/dokumen_controller.dart';
import 'package:inta301/pages/dokumen_page.dart';
import 'package:inta301/pages/form_jadwal.dart';
import 'package:inta301/pages/home_page.dart';
import 'package:inta301/pages/jadwal_pages.dart';
import 'package:inta301/pages/kanban_page.dart';
import 'package:inta301/pages/notifikasi_page.dart';
import 'package:inta301/pages/profile_page.dart';
import 'package:inta301/pages/welcome_page.dart';
import 'package:inta301/pages/kelola_akun_page.dart';
import 'package:inta301/pages/informasi_dospem_page.dart';
import 'package:inta301/pages/lengkapi_data_page.dart';
import 'package:inta301/pages/pilih_dosen_page.dart';
import 'package:inta301/pages/mahasiswa_controller.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomePage(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => const JadwalPage(),
    ),
    GetPage(
      name: _Paths.KANBAN,
      page: () => KanbanPage(),
    ),
    GetPage(
      name: _Paths.DOKUMEN,
      page: () => DokumenPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<DokumenController>(() => DokumenController());
      }),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiPage(),
    ),

    GetPage(
      name: _Paths.FORM_JADWAL,
      page: () {
        final args = Get.arguments as Map<String, dynamic>? ?? {};
        final jadwalId = args["jadwalId"] ?? 0;
        final mode = args["mode"] ?? "mahasiswa";
        return FormJadwalBimbinganPage(
          jadwalId: jadwalId,
          mode: mode,
        );
      },
    ),

    GetPage(
      name: _Paths.KELOLA_AKUN,
      page: () => const KelolaAkunPage(),
    ),
    GetPage(
      name: _Paths.INFORMASI_DOSPEM,
      page: () => const InformasiDospemPage(),
    ),

    GetPage(
      name: _Paths.LENGKAPI_DATA,
      page: () => LengkapiDataPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<MahasiswaController>(() => MahasiswaController());
      }),
    ),
    GetPage(
      name: _Paths.PILIH_DOSEN,
      page: () => PilihDosenPage(),
    ),
  ];
}
