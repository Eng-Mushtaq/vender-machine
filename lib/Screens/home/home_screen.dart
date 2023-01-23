import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:images_picker/images_picker.dart';
import 'package:provider/provider.dart';
import 'package:vender_machine/Model/machineModel.dart';
import 'package:vender_machine/Model/machineProduct.dart';
import 'package:vender_machine/constants.dart';
import 'package:vender_machine/providers/auth.dart';

import '../../providers/product.dart';
import '../../providers/products.dart';
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
    final data = Provider.of<Products>(context);
    final auth = Provider.of<Auth>(context);

    if (barcodeMachine != null) {}
    Size size = MediaQuery.of(context).size;
    var height = SizedBox(
      height: size.height * 0.015,
    );

    return Scaffold(
      body: barcodeMachine != null
          ? SafeArea(
              child: Container(
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        height,
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Image.asset("assets/images/login.png"),

                        padded(locationWidget()),
                        height,

                        padded(const SearchBarWidget()),
                        height,

                        padded(HomeBanner()), height,

                        padded(
                          const Text(
                            "الأصناف",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kPrimaryColor),
                          ),
                        ),

                        height,
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
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        // getHorizontalItemSlider(),
                        getHorizontalItemSlider(machines[0].productsList!),
                        // getHorizontalItemSlider(machine!.productsList!),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : const Center(
              child: Text(
                  'لا يوجد منتجات لعرضها .. امسح باركود الماكينة لعرض المنتجان'),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await auth.logOut();
          // data.fetchAndSetProducts();
        },
        // onPressed: (() => products.addProduct(
        //       MachineModel(
        //         id: '1',
        //         name: 'machine 1',
        //         status: 'active',
        //         productsList: [
        //           MachineProduct(
        //             id: 1,
        //             name: 'سنيكرز',
        //             description: 'شوكولاتة فاخرة بمعايير ',
        //             price: 3,
        //             imagePath: 'assets/images/snickers.png',
        //           ),
        //           // MachineProduct(
        //           //   id: 2,
        //           //   name: 'جلاكسي',
        //           //   description: 'شوكولاتة فاخرة بمعايير ',
        //           //   price: 2,
        //           //   imagePath: 'assets/images/galaxy.png',
        //           // ),
        //         ]
        //       ),
        //     )),
        child: const Icon(Icons.add),
      ),
    );
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
