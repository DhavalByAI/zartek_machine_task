import 'package:get/get.dart';
import '../../Screens/Auth/auth_controller.dart';

class InitialBindings extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
