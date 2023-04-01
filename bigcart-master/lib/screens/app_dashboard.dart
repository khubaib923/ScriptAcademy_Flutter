import 'dart:convert';
import 'package:bigcart/models/logout_response.dart';
import 'package:collection/collection.dart';
import 'package:bigcart/models/all_category_response.dart';
import 'package:bigcart/models/signup_response.dart';
import 'package:bigcart/screens/app_cart.dart';
import 'package:bigcart/screens/products_display.dart';
import 'package:bigcart/state/state.dart';
import 'package:bigcart/widgets/drawer.dart';
import 'package:bigcart/widgets/search_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import '../models/all_product_response.dart';
import '../models/login_response.dart';

class Dashboard extends StatefulWidget {
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  TextEditingController searchField = TextEditingController();
  bool isLoading = false;
  bool addToCart = false;
  bool updateLike = false;
  int counter = 1;
  UserData? userData;
  SignUpUserData? signUpUserData;
  String? error;
  List<AllCategoryData>? categories;
  List<AllProductData>? cartProductsList = [];
  List<bool> cartOrNot = [true,true,true,true,true,true];
  List<bool> likeOrNot = [false,false,false,false,false,false];
  List<int> productCounts = [1,1,1,1,1,1];
  List<double>? subTotalPrice;
  List<AllProductData>? itemsOnSearch;
  List<AllProductData>? products;
  bool searching = false;

