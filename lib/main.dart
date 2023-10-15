import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'Core/Const/app_const.dart';
import 'Core/Utils/app_colors.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'Core/Utils/intial_bindings.dart';
import 'Routes/app_routes.dart';
import 'package:path_provider/path_provider.dart';

import 'Screens/Home/home_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDLXknWimvfgDYkdaoCUVHKy_stPazx2g4',
          appId: '1:270929007151:android:b746297b14553c02536cda',
          messagingSenderId: '',
          projectId: 'zartektask'));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final appDocumentDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  await Hive.openBox('myBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zartek Task',
      scrollBehavior: const ScrollBehavior()
          .copyWith(physics: const BouncingScrollPhysics()),
      theme: ThemeData(
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.fromSwatch(
                  backgroundColor: AppColors.scafflodBackground))
          .copyWith(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      initialBinding: user != null ? HomeBindings() : InitialBindings(),
      initialRoute: user != null ? AppRoutes.homeScreen : AppRoutes.authScreen,
      getPages: AppRoutes.pages,
    );
  }
}

// class AuthenticationPage extends StatelessWidget {
//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Firebase Authentication'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () async {
//                 User? user = await _auth.signInWithGoogle();
//                 _showMessage(user);
//               },
//               child: Text('Login With Google'),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 // Implement phone authentication logic
//                 // User? user = await _auth.signInWithMobile(phoneNumber);
//                 // _showMessage(user);
//               },
//               child: Text('Login With Mobile'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showMessage(User? user) {
//     String message = user != null ? 'Authentication Succeeded' : 'Authentication Failed';
//     // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
//   }
// }
