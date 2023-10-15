import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Core/Const/app_const.dart';
import '../../Core/Const/image_const.dart';
import '../../Widgets/c_bounce.dart';
import '../../Widgets/c_button.dart';
import '../../Widgets/c_text.dart';
import '../Home/home_controller.dart';
import 'cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GetBuilder<CartController>(builder: (_) {
        return _.cartList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(20),
                child: SizedBox(
                    height: 50,
                    width: Get.width,
                    child: cButton(
                      'Place Order',
                      btnColor: Colors.green,
                      onTap: () {
                        Get.dialog(Dialog(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified,
                                  color: Colors.green,
                                  size: 60,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                ctext(
                                  'Order Successfully Placed',
                                  fontSize: 16,
                                ),
                              ],
                            ),
                          ),
                        )).then((value) {
                          HomeController _ = Get.find();
                          _.cart = {};
                          box.delete('productList');
                          _.update();
                          Get.back();
                        });
                      },
                    )),
              )
            : SizedBox();
      }),
      // persistentFooterButtons: [cButton('Place Order', btnColor: Colors.green)],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        title:
            ctext('Order Summary', fontSize: 16, fontWeight: FontWeight.w500),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12)),
                    child: GetBuilder<HomeController>(builder: (_) {
                      int totalDishes = 0;
                      _.cart.forEach(
                        (key, value) {
                          totalDishes += int.parse(value.toString());
                        },
                      );
                      return Center(
                        child: ctext(
                            '${_.cart.length} Dishes - $totalDishes Items',
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      );
                    }),
                  ),
                  GetBuilder<CartController>(builder: (_) {
                    return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: _.cartList.isNotEmpty
                            ? Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const ClampingScrollPhysics(),
                                    itemCount: _.cartList.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Image.asset(
                                                _.cartList[index].dishType == 2
                                                    ? IconConst.veg
                                                    : IconConst.nonVeg,
                                                height: 24,
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 6),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      ctext(
                                                          _.cartList[index]
                                                              .dishName
                                                              .toString(),
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                top: 2,
                                                                bottom: 6),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            ctext(
                                                                '${_.cartList[index].dishCalories} Calories')
                                                          ],
                                                        ),
                                                      ),
                                                      GetBuilder<
                                                              HomeController>(
                                                          builder: (c) {
                                                        int tmpCount = 0;
                                                        c.cart.forEach(
                                                            (key, value) {
                                                          key ==
                                                                  _
                                                                      .cartList[
                                                                          index]
                                                                      .dishId
                                                                      .toString()
                                                              ? tmpCount = value
                                                              : 0;
                                                        });
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 10),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            12)),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(6),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .min,
                                                                children: [
                                                                  cBounce(
                                                                      onPressed:
                                                                          () {
                                                                        HomeController
                                                                            c =
                                                                            Get.find();
                                                                        tmpCount >
                                                                                0
                                                                            ? tmpCount--
                                                                            : tmpCount =
                                                                                0;
                                                                        tmpCount >
                                                                                0
                                                                            ? c.cart.update(_.cartList[index].dishId,
                                                                                (value) => tmpCount,
                                                                                ifAbsent: () => tmpCount)
                                                                            : c.cart.remove(_.cartList[index].dishId);
                                                                        box.put(
                                                                            'productList',
                                                                            c.cart);
                                                                        c.update();
                                                                        _.updateValue();
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .remove,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                  Padding(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        horizontal:
                                                                            16),
                                                                    child: ctext(
                                                                        tmpCount
                                                                            .toString(),
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w600),
                                                                  ),
                                                                  cBounce(
                                                                      onPressed:
                                                                          () {
                                                                        HomeController
                                                                            c =
                                                                            Get.find();
                                                                        tmpCount++;
                                                                        c.cart.update(
                                                                            _.cartList[index].dishId,
                                                                            (value) => tmpCount,
                                                                            ifAbsent: () => tmpCount);
                                                                        box.put(
                                                                            'productList',
                                                                            c.cart);
                                                                        c.update();
                                                                        _.updateValue();
                                                                      },
                                                                      child:
                                                                          const Icon(
                                                                        Icons
                                                                            .add,
                                                                        color: Colors
                                                                            .white,
                                                                      )),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ctext(
                                                  '${_.cartList[index].dishCurrency} ${_.cartList[index].dishPrice}',
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            color: Colors.grey,
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      ctext('Total Amount',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: ctext(
                                            '${_.cartList[0].dishCurrency} ${_.totalAmount.toStringAsFixed(2)}',
                                            color: Colors.green,
                                            fontSize: 20),
                                      )
                                    ],
                                  )
                                ],
                              )
                            : SizedBox(
                                height: Get.height - 150,
                                child: Center(
                                    child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(IconConst.emptyCart),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    ctext('You Don\'t have anything to Eat'),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    cBounce(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: ctext('Add to cart',
                                          fontSize: 14, color: Colors.green),
                                    ),
                                  ],
                                )),
                              ));
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
