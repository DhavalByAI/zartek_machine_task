import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../Core/Const/app_const.dart';
import '../../Routes/app_routes.dart';
import '../../Widgets/c_text.dart';
import 'Widget/product_list.dart';
import 'home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _key = GlobalKey();

    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Scaffold(
            key: _key,
            drawer: Drawer(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    child: Center(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              user!.photoURL != null
                                  ? CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          NetworkImage(user!.photoURL!),
                                    )
                                  : const SizedBox(),
                              user!.displayName != null
                                  ? ctext('${user!.displayName}',
                                      textAlign: TextAlign.center,
                                      color: Colors.white)
                                  : const SizedBox(),
                              ctext('UID : ${user!.uid}',
                                  textAlign: TextAlign.center,
                                  color: Colors.white)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout),
                    title: const Text('Logout'),
                    onTap: () {
                      Get.offAllNamed(AppRoutes.authScreen);
                      FirebaseAuth.instance.signOut();
                      GoogleSignIn().signOut();
                      user = null;
                      box.clear();
                    },
                  ),
                ],
              ),
            ),
            body: _.data != null
                ? DefaultTabController(
                    length: _.data!.tableMenuList!.length,
                    child: Scaffold(
                      appBar: AppBar(
                        leading: IconButton(
                            onPressed: () {
                              _key.currentState!.openDrawer();
                            },
                            tooltip: 'Menu',
                            icon: const Icon(
                              Icons.menu,
                              color: Colors.black,
                            )),
                        actions: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.shopping_cart,
                                    color: Colors.black,
                                  ),
                                  tooltip: 'Open shopping cart',
                                  onPressed: () {
                                    Get.toNamed(AppRoutes.cartScreen);
                                  },
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 24, top: 4),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.redAccent,
                                      child: ctext(_.cart.length.toString(),
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        backgroundColor: Colors.white,
                        bottom: TabBar(
                          onTap: (value) {
                            _.currIndex = value;
                            _.update();
                          },
                          isScrollable: true,
                          indicatorColor: Colors.redAccent,
                          tabs: List.generate(
                              _.data!.tableMenuList!.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: ctext(
                                        _.data!.tableMenuList![index]
                                                .menuCategory ??
                                            'Unknwon',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: _.currIndex == index
                                            ? Colors.redAccent
                                            : Colors.black),
                                  )),
                        ),
                      ),
                      body: TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(
                              _.data!.tableMenuList!.length,
                              (index) => ProductList(
                                    listOfProducts: _.data!
                                        .tableMenuList![index].categoryDishes!,
                                  ))),
                    ))
                : const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
