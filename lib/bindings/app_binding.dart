import 'package:get/get.dart';
import '../controllers/menu_controller.dart' as myCtrl;

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Lazy init controller saat pertama kali dipakai
    Get.lazyPut<myCtrl.MenuController>(() => myCtrl.MenuController());
  }
}
