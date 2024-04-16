import 'package:get/get.dart';
import 'package:weathershare/features/controllers/user_controller.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(() => UserController());
  }
}
