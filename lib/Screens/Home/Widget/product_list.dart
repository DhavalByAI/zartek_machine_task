import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../../../Core/Const/app_const.dart';
import '../../../Core/Const/image_const.dart';
import '../../../Core/Utils/app_colors.dart';
import '../../../Widgets/c_bounce.dart';
import '../../../Widgets/c_text.dart';
import '../home_controller.dart';
import '../home_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductList extends StatelessWidget {
  List<CategoryDishes> listOfProducts;
  ProductList({
    required this.listOfProducts,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                listOfProducts[index].dishType == 2
                    ? IconConst.veg
                    : IconConst.nonVeg,
                height: 24,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ctext(listOfProducts[index].dishName.toString(),
                          fontSize: 16, fontWeight: FontWeight.w600),
                      Padding(
                        padding: const EdgeInsets.only(top: 2, bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ctext(
                                '${listOfProducts[index].dishCurrency} ${listOfProducts[index].dishPrice}'),
                            ctext(
                                '${listOfProducts[index].dishCalories} Calories')
                          ],
                        ),
                      ),
                      ctext('${listOfProducts[index].dishDescription}',
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.subText),
                      GetBuilder<HomeController>(builder: (_) {
                        int tmpCount = 0;
                        _.cart.forEach((key, value) {
                          key == listOfProducts[index].dishId.toString()
                              ? tmpCount = value
                              : 0;
                        });
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  cBounce(
                                      onPressed: () {
                                        tmpCount > 0
                                            ? tmpCount--
                                            : tmpCount = 0;
                                        tmpCount > 0
                                            ? _.cart.update(
                                                listOfProducts[index].dishId,
                                                (value) => tmpCount,
                                                ifAbsent: () => tmpCount)
                                            : _.cart.remove(
                                                listOfProducts[index].dishId);
                                        box.put('productList', _.cart);
                                        _.update();
                                      },
                                      child: const Icon(
                                        Icons.remove,
                                        color: Colors.white,
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: ctext(tmpCount.toString(),
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  cBounce(
                                      onPressed: () {
                                        tmpCount++;
                                        _.cart.update(
                                            listOfProducts[index].dishId,
                                            (value) => tmpCount,
                                            ifAbsent: () => tmpCount);
                                        box.put('productList', _.cart);
                                        _.update();
                                      },
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                      listOfProducts[index].addonCat!.isNotEmpty
                          ? ctext('Customization Available*',
                              fontSize: 14, color: Colors.red)
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
              ),
              Card(
                child: CachedNetworkImage(
                  height: 75,
                  width: 75,
                  imageUrl: listOfProducts[index].dishImage.toString(),
                  placeholder: (context, url) =>
                      const CupertinoActivityIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.grey,
          height: 1,
        );
      },
      itemCount: listOfProducts.length,
    );
  }
}
