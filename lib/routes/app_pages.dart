import 'package:get/get.dart';
import 'package:inta301/pages/form_jadwal.dart';
import 'package:inta301/pages/home_page.dart';
import 'package:inta301/pages/notifikasi_page.dart';
import 'package:inta301/pages/pages.dart';
import 'package:inta301/pages/welcome_page.dart';
import 'package:inta301/pages/jadwal_pages.dart';
import 'package:inta301/pages/kanban_page.dart';
import 'package:inta301/pages/dokumen_page.dart';
import 'package:inta301/pages/profile_page.dart';

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
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfilePage(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiPage(),
    ),
    // === Form Jadwal Bimbingan ===
    GetPage(
      name: _Paths.FORM_JADWAL,
      page: () {
        // Ambil arguments dengan aman
        final args = Get.arguments as Map<String, dynamic>?;
        int jadwalId = args?["jadwalId"] ?? 0; // ✅ pastikan non-null

        return FormJadwalBimbinganPage(jadwalId: jadwalId);
      },
    ),
  ];
}
