import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// Routes dan binding global
import 'routes/app_pages.dart';
import 'bindings/app_binding.dart';

// Splash screen
import 'pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'INTA301',
      theme: ThemeData(
        primaryColor: const Color(0xFF88BDF2),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialBinding: AppBinding(), // Global binding

      // 👇 Ubah: pakai route SPLASH dari AppPages, bukan buat _Paths baru
      initialRoute: Routes.SPLASH, 

      // 👇 Gabungkan route dari AppPages + tambahkan Splash
     getPages: [
  GetPage(
    name: Routes.SPLASH, // pakai Routes, bukan _Paths
    page: () => const SplashPage(),
  ),
  ...AppPages.routes,
],

      // Dukungan lokal Indonesia
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
      ],
    );
  }
}
