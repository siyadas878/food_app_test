import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_app/core/cubit/restaurant_cubit/restaurant_cubit.dart';
import 'package:food_app/manager/color_manager.dart';
import 'package:food_app/manager/font_manager.dart';
import 'package:food_app/widgets/empty_text.dart';
import 'package:food_app/widgets/loading.dart';
import 'package:food_app/widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    BlocProvider.of<RestaurantCubit>(context).getAllRestaurant();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          elevation: 5,
          shadowColor: Colors.grey,
          centerTitle: true,
          title: Text(
            'Food App',
            style: appFont.f16w500White,
          ),
          bottom: TabBar(
            indicatorWeight: 7,
            controller: controller,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.yellow[50],
            automaticIndicatorColorAdjustment: true,
            indicatorColor: appColors.brandDark,
            labelPadding: const EdgeInsets.symmetric(vertical: 10),
            tabs: const [Text('Breakfast'), Text('Lunch')],
          ),
        ),
        body: TabBarView(
            controller: controller,
            children: List.generate(
              2,
              (tabIndex) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: BlocBuilder<RestaurantCubit, RestaurantState>(
                    buildWhen: (previous, current) =>
                        current is RestaurantListingFetchingState,
                    builder: (context, state) {
                      if (state is RestaurantListingLoadingState) {
                        return const LoadingWidget();
                      } else if (state is RestaurantListingSuccessState) {
                        var breakFast = state
                            .allRestaurants.tableMenuList![0].categoryDishes;
                        var lunch = state
                            .allRestaurants.tableMenuList![1].categoryDishes;
                        return breakFast!.isEmpty || lunch!.isEmpty
                            ? const EmptyText(title: 'Food Items Empty')
                            : GridView.builder(
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisExtent: 230,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 30,
                                  childAspectRatio: 1,
                                ),
                                itemCount: 7,
                                itemBuilder: (context, index) {
                                  return ShopCard(
                                    foodItem: tabIndex == 0
                                        ? breakFast[index]
                                        : lunch[index],
                                    name: tabIndex == 0
                                        ? breakFast[index].dishName ?? ''
                                        : lunch[index].dishName ?? '',
                                    price: tabIndex == 0
                                        ? breakFast[index].dishPrice.toString()
                                        : lunch[index].dishPrice.toString(),
                                    image: tabIndex == 0
                                        ? breakFast[index].dishImage ?? ''
                                        : lunch[index].dishImage ?? '',
                                  );
                                },
                              );
                      } else {
                        return const ErrorShowingWidget();
                      }
                    },
                  ),
                );
              },
            )),
      ),
    );
  }
}

class ErrorShowingWidget extends StatelessWidget {
  const ErrorShowingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Error',
        style: appFont.f14w500Orange,
      ),
    );
  }
}
