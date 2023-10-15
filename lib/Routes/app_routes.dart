import 'package:get/get.dart';

import '../Core/Utils/intial_bindings.dart';
import '../Screens/Auth/auth_screen.dart';
import '../Screens/Cart/cart_controller.dart';
import '../Screens/Cart/cart_screen.dart';
import '../Screens/Home/home_controller.dart';
import '../Screens/Home/home_screen.dart';

class AppRoutes {
  static const String authScreen = "/authScreen";
  static const String homeScreen = "/homeScreen";
  static const String cartScreen = "/cartScreen";

  static List<GetPage> pages = [
    GetPage(
        name: authScreen,
        page: () => AuthScreen(),
        bindings: [InitialBindings()]),
    GetPage(
        name: homeScreen, page: () => HomeScreen(), bindings: [HomeBindings()]),
    GetPage(
        name: cartScreen, page: () => CartScreen(), bindings: [CartBindings()]),
  ];
}
