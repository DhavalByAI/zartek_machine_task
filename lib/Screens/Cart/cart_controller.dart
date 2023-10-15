import 'package:get/get.dart';
import '../Home/home_controller.dart';
import '../Home/home_model.dart';

class CartController extends GetxController {
  List<CategoryDishes> cartList = [];
  num totalAmount = 0;
  @override
  void onInit() {
    updateValue();
    super.onInit();
  }

  updateValue() {
    cartList.clear();
    totalAmount = 0;
    HomeController homeController = Get.find();
    homeController.data!.tableMenuList!.forEach((element) {
      element.categoryDishes!.forEach((e) {
        homeController.cart.forEach((key, value) {
          key == e.dishId ? cartList.add(e) : null;
          key == e.dishId ? totalAmount += (e.dishPrice! * value) : null;
        });
      });
    });
    update();
  }
}

class CartBindings extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => CartController());
  }
}
