import 'package:flutter/material.dart';
import '../state/state.dart';

class ProductDisplay extends StatefulWidget {

  @override
  _ProductDisplayState createState() => _ProductDisplayState();
}

class _ProductDisplayState extends State<ProductDisplay> {
  int counter = 1;
  bool addToCart = false;

  @override
  Widget build(BuildContext context) {
    var myAppState = MyInheritedWidget.of(context);
    double width = MediaQuery
        .of(context)
        .size
        .width / 2;
    double height = MediaQuery
        .of(context)
        .size
        .height / 3.1;

    return myAppState?.productTitle != "" ? Scaffold(
      backgroundColor: const Color(0xFFF4F5F9),
      appBar: AppBar(
        title: Text(myAppState?.productTitle ?? "",
          style: const TextStyle(color: Colors.black, fontFamily: "Poppins", fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: myAppState?.productByCategory != null ? Padding(
        padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
        child: GridView.builder(
            itemCount: myAppState?.productByCategory?.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: (width / height)
            ),
            itemBuilder: gridProductItems
        ),
      ) : const Center(child: Text("No product available")),
    ) : const Scaffold(
      backgroundColor: Color(0xFFF4F5F9),
      body: Center(child: Text("No Products Available"),
      ),
    );
  }

  Widget gridProductItems(BuildContext context, int index) {
    var myAppState = MyInheritedWidget.of(context);
    String startColor = "0xFF";
    return Stack(
      children: [
        Card(
          child: GridTile(
            footer: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: myAppState?.productByCategory![0].catId == 1?(myAppState?.addToCartOrNot![5]) == true ?addingToCart():cartCount(5)
                : (myAppState?.addToCartOrNot![index]) == true ?addingToCart():cartCount(index))
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 85,
                        width: 85,
                        child: CircleAvatar(
                          maxRadius: 20,
                          backgroundColor: Color(int.parse(
                              "$startColor${myAppState
                                  ?.productByCategory![index].color?.substring(
                                  1)}")).withOpacity(0.2),
                        ),
                      ),
                      Positioned(
                          top: 13,
                          child: SizedBox(
                              height: 80,
                              width: 80,
                              child: Image.network(myAppState
                                  ?.productByCategory![index].image ?? "")
                          )
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 8,),
                Text(
                  "\$${myAppState?.productByCategory![index].price.toString() ??
                      ""}", style: const TextStyle(
                    color: Color(0xFF6CC51D),
                    fontFamily: "Poppins",
                    fontSize: 13
                ),),
                Text(myAppState?.productByCategory![index].title ?? "",
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 15,
                      fontWeight: FontWeight.w600
                  ),),
                Text(myAppState?.productByCategory![index].unit ?? "",
                  style: const TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 13,
                      color: Color(0xFF868889)
                  ),),
              ],
            ),
          ),
        ),
        Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: (){
                if(!(myAppState?.addLikeOrNot![index])!) {
                  setState(() {
                    myAppState?.addLikeOrNot![index] = true;
                  });
                }
                else{
                  setState(() {
                    myAppState?.addLikeOrNot![index] = false;
                  });
                }
              },
              child: Image(
                color: (myAppState?.addLikeOrNot![index]) != true ?const Color(0xFFCACACE):Colors.red,
                image: const AssetImage("images/heart_customize.png"),
              ),
            )
        )
      ],
    );
  }

  Row addingToCart() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Image(image: AssetImage("images/cart_icon.png"),),
        SizedBox(width: 9,),
        Text("Add to cart", style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 14
        ),)
      ],
    );
  }
  Row cartCount(int index){
    var myAppState = MyInheritedWidget.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: (){
          if ((myAppState?.productCount![index])!>1){
            setState(() {
              myAppState?.productCount![index]--;
            });
          }
        }, icon: const Icon(Icons.remove, color: Color(0xFF6CC51D),)),
        Text((myAppState?.productCount![index]).toString(), style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
        ),),
        IconButton(onPressed: (){
          setState(() {
            myAppState?.productCount![index]++;
          });
        }, icon: const Icon(Icons.add, color: Color(0xFF6CC51D),)),
      ],
    );
  }
}
