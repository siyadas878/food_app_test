class RestaurantModel {
  String? restaurantId;
  List<TableMenuList>? tableMenuList;

  RestaurantModel({this.restaurantId, this.tableMenuList});

  RestaurantModel.fromJson(Map<String, dynamic> json) {
    restaurantId = json["restaurant_id"];
    tableMenuList = json["table_menu_list"] == null
        ? null
        : (json["table_menu_list"] as List)
            .map((e) => TableMenuList.fromJson(e))
            .toList();
  }

  static List<RestaurantModel> fromList(List<dynamic> list) {
    return list.map((map) => RestaurantModel.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["restaurant_id"] = restaurantId;
    if (tableMenuList != null) {
      _data["table_menu_list"] = tableMenuList?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  RestaurantModel copyWith({
    String? restaurantId,
    List<TableMenuList>? tableMenuList,
  }) =>
      RestaurantModel(
        restaurantId: restaurantId ?? this.restaurantId,
        tableMenuList: tableMenuList ?? this.tableMenuList,
      );
}

class TableMenuList {
  String? menuCategory;
  String? menuCategoryId;
  List<CategoryDishes>? categoryDishes;

  TableMenuList({this.menuCategory, this.menuCategoryId, this.categoryDishes});

  TableMenuList.fromJson(Map<String, dynamic> json) {
    menuCategory = json["menu_category"];
    menuCategoryId = json["menu_category_id"];
    categoryDishes = json["category_dishes"] == null
        ? null
        : (json["category_dishes"] as List)
            .map((e) => CategoryDishes.fromJson(e))
            .toList();
  }

  static List<TableMenuList> fromList(List<dynamic> list) {
    return list.map((map) => TableMenuList.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["menu_category"] = menuCategory;
    _data["menu_category_id"] = menuCategoryId;
    if (categoryDishes != null) {
      _data["category_dishes"] =
          categoryDishes?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  TableMenuList copyWith({
    String? menuCategory,
    String? menuCategoryId,
    List<CategoryDishes>? categoryDishes,
  }) =>
      TableMenuList(
        menuCategory: menuCategory ?? this.menuCategory,
        menuCategoryId: menuCategoryId ?? this.menuCategoryId,
        categoryDishes: categoryDishes ?? this.categoryDishes,
      );
}

class CategoryDishes {
  String? dishId;
  String? dishName;
  String? dishImage;
  String? dishDescription;
  String? nexturl;
  dynamic dishType;
  dynamic dishCalories;
  dynamic dishPrice;
  List<AddonCat>? addonCat;

  CategoryDishes(
      {this.dishId,
      this.dishName,
      this.dishImage,
      this.dishDescription,
      this.nexturl,
      this.dishType,
      this.dishCalories,
      this.dishPrice,
      this.addonCat});

  CategoryDishes.fromJson(Map<String, dynamic> json) {
    dishId = json["dish_id"];
    dishName = json["dish_name"];
    dishImage = json["dish_image"];
    dishDescription = json["dish_description"];
    nexturl = json["nexturl"];
    dishType = json["dish_Type"];
    dishCalories = json["dish_calories"];
    dishPrice = json["dish_price"];
    addonCat = json["addonCat"] == null
        ? null
        : (json["addonCat"] as List).map((e) => AddonCat.fromJson(e)).toList();
  }

  static List<CategoryDishes> fromList(List<dynamic> list) {
    return list.map((map) => CategoryDishes.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["dish_id"] = dishId;
    _data["dish_name"] = dishName;
    _data["dish_image"] = dishImage;
    _data["dish_description"] = dishDescription;
    _data["nexturl"] = nexturl;
    _data["dish_Type"] = dishType;
    _data["dish_calories"] = dishCalories;
    _data["dish_price"] = dishPrice;
    if (addonCat != null) {
      _data["addonCat"] = addonCat?.map((e) => e.toJson()).toList();
    }
    return _data;
  }

  CategoryDishes copyWith({
    String? dishId,
    String? dishName,
    String? dishImage,
    String? dishDescription,
    String? nexturl,
    dynamic dishType,
    dynamic dishCalories,
    dynamic dishPrice,
    List<AddonCat>? addonCat,
  }) =>
      CategoryDishes(
        dishId: dishId ?? this.dishId,
        dishName: dishName ?? this.dishName,
        dishImage: dishImage ?? this.dishImage,
        dishDescription: dishDescription ?? this.dishDescription,
        nexturl: nexturl ?? this.nexturl,
        dishType: dishType ?? this.dishType,
        dishCalories: dishCalories ?? this.dishCalories,
        dishPrice: dishPrice ?? this.dishPrice,
        addonCat: addonCat ?? this.addonCat,
      );
}

class AddonCat {
  String? addonCategory;

  AddonCat({this.addonCategory});

  AddonCat.fromJson(Map<String, dynamic> json) {
    addonCategory = json["addon_category"];
  }

  static List<AddonCat> fromList(List<dynamic> list) {
    return list.map((map) => AddonCat.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["addon_category"] = addonCategory;
    return _data;
  }

  AddonCat copyWith({
    String? addonCategory,
  }) =>
      AddonCat(
        addonCategory: addonCategory ?? this.addonCategory,
      );
}
