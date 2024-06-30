import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:food_app/core/models/restaurant_model.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/utils/get_dimension.dart';
import 'package:food_app/widgets/custom_cached_image.dart';

class ShopCard extends StatefulWidget {
  final String image;
  final bool? isFav;
  final String name;
  final String price;
  final CategoryDishes foodItem;
  const ShopCard(
      {super.key,
      required this.image,
      this.isFav,
      required this.name,
      required this.price,
      required this.foodItem});

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    isFav = widget.isFav ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: screenWidth(context) * 0.5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomNetworkImage(
                imageName: widget.image,
                height: screenWidth(context) * 0.35,
                width: screenWidth(context) * 0.8,
              ),
              appSpaces.spaceForHeight5,
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: screenWidth(context) * 0.3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: appFont.f14w500Black,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          '₹ ${widget.price}',
                          style: appFont.f14w500Black,
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      BlocProvider.of<CartCubit>(context)
                          .addCarts(widget.foodItem);
                    },
                    child: Card(
                        color: appColors.brandDark,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4),
                          child: Text(
                            'Add',
                            style: appFont.f12w700White,
                          ),
                        )),
                  )
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
