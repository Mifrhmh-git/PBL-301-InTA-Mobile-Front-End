part of 'app_pages.dart';

abstract class Routes {
  static const WELCOME = _Paths.WELCOME;
  static const HOME = _Paths.HOME;
  static const JADWAL = _Paths.JADWAL;
  static const KANBAN = _Paths.KANBAN;
  static const DOKUMEN = _Paths.DOKUMEN;
  static const PROFILE = _Paths.PROFILE;
  static const LOGIN = _Paths.LOGIN; 
  static const NOTIFIKASI = _Paths.NOTIFIKASI; 
}

abstract class _Paths {
  static const WELCOME = '/welcome';
  static const HOME = '/home';
  static const JADWAL = '/jadwal';
  static const KANBAN = '/kanban';
  static const DOKUMEN = '/dokumen';
  static const PROFILE = '/profile';
  static const LOGIN = '/login'; 
  static const NOTIFIKASI = '/notifikasi'; 
}

