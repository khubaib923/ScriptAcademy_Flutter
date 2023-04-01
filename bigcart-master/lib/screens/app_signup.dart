import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/all_category_response.dart';
import '../models/all_product_response.dart';
import '../models/signup_response.dart';
import '../models/updating_state_values.dart';
import '../state/state.dart';
import '../widgets/text_emailfield.dart';
import '../widgets/text_passwordfield.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:http/http.dart' as http;
import '../widgets/text_phonefield.dart';
import 'app_dashboard.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  //-- user data --
  SignUpUserData? userData;
  // -------------
  bool isLoading = false;
  String? error;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  List<AllCategoryData>? categories;
  List<AllProductData>? products;
  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
        child: Builder(
          builder: (childContext) {
            return Stack(
              children: [
                Container(
                  height: heightVariable * 0.6,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage("images/signup_pic.png")
                      )
                  ),
                ),
                Positioned(
                  top: 40,
                    child: IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30,),
                    )
                ),
                Positioned(
                    top: 45,
                    left: widthVariable*0.4,
                    child: const Text("Welcome",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins",
                          fontSize: 18
                      ),)
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
                    child: Container(
                      width: widthVariable,
                      height: heightVariable*0.52,
                      decoration: const BoxDecoration(
                          color: Color(0xFFF4F5F9)
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 20,left: 16),
                              child: Text("Create account", style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.bold
                              ),),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 16),
                              child: Text("Quickly create account", style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Poppins",
                                  color: Color(0xFF868889)
                              ),),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 26, left: 17, right: 17),
                              child: EmailField(controller: email, title: "Email Address"),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5, left: 17, right: 17),
                              child: PhoneField(controller: phoneNumber, title: "Contact Number"),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(top: 5, left: 17, right: 17),
                                child: PasswordField(controller: password, title: "Password")
                            ),
                            Padding(
                              padding: const EdgeInsets.all(17),
                              child: Container(
                                  height: 50,
                                  width: widthVariable,
                                  child: !isLoading? ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFF6CC51D)),
                                      shadowColor: MaterialStateProperty.all<Color>(Colors.white),
                                    ),
                                    onPressed: (){
                                      if(Form.of(childContext)?.validate() ?? false){
                                        signup();
                                      }
                                    },
                                    child: const Text(
                                      "Signup",style: TextStyle(
                                        fontSize: 22,
                                        fontFamily: "Poppins",
                                        color: Colors.white
                                    ),
                                    ),
                                  ): const Center(
                                    child: CircularProgressIndicator(),
                                  )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Already have an account?", style: TextStyle(
                                      fontSize: 15,
                                      color: Color(0xFF868889),
                                      fontFamily: "Poppins",
                                      fontWeight: FontWeight.w300
                                  ),),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.pop(context);
                                    },
                                    child: const Text(" Login", style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontFamily: "Poppins",
                                        fontWeight: FontWeight.bold
                                    ),),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }
        ),
      ),
    );
  }
  void signup()async{
    var url = Uri.parse('http://ishaqhassan.com:2000/user');
    setState(() {
      isLoading = true;
    });
    try{
      var response = await http.post(url, body: {
        'email': email.text,
        'phone': phoneNumber.text,
        'password': password.text});
      var responseJSON = SignUpResponse.fromJson(jsonDecode(response.body));
      setState(() {
        userData = responseJSON.data;
      });
      updatingUserSignUpDataToState(context);
      if(userData != null) {
        await getAllCategory(context);
        await getAllProducts(context);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> Dashboard()));
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

  Future<void> getAllCategory(BuildContext context)async{
    var url = Uri.parse('http://ishaqhassan.com:2000/category');
    var myAppState = MyInheritedWidget.of(context);
    setState(() {
      isLoading = true;
    });
    try{
      var response = await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userSignUpData?.accessToken}"});
      var responseJSON = AllCategoryResponse.fromJson(jsonDecode(response.body));

      setState(() {
        categories = responseJSON.data;
      });
      updatingCategoriesToState(context);

    }catch(e){
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getAllProducts(BuildContext context)async{
    var url = Uri.parse('http://ishaqhassan.com:2000/product');
    var myAppState = MyInheritedWidget.of(context);
    setState(() {
      isLoading = true;
    });
    try{
      var response = await http.get(url, headers: {"Authorization": "Bearer ${myAppState?.userSignUpData?.accessToken}"});
      var responseJSON = AllProductResponse.fromJson(jsonDecode(response.body));

      setState(() {
        products = responseJSON.data;
      });
      updatingProductsToState(context);

    }catch(e){
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }


  // updatingUserDataToState(BuildContext context){
  //   var myAppState = MyInheritedWidget.of(context);
  //   myAppState?.updateUserData(userData!);
  // }
  updatingUserSignUpDataToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateUserSignUpData(userData!);
  }
  updatingCategoriesToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateCategory(categories!);
  }
  updatingProductsToState(BuildContext context){
    var myAppState = MyInheritedWidget.of(context);
    myAppState?.updateProducts(products!);
  }
}
