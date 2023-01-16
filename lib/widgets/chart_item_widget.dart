import 'package:flutter/material.dart';
import 'package:vender_machine/Model/machineProduct.dart';

import '../common_widgets/app_text.dart';
import 'item_counter_widget.dart';

class ChartItemWidget extends StatefulWidget {
  const ChartItemWidget({Key? key, this.item}) : super(key: key);
  final MachineProduct? item;

  @override
  _ChartItemWidgetState createState() => _ChartItemWidgetState();
}

class _ChartItemWidgetState extends State<ChartItemWidget> {
  final double height = 110;

  final Color borderColor = const Color(0xffE2E2E2);

  final double borderRadius = 18;

  int amount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(
        vertical: 30,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            imageWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: widget.item!.name!,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 5,
                ),
                AppText(
                    text: widget.item!.description,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color:  const Color(0xff7C7C7C)),
                const SizedBox(
                  height: 12,
                ),
                const Spacer(),
                ItemCounterWidget(
                  onAmountChanged: (newAmount) {
                    setState(() {
                      amount = newAmount;
                    });
                  },
                )
              ],
            ),
            Column(
              children: [
                const Icon(
                  Icons.close,
                  color:  Color(0xff7C7C7C),
                  size: 25,
                ),
                const Spacer(
                  flex: 5,
                ),
                Container(
                  width: 70,
                  child: AppText(
                    text: "\$${getPrice().toStringAsFixed(2)}",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.right,
                  ),
                ),
                const Spacer(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget imageWidget() {
    return Container(
      width: 100,
      child: Image.asset(widget.item!.imagePath!),
    );
  }

  double getPrice() {
    return widget.item!.price! * amount;
  }
}