  final sliderImages = [
    "images/slider_1.png",
    "images/slider_2.jpg",
    "images/slider_3.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    var myAppState = MyInheritedWidget.of(context);
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white,Colors.white, Color(0xFFFAF6F6FF)])),
      child: Scaffold(
        drawer: Drawer(
          child: AppDrawer(),
        ),
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            updatingCartOrNotToState(context);
            updatingLikeOrNotToState(context);
            updatingProductCount(context);
            // final sumPrice = subTotalPrice!.sum;
            // myAppState?.updateSubTotal(sumPrice);
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=> CartScreen()));
          },
          backgroundColor: const Color(0xFF6CC51D),
          child: const Image(image: AssetImage("images/floating_cart.png"),),

        ),
        body: Column(
          //mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              // SearchField(controller: search, title: "Search Keywords.."),
              padding: const EdgeInsets.only(top: 41, left: 17, right: 17),
              child: TextFormField(
                onChanged: onSearch,
                  controller: searchField,
                  decoration: InputDecoration(
                      fillColor: Color(0xFFF4F5F9),
                      filled: true,
                      hintText: "Search Keywords...",
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: Icon(Icons.sort),
                      hintStyle: const TextStyle(
                          fontFamily: "Poppins"
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)))
              )
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 13),
                child: ListView(
                  children: [
                    //if(search.text.isEmpty)
                    if (!searching)
                    Stack(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 25),
                          child: Image(image: AssetImage("images/slider_1.png",),),
                        ),
                        Positioned(
                            top: 190,
                            left: 40,
                            child: Text("20% off on your\nfirst purchase", style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 20,
                                fontWeight: FontWeight.w600
                            ),)
                        )
                      ],
                    ),
                    !searching?Padding(
                      padding: const EdgeInsets.only(left: 16, top: 17, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Categories", style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600
                          ),),
                          Icon(Icons.arrow_forward_ios, color: Color(0xFF868889),)
                        ],
                      ),
                    ):Container(),
                    !searching?Padding(
                      padding: const EdgeInsets.only(top: 17),
                      child: SizedBox(
                        height: 100,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 10),
                          child: Row(
                            children: [
                              Expanded(
                                  child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: myAppState?.categories?.length,
                                      itemBuilder: categoryItem
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                    ):Container(),
                    !searching?Padding(
                      padding: const EdgeInsets.only(left: 16, top: 20, right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("Featured Products", style: TextStyle(
                              fontSize: 20,
                              fontFamily: "Poppins",
                              fontWeight: FontWeight.w600
                          ),),
                          Icon(Icons.arrow_forward_ios, color: Color(0xFF868889),)
                        ],
                      ),
                    ):Container(),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: SizedBox(
                        height: 320,
                        child: GridView.builder(
                          itemCount: myAppState?.products?.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: ((widthVariable/2)/(heightVariable/3.1)),
                                crossAxisCount: 2
                            ),
                            itemBuilder: gridProductItems
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),

      ),
    );
  }

  Widget categoryItem(BuildContext context, int index){
    var myAppState = MyInheritedWidget.of(context);
    String baseUrl = "http://ishaqhassan.com:2000/";
    String startColor = "0xFF";
    //int avatarColor = int.parse(myAppState.categories)
    return GestureDetector(
      onTap: ()async{
        await getProductByCategory(context, index+1);
        updatingCartOrNotToState(context);
        updatingLikeOrNotToState(context);
        updatingProductCount(context);
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=> ProductDisplay()));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 5),
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 32,
              backgroundColor: Color(int.parse("$startColor${myAppState?.categories![index].color?.substring(1)}")).withOpacity(0.2),
              child: CircleAvatar(
                maxRadius: 18,
                backgroundColor: Colors.transparent,
                child: Image.network("$baseUrl${myAppState?.categories![index].icon?.substring(28)}"),

              )
            ),
            const SizedBox(height: 11,),
            Text(myAppState?.categories![index].title ?? "", style: const TextStyle(
              fontFamily: "Poppins",
              fontSize: 12,
              color: Color(0xFF868889)
            ),)
          ],
        ),
      ),
    );
  }
  Widget gridProductItems(BuildContext context, int index){
    var myAppState = MyInheritedWidget.of(context);
    String startColor = "0xFF";
    return Stack(
      children: [
        Card(
          child: GridTile(
            footer: Container(
              child: InkResponse(
                onTap: (){
                  if(cartOrNot[index]){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${myAppState?.products![index].title} is added to cart!"),
                        ));
                  }
                  setState(() {
                    cartOrNot[index] = false;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: cartOrNot[index]?addingToCart() : cartCount(context,index)
                ),
              )
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
                         backgroundColor: Color(int.parse("$startColor${myAppState?.products![index].color?.substring(1)}")).withOpacity(0.2),
                       ),
                     ),
                     Positioned(
                       top: 13,
                         child: SizedBox(
                           height: 80,
                             width: 80,
                             child: Image.network(myAppState?.products![index].image ?? "")
                         )
                     )
                   ],
                 ),
               ),
                const SizedBox(height: 8,),
                Text("\$${myAppState?.products![index].price.toString() ??""}", style: const TextStyle(
                  color: Color(0xFF6CC51D),
                  fontFamily: "Poppins",
                  fontSize: 13
                ),),
                Text(myAppState?.products![index].title ?? "", style: const TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15,
                  fontWeight: FontWeight.w600
                ),),
                Text(myAppState?.products![index].unit ?? "", style: const TextStyle(
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
                if(!likeOrNot[index]) {
                  setState(() {
                    likeOrNot[index] = true;
                  });
                }
                else{
                  setState(() {
                    likeOrNot[index] = false;
                  });
                }
              },
              child: Image(
                color: !likeOrNot[index]? const Color(0xFFCACACE): Colors.red,
                image: const AssetImage("images/heart_customize.png"),
              ),
            )
        )
      ],
    );
  }
  Future<void> getProductByCategory(BuildContext context, int productID)async{
    var url = Uri.parse('http://ishaqhassan.com:2000/product/${productID}');
    var myAppState = MyInheritedWidget.of(context);
    setState(() {
      isLoading = true;
    });
    try{
      if(myAppState?.userData != null){
        var response = await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userData?.accessToken}"});
        var responseJSON = AllProductResponse.fromJson(jsonDecode(response.body));
        myAppState?.updateProductByCategory(responseJSON.data!);
      }else{
        var response = await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userSignUpData?.accessToken}"});
        var responseJSON = AllProductResponse.fromJson(jsonDecode(response.body));
        myAppState?.updateProductByCategory(responseJSON.data!);
      }
      if(productID==1){
        myAppState?.updateProductTitle("Vegetables");
      }
      else if(productID==2){
        myAppState?.updateProductTitle("Fruits");
      }else{
        myAppState?.updateProductTitle("");
      }

    }catch(e){
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }
  Row cartCount(BuildContext context, int index){
    var myAppState = MyInheritedWidget.of(context);
    subTotalPrice?.add((myAppState?.products![index].price)! * (myAppState?.productCount![index])!);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(onPressed: (){
          if (productCounts[index]>1){
            setState(() {
              productCounts[index]--;
            });
          }
        }, icon: const Icon(Icons.remove, color: Color(0xFF6CC51D),)),
        Text(productCounts[index].toString(), style: const TextStyle(
          fontFamily: "Poppins",
          fontSize: 15,
        ),),
        IconButton(onPressed: (){
          setState(() {
            productCounts[index]++;

          });
        }, icon: const Icon(Icons.add, color: Color(0xFF6CC51D),)),
      ],
    );
  }

  Row addingToCart(){
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
  updatingCartOrNotToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateAddCart(cartOrNot);
  }
  updatingLikeOrNotToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateLikeOrNot(likeOrNot);
  }
  updatingProductCount(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateProductCount(productCounts);
  }

  void onSearch(String search) {
    var myAppState = MyInheritedWidget.of(context);
    setState(() {
      if (searchField.text.isNotEmpty){
        searching = true;
      }else{
        searching = false;
      }
      for(var i=0; i<(myAppState?.products?.length)!; i++){
        if (search.toLowerCase() == myAppState?.products![i].title?.toLowerCase()){
          itemsOnSearch?.add((myAppState?.products![i])!);

        }
      }
      // itemsOnSearch = products?.where((element) =>
      // element.title!.toLowerCase().contains(search)
      // ).toList();
    });
  }
}
