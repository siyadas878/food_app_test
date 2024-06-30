import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/widgets/custom_button.dart';
import 'package:food_app/widgets/custom_cached_image.dart';

class MyCartCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String qty;
  final String price;
  final Function? onTap;
  final Function? removeCart;
  final String selectedQty;
  final Function(int) qtyCount;
  const MyCartCard({
    super.key,
    required this.qtyCount,
    required this.selectedQty,
    required this.imageUrl,
    required this.title,
    required this.qty,
    required this.price,
    required this.removeCart,
    this.onTap,
  });

  @override
  State<MyCartCard> createState() => _MyCartCardState();
}

class _MyCartCardState extends State<MyCartCard> {
  int quantity = 1;
  late int mainQuantity;

  @override
  void initState() {
    super.initState();
    quantity = int.parse(widget.selectedQty);
    mainQuantity = int.parse(widget.qty);
  }

  @override
  Widget build(BuildContext context) {
    double productPrice = double.parse(widget.price) * quantity;
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: CustomNetworkImage(
              width: 60,
              height: 60,
              imageName: widget.imageUrl,
            ),
            title: Text(
              widget.title,
              style: appFont.f14w500Black,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Qty :${quantity.toString()}",
                  style: appFont.f12w500Grey80,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "₹${productPrice.toString()}",
                  style: appFont.f14w500Black,
                ),
              ],
            ),
            trailing: int.parse(widget.qty) < 1 == true
                ? InkWell(
                    onTap: () {},
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Out of stock',
                          style: appFont.f14w500Black,
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    height: 100,
                    width: 150,
                    child: Column(
                      children: [
                        const Spacer(),
                        SizedBox(
                          height: 20,
                          width: 140,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MaterialButton(
                                onPressed: () {
                                  _handleRemove();
                                },
                                minWidth: 10,
                                padding: EdgeInsets.zero,
                                color: const Color(0xffE6E6E6),
                                child: const Icon(CupertinoIcons.minus),
                              ),
                              Text(
                                quantity.toString(),
                                style: appFont.f14w500Black,
                              ),
                              MaterialButton(
                                onPressed: () {
                                  _handleAdd();
                                },
                                color: appColors.brandDark,
                                padding: EdgeInsets.zero,
                                minWidth: 10,
                                child: const Icon(
                                  CupertinoIcons.add,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
          ),
          quantity == 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomButton(
                        buttonWidth: 100,
                        borderButton: true,
                        onTap: () {
                          _handleAdd();
                        },
                        title: "Cancel"),
                    const SizedBox(
                      width: 15,
                    ),
                    CustomButton(
                        buttonWidth: 150,
                        onTap: () {
                          widget.removeCart!();
                        },
                        title: "Yes,Remove"),
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  _handleAdd() {
    if (quantity < mainQuantity) {
      setState(() {
        quantity++;
        widget.qtyCount(1);
      });
    }
  }

  _handleRemove() {
    if (quantity - 1 >= 0) {
      setState(() {
        quantity--;
        widget.qtyCount(-1);
      });
    }
  }
}
