import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Const/app_const.dart';

Future<dynamic> fetchApi(
    {required String url,
    bool? get,
    Object? params,
    Function()? onSucess,
    bool errorLogShow = false}) async {
  try {
  log("API Calling ${AppConst.baseUrl + url} --> ${params.toString()}");
  var response = get == null
      ? await dio.post(
          AppConst.baseUrl + url,
          data: params,
        )
      : await dio.get(
          AppConst.baseUrl + url,
        );
  if (kDebugMode) {
    print(response.data.toString());
  }
  if (response.statusCode == 200) {
      log("Got Data Successfully");
      onSucess != null ? onSucess() : null;
      return response.data;
  } else {
    Get.showSnackbar(GetSnackBar(message: 'Didn\'t Get Data From API', backgroundColor: Colors.red,));
    if (kDebugMode) {
      print(response.data.toString());
    }
    log(response.toString());
    return null;
  }
  } catch (e) {
    errorLogShow ? Get.showSnackbar(GetSnackBar(message: e.toString(), backgroundColor: Colors.red,)) : null;
     log(e.toString());
  }
}