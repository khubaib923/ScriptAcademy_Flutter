import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget/shopping_cart/card_model.dart';
import 'package:flutter_widget/shopping_cart/card_provider.dart';
import 'package:flutter_widget/shopping_cart/card_screen.dart';
import 'package:flutter_widget/shopping_cart/db_helper.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<String> productName = ['Mango' , 'Orange' , 'Grapes' , 'Banana' , 'Chery' , 'Peach','Mixed Fruit Basket',] ;
  List<String> productUnit = ['KG' , 'Dozen' , 'KG' , 'Dozen' , 'KG' , 'KG','KG',] ;
  List<int> productPrice = [10, 20 , 30 , 40 , 50, 60 , 70 ] ;
  List<String> productImage = [
    'https://image.shutterstock.com/image-photo/mango-isolated-on-white-background-600w-610892249.jpg' ,
    'https://image.shutterstock.com/image-photo/orange-fruit-slices-leaves-isolated-600w-1386912362.jpg' ,
    'https://image.shutterstock.com/image-photo/green-grape-leaves-isolated-on-600w-533487490.jpg' ,
    'https://media.istockphoto.com/photos/banana-picture-id1184345169?s=612x612' ,
    'https://media.istockphoto.com/photos/cherry-trio-with-stem-and-leaf-picture-id157428769?s=612x612' ,
    'https://media.istockphoto.com/photos/single-whole-peach-fruit-with-leaf-and-slice-isolated-on-white-picture-id1151868959?s=612x612' ,
    'https://media.istockphoto.com/photos/fruit-background-picture-id529664572?s=612x612' ,
  ] ;



  @override
  Widget build(BuildContext context) {
    final cardProvider=Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product List"),
        centerTitle: true,
        actions:  [
          Center(
            child: Consumer<CardProvider>(
              builder: (context,value,child){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const CardScreen()));
                  },
                  child: Badge(
                    shape: BadgeShape.circle,
                    badgeContent:  Text(value.getCounter().toString(),style: const TextStyle(color: Colors.white),),
                    animationDuration: const Duration(milliseconds: 300),
                    child: const Icon(Icons.shopping_bag_outlined),

                  ),
                );
              },
            )
          ),

          const SizedBox(width: 20,),
        ],
      ),
      body: Column(
        children: [
          Expanded(
              child:ListView.builder(
                  itemCount: productName.length,
                  itemBuilder: (context,index){
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Image.network(productImage[index],height: 100,width: 100,),
                             const SizedBox(width: 10,),
                             Expanded(
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Text(productName[index],style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                                   const SizedBox(height: 5,),
                                   Text("${productUnit[index ]} \$${productPrice[index]}",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500)),
                                   const SizedBox(height: 5,),
                                   Align(
                                     alignment: Alignment.centerRight,
                                     child: InkWell(
                                       onTap: ()async{
                                         try{
                                          await DbHelper.instance.insert(
                                               Cart(
                                                 id: index,
                                                 productId: index.toString(),
                                                 productName: productName[index],
                                                 initialPrice:productPrice[index],
                                                 productPrice: productPrice[index],
                                                 quantity: 1,
                                                 unitTag: productUnit[index],
                                                 image: productImage[index],
                                               )

                                           );
                                          cardProvider.addTotalPrice(double.parse(productPrice[index].toString()));
                                          cardProvider.addCounter();
                                           // log("Product added to the cart");
                                           // ignore: use_build_context_synchronously
                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product is added to the cart"),duration: Duration(seconds: 1),backgroundColor: Colors.green,));
                                         }
                                         catch(error){
                                           log(error.toString());
                                           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Product is already added in cart"),duration: Duration(seconds: 1),backgroundColor: Colors.red,));

                                         }

                                         //.onError((error, stackTrace){
                                         //   log(error.toString());
                                         // });



                                         

                                       },
                                       child: Container(
                                         height: 35,
                                         width: 100,
                                         decoration: BoxDecoration(color: Colors.green,
                                         borderRadius: BorderRadius.circular(5)
                                         ),
                                         child: const Center(child: Text("Add to cart",style: TextStyle(color: Colors.white),)),
                                       ),
                                     ),
                                   )
                                 ],
                               ),
                             )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              })

          )
        ],
      ),

    );
  }
}
