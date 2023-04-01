import 'package:flutter/material.dart';
import 'package:flutter_widget/shopping_cart/card_model.dart';
import 'package:flutter_widget/shopping_cart/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardProvider with ChangeNotifier{
 int _counter=0;
  int get counter=>_counter;

 double _productPrice=0.0;
 double get productPrice=>_productPrice;

late Future<List<Cart>> _cart;

Future<List<Cart>> get cart=>_cart;

Future<List<Cart>> getData() async{

  _cart = DbHelper.instance.getCartList();
  return _cart;


}

   void _setPrefItems()async{
     SharedPreferences preferences=await SharedPreferences.getInstance();
     preferences.setInt("cart_item", _counter);
     preferences.setDouble("product_price", _productPrice);
     notifyListeners();


   }


   void _getPrefItems()async{
     SharedPreferences preferences=await SharedPreferences.getInstance();
     _counter=preferences.getInt("cart_item") ?? 0;
     _productPrice=preferences.getDouble("product_price") ?? 0;
     notifyListeners();

   }

   void addCounter(){
     _counter++;
     _setPrefItems();
     notifyListeners();
   }

   void removeCounter(){
     _counter--;
     _setPrefItems();
     notifyListeners();
   }

   int getCounter(){
     _getPrefItems();
     return _counter;
   }


   void addTotalPrice(double productPrice){
     _productPrice=_productPrice+productPrice;
     _setPrefItems();
     notifyListeners();

   }

   void removeTotalPrice(double productPrice){
     _productPrice=_productPrice-productPrice;
     _setPrefItems();
     notifyListeners();
   }

   double getTotalPrice(){
     _getPrefItems();
     return _productPrice;
   }
}