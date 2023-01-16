import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vender_machine/Model/machineModel.dart';
import 'package:vender_machine/Model/machineProduct.dart';
import 'package:vender_machine/constants.dart';

import '../../widgets/grocery_item_card_widget.dart';
import '../../widgets/search_bar_widget.dart';
import '../product_details/product_details_screen.dart';
import 'grocery_featured_Item_widget.dart';
import 'home_banner_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key, this.barcodeMachine});
  String? barcodeMachine;

  @override
  Widget build(BuildContext context) {
    MachineModel? machine;
    if (barcodeMachine != null) {
      machine = machines.firstWhere((element) {
        return element.name == barcodeMachine;
      });
    }

    return Scaffold(
        body: barcodeMachine != null
            ? SafeArea(
                child: Container(
                  child: SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          // Image.asset("assets/images/login.png"),
                          const SizedBox(
                            height: 5,
                          ),
                          padded(locationWidget()),
                          const SizedBox(
                            height: 15,
                          ),
                          padded(const SearchBarWidget()),
                          const SizedBox(
                            height: 25,
                          ),
                          padded(HomeBanner()),
                          const SizedBox(
                            height: 25,
                          ),
                          padded(
                            const Text(
                              "الأصناف",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: kPrimaryColor),
                            ),
                          ),
                          // getHorizontalItemSlider(machines[0].productsList!,),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            height: 105,
                            child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.horizontal,
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                GroceryFeaturedCard(
                                  groceryFeaturedItems[0],
                                  color: const Color(0xffF8A44C),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GroceryFeaturedCard(
                                  groceryFeaturedItems[1],
                                  color: kPrimaryColor,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          getHorizontalItemSlider(machine!.productsList!),

                          // const SizedBox(
                          //   height: 15,
                          // ),
                          // getHorizontalItemSlider(
                          //   machines[1].productsList!,
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : const Center(
                child: Text(
                    'لا يوجد منتجات لعرضها .. امسح باركود الماكينة لعرض المنتجان'),
              ));
  }

  Widget padded(Widget widget) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: widget,
    );
  }

  Widget getHorizontalItemSlider(
    List<MachineProduct> items,
  ) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: items.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Get.to(ProductDetailsScreen(
                items[index],
              ));
            },
            child: GroceryItemCardWidget(
              item: items[index],
              heroSuffix: '$index +hero',
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 20,
          );
        },
      ),
    );
  }

  Widget locationWidget() {
    String locationIconPath = "assets/images/location_icon.svg";
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          locationIconPath,
        ),
        const SizedBox(
          width: 8,
        ),
        const Text(
          "المملكة العربية السعودية-أبها",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}