import 'package:flutter/material.dart';
import 'package:flutter_widget/animated_widget.dart';
import 'package:flutter_widget/bottom_navigation_bar.dart';
import 'package:flutter_widget/home_screen.dart';
import 'package:flutter_widget/shopping_cart/card_provider.dart';
import 'package:flutter_widget/shopping_cart/product_list.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ChangeNotifierProvider(
        create: (context)=>CardProvider(),
      child:  const MaterialApp(
          debugShowCheckedModeBanner: false,
          home:ProductListScreen()

      ),
    );
  }
}
