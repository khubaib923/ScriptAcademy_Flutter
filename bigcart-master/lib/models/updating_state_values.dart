import 'package:flutter/material.dart';
import '../state/state.dart';
import 'all_category_response.dart';
import 'all_product_response.dart';
import 'login_response.dart';

updatingUserDataToState(BuildContext context, UserData? userData){
  var myAppState = MyInheritedWidget.of(context);
  myAppState?.updateUserData(userData!);
}

updatingCategoriesToState(BuildContext context, List<AllCategoryData>? categories){
  var myAppState = MyInheritedWidget.of(context);
  myAppState?.updateCategory(categories!);
}

updatingProductsToState(BuildContext context, List<AllProductData>? products){
  var myAppState = MyInheritedWidget.of(context);
  myAppState?.updateProducts(products!);
}
