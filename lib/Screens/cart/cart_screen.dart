import 'package:flutter/material.dart';
import 'package:vender_machine/Model/machineProduct.dart';

import '../../common_widgets/app_button.dart';
import '../../widgets/chart_item_widget.dart';
import 'checkout_bottom_sheet.dart';
import 'column_with_seprator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              const Text(
                "طلباتي",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: getChildrenWithSeperator(
                  addToLastChild: false,
                  widgets: products.map((e) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25,
                      ),
                      width: double.maxFinite,
                      child: ChartItemWidget(
                        item: e,
                      ),
                    );
                  }).toList(),
                  seperator: const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              getCheckoutButton(context)
            ],
          ),
        ),
      ),
    );
  }

  Widget getCheckoutButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      child: AppButton(
        label: "تأكيد الطلب",
        fontWeight: FontWeight.w600,
        padding: const EdgeInsets.symmetric(vertical: 20),
        trailingWidget: getButtonPriceWidget(),
        onPressed: () {
          showBottomSheet(context);
        },
      ),
    );
  }

  Widget getButtonPriceWidget() {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xff489E67),
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        "\$12.96",
        style: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  void showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return const CheckoutBottomSheet();
        });
  }
}
