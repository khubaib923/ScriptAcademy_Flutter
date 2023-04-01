import 'package:bigcart/widgets/checkout_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../state/state.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<double> subTotalList = [];
  double subTotalAmount = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    subTotalAmount = 0.0;
  }
  @override
  Widget build(BuildContext context) {
    double subTotal = subTotalAmount;
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    var myAppState = MyInheritedWidget.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Shopping Cart", style: TextStyle(
            color: Colors.black,
          fontFamily: "Poppins",
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20))),
        height: 250,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 17, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Subtotal",style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: Color(0xFF868889)
                  ),),
                  Text("\$${updatePrice(context)}", style: const TextStyle(
                    fontSize: 14,
                    fontFamily: "Poppins",
                    color: Color(0xFF868889)
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 17, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Shipping charges",style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: Color(0xFF868889)
                  ),),
                  Text("\$${shippingFee(context)}", style: const TextStyle(
                      fontSize: 14,
                      fontFamily: "Poppins",
                      color: Color(0xFF868889)
                  ),)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17, top: 20),
              child: Container(
                width: double.infinity,
                height: 2,
                color: Color(0xFFEBEBEB),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 17, right: 17),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Total",style: TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),),
                  Text("\$${updatePrice(context) + shippingFee(context)}", style: const TextStyle(
                      fontSize: 18,
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),)
                ],
              ),
            ),
            CheckOutButton()
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
            height: heightVariable,
            padding: const EdgeInsets.only(top: 10,bottom: 330, left: 10, right: 10),
            child: ListView.builder(
              itemCount: myAppState?.products?.length,
              itemBuilder: (context, index){
                return Slidable(
                  endActionPane: ActionPane(
                    key: ValueKey(index),
                    motion: StretchMotion(),
                    children: [
                      SlidableAction(
                        // An action can be bigger than the others.

                        onPressed: (context){
                          myAppState?.deleteCartItem(index);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("${myAppState?.products![index].title} is removed from cart"),
                          ));
                        },
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                      ),
                    ],
                  ),
                    child: _updateCartItems(context, index)
                );
              },
            ),
          )),
    );
  }
  Widget _updateCartItems(BuildContext context, int index){
    var myAppState = MyInheritedWidget.of(context);
    String startColor = "0xFF";
    double productPrice = (myAppState?.products![index].price)!;
    int productQuantity = (myAppState?.productCount![index])!;
    subTotalAmount += (productPrice * productQuantity);

    //myAppState?.updateSubTotal(productPrice * productQuantity);

    // if(!(myAppState?.addToCartOrNot![index])!){
    //   subTotalList.add(productPrice * productQuantity);
    //   print(subTotalList);
    // }
    return !(myAppState?.addToCartOrNot![index])!?Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
      child: Container(
        height: 115,
        child: ListTile(
          leading: CircleAvatar(
            maxRadius: 35,
            backgroundColor: Color(int.parse("$startColor${myAppState?.products![index].color?.substring(1)}")).withOpacity(0.2),
            child: Image.network(myAppState?.products![index].image ?? "")
          ),
          title: Container(
            height: 120,
            width: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$${myAppState?.products![index].price.toString() ?? ""} x ${myAppState?.productCount![index].toString()}",
                      style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "poppins",
                          color: Color(0xFF6CC51D)),
                    ),
                    Text(myAppState?.products![index].title ?? "",
                        style: const TextStyle(
                            fontSize: 16, fontFamily: "Poppins")),
                    Text(
                      myAppState?.products![index].unit ?? "",
                      style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "poppins",
                          color: Colors.grey),
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(onPressed: (){
                      setState(() {
                        myAppState?.productCount![index]++;
                      });
                    }, icon: const Icon(
                      Icons.add, color: Color(0xFF6CC51D),)),
                    Text(myAppState?.productCount![index].toString() ?? "", style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 12,
                    ),),
                    IconButton(onPressed: (){
                      if ((myAppState?.productCount![index])!>1){
                        setState(() {
                          myAppState?.productCount![index]--;
                        });
                      }
                    }, icon: const Icon(Icons.remove, color: Color(0xFF6CC51D),)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ): Container();
  }
  double updatePrice(BuildContext context){
    double subTotal = 0.0;
    var myAppState = MyInheritedWidget.of(context);
    for(int i=0; i<(myAppState?.products?.length)!; i++){
      if (myAppState?.addToCartOrNot![i] == false){
        subTotal += (myAppState?.products![i].price)! * (myAppState?.productCount![i])!;
      }
    }return subTotal;
  }
  double shippingFee(BuildContext context){
    double fee = 0.0;
    var myAppState = MyInheritedWidget.of(context);
    for(int i=0; i<(myAppState?.products?.length)!; i++){
      if (myAppState?.addToCartOrNot![i] == false){
        fee += 1 * (myAppState?.productCount![i])!;
      }
    }return fee;
  }
}
