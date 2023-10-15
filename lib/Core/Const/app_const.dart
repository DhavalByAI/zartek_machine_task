import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';

class AppConst {
  static const int bounceDuration = 200;
  static const String rupee = "₹";
  static const String baseUrl = "https://www.mocky.io/v2/";
}
final dio = Dio();
var box = Hive.box('myBox');
User? user = FirebaseAuth.instance.currentUser;
