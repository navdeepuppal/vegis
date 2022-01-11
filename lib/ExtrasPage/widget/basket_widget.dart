import 'package:flutter/material.dart';
import 'package:kisaan/HomePage/OrderConfirmed.dart';
import 'package:kisaan/ExtrasPage/StyleScheme.dart';

class BasketWidget extends StatefulWidget {
  final int vtotalQuantity;
  final int vtotalPrice;
  final int ftotalQuantity;
  final int ftotalPrice;

  const BasketWidget({
    Key key,
    this.vtotalQuantity,
    this.vtotalPrice,
    this.ftotalQuantity,
    this.ftotalPrice,
  }) : super(key: key);

  @override
  _BasketWidgetState createState() => _BasketWidgetState();
}

class _BasketWidgetState extends State<BasketWidget> {
  get totalQuantity =>
      BasketWidget().vtotalQuantity + BasketWidget().ftotalQuantity;
  get totalPrice => BasketWidget().vtotalPrice + BasketWidget().ftotalPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(10),
      child: InkWell(
        onTap: () => OrderConfirmPage(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Your Basket",
                  style: headingStyle.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  "${totalQuantity} Items added",
                  style: contentStyle.copyWith(
                    color: Colors.white,
                    fontSize: 13,
                  ),
                )
              ],
            ),
            Text(
              "₹${totalPrice}",
              style: headingStyle.copyWith(
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
