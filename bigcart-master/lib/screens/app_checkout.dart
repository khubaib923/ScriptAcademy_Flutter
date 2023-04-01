import 'dart:convert';
import 'dart:io';

import 'package:bigcart/models/all_product_response.dart';
import 'package:bigcart/models/create_order_response.dart';
import 'package:bigcart/models/login_response.dart';
import 'package:bigcart/widgets/checkout_next_btn.dart';
import 'package:bigcart/widgets/checkout_text_fileds.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../state/state.dart';
import '../widgets/text_address.dart';
import '../widgets/text_city.dart';
import '../widgets/text_country.dart';
import '../widgets/text_emailfield.dart';
import '../widgets/text_namefield.dart';
import '../widgets/text_phonefield.dart';
import '../widgets/text_zipcode.dart';
import 'order_successfull.dart';

class CheckOutScreen extends StatefulWidget {
  @override
  _CheckOutScreenState createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  CreateOrderResponse? orderResponse;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController country = TextEditingController();
  bool isLoading = false;
  String? error;

  @override
  Widget build(BuildContext context) {
    double heightVariable = MediaQuery.of(context).size.height;
    double widthVariable = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: const Text(
          "CheckOut",
          style: TextStyle(
              color: Colors.black,
              fontFamily: "Poppins",
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          child: Builder(builder: (childContext) {
            return Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  NameField(controller: nameController, title: "Name"),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: EmailField(
                          controller: emailController,
                          title: "Email Address")),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: PhoneField(
                          controller: phoneNumber, title: "Phone Number")),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: AddressField(
                          controller: address, title: "Address")),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: ZipCodeField(
                          controller: zipCode, title: "Zip Code")),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child:
                          CityField(controller: city, title: "City")),
                  Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: CountryField(
                          controller: country, title: "Country")),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Container(
                        height: 50,
                        width: widthVariable,
                        child: !isLoading?ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                const Color(0xFF6CC51D)),
                            shadowColor: MaterialStateProperty.all<Color>(
                                Colors.white),
                          ),
                          onPressed: (){
                            if (Form.of(childContext)?.validate() ?? false) {
                              createOrderToServer();

                            }
                          },
                          child: const Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: "Poppins",
                                color: Colors.white),
                          ),
                        ):Center(
                          child: CircularProgressIndicator(),
                        )),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  void createOrderToServer() async {
    var myAppState = MyInheritedWidget.of(context);
    var url = Uri.parse('http://ishaqhassan.com:2000/order');
    setState(() {
      isLoading = true;
    });
    var listOfItems = <dynamic>[];
    var map = <String, dynamic>{};
    int index = 0;

    for (var product in (myAppState?.products)!){
      if(!(myAppState?.addToCartOrNot![index])!){
        map["id"] = product.id;
        map["catId"] = product.catId;
        map["title"] = product.title;
        map["unit"] = product.unit;
        map["stockAvailable"] = product.stockAvailable;
        map["image"] = product.image;
        map["color"] = product.color;
        map["price"] = product.price;
        map["qty"] = product.qty;
        listOfItems.add(map);
        index++;
      }
    }

    var body = <String, dynamic>{
      "name": nameController.text,
      "email": emailController.text,
      "phoneNumber": phoneNumber.text,
      "address": address.text,
      "zip": zipCode.text,
      "city": city.text,
      "country": country.text,
      "items": listOfItems,
    };


    // {"Authorization": "Bearer ${myAppState?.userData?.accessToken}"}

    try {
      http.Response response = await http.post(url,
          headers: {'Content-Type': 'application/json; charset=UTF-8',
          HttpHeaders.authorizationHeader: (myAppState?.userData?.accessToken)!},
          body: jsonEncode(body)
      );

      var responseJSON =
          CreateOrderResponse.fromJson(jsonDecode(response.body));
      setState(() {
        orderResponse = responseJSON;
      });
      if(orderResponse != null){
        print(orderResponse?.name);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => OrderSuccess()));
      }

      // ---- Having issue ----
      if (response.statusCode == 200){
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => OrderSuccess()));
      }else {
        print(response.reasonPhrase.toString());
      }
      // --------------------

    } catch (e) {
      setState(() {
        error = e.toString();
      });
    }
    setState(() {
      isLoading = false;
    });
  }
}
