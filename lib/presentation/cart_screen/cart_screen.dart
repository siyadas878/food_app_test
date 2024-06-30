import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/cart_cubit/cart_cubit.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/manager/space_manger.dart';
import 'package:food_app/presentation/home_screen/home_screen.dart';
import 'package:food_app/widgets/cart_card.dart';
import 'package:food_app/widgets/custom_button.dart';
import 'package:food_app/widgets/empty_text.dart';
import 'package:food_app/widgets/loading.dart';
import 'package:food_app/widgets/price_row.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).getCarts();
    super.initState();
  }

  var totalPrices = 0.0.obs;
  List<double> prices = [];
  List<int> quantity = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        elevation: 5,
        shadowColor: Colors.grey,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: appFont.f16w500White,
        ),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        buildWhen: (previous, current) => current is CartFetchingState,
        builder: (context, state) {
          if (state is CartLoadingState) {
            return const LoadingWidget();
          } else if (state is CartSuccessState) {
            return state.allCarts.isEmpty
                ? const EmptyText(title: 'Empty Cart')
                : ListView.separated(
                    itemBuilder: (context, index) {
                      quantity =
                          List.generate(state.allCarts.length, (index) => 1);

                      prices = List.generate(
                          state.allCarts.length,
                          (index) =>
                              (state.allCarts[index].dishPrice ?? 0.0) * 1.0);
                      if (index == state.allCarts.length - 1) {
                        Future.delayed(const Duration(seconds: 1))
                            .then((value) => _totalPrice());
                      }

                      return MyCartCard(
                          qtyCount: (qty) {
                            if (qty == 1) {
                              quantity[index] = quantity[index] + 1;
                              prices[index] = prices[index] +
                                  (state.allCarts[index].dishPrice ?? 0.0);
                            } else {
                              prices[index] = prices[index] -
                                  (state.allCarts[index].dishPrice ?? 0.0);
                              quantity[index] = quantity[index] - 1;
                            }
                            _totalPrice();
                          },
                          removeCart: () {
                            BlocProvider.of<CartCubit>(context).removeCarts(
                                state.allCarts[index].dishId ?? '', context);
                          },
                          selectedQty: '1',
                          imageUrl: state.allCarts[index].dishImage ?? '',
                          title: state.allCarts[index].dishName ?? '',
                          qty: '10',
                          price: state.allCarts[index].dishPrice.toString());
                    },
                    separatorBuilder: (context, index) =>
                        appSpaces.spaceForHeight10,
                    itemCount: state.allCarts.length);
          } else {
            return const ErrorShowingWidget();
          }
        },
      ),
      bottomSheet: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartSuccessState) {
            return Container(
                height: 180,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Colors.white,
                    border: Border.all(
                        color: Colors.grey.withOpacity(0.5), width: 2)),
                child: Column(
                  children: [
                    Obx(() {
                      return Column(
                        children: [
                          InvoiceRow(
                              title: 'Items Total',
                              price: totalPrices.value.toString()),
                          appSpaces.spaceForHeight5,
                          const InvoiceRow(title: 'GST', price: '10'),
                          appSpaces.spaceForHeight15,
                          InvoiceRow(
                              title: 'Grand Total',
                              price: '${totalPrices.value + 10}'),
                        ],
                      );
                    }),
                    const Spacer(),
                    CustomButton(
                        verticalPadding: 0,
                        onTap: () async {
                          Get.offNamed('/SuccessScreen');
                        },
                        maxWidth: true,
                        title: "Proceed to Payment")
                  ],
                ));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  _totalPrice() {
    totalPrices.value = 0.0;
    for (var element in prices) {
      totalPrices.value = totalPrices.value + element;
    }
  }
}
