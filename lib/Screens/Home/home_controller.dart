import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Core/Const/app_const.dart';
import '../../Core/Utils/fetch_api.dart';
import 'home_model.dart';

class HomeController extends GetxController {
  Products? data;
  int currIndex = 0;
  Map cart =
      box.containsKey('productList') ? (box.get('productList') as Map) : {};

  @override
  void onInit() {
    fetchApi(get: true, url: '5dfccffc310000efc8d2c1ad').then((value) {
      value != null ? data = Products.fromJson(value[0]) : null;
      update();
    });
    super.onInit();
  }
}

class HomeBindings extends Bindings {
  @override
  dependencies() {
    Get.lazyPut(() => HomeController());
  }
}
