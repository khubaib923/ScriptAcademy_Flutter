import 'dart:developer';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget/shopping_cart/card_model.dart';
import 'package:flutter_widget/shopping_cart/card_provider.dart';
import 'package:flutter_widget/shopping_cart/db_helper.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var discountedPrice;

  @override
  Widget build(BuildContext context) {
    final cardProvider = Provider.of<CardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Products"),
        centerTitle: true,
        actions: [
          Center(child: Consumer<CardProvider>(
            builder: (context, value, child) {
              return Badge(
                shape: BadgeShape.circle,
                badgeContent: Text(
                  value.getCounter().toString(),
                  style: const TextStyle(color: Colors.white),
                ),
                animationDuration: const Duration(milliseconds: 300),
                child: const Icon(Icons.shopping_bag_outlined),
              );
            },
          )),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            FutureBuilder(
                future: cardProvider.getData(),
                builder: (context, AsyncSnapshot<List<Cart>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                "image/empty-cart.png",
                                height: 150,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              const Text(
                                "Explore Products",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    else {
                      return Expanded(
                          child: ListView.builder(
                              itemCount: snapshot.requireData.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Image.network(
                                              snapshot.requireData[index].image,
                                              height: 100,
                                              width: 100,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        snapshot
                                                            .requireData[index]
                                                            .productName,
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      ),
                                                      InkWell(
                                                          onTap: () {
                                                            DbHelper.instance
                                                                .deleteItem(snapshot
                                                                    .requireData[
                                                                        index]
                                                                    .id);
                                                            cardProvider
                                                                .removeCounter();
                                                            cardProvider.removeTotalPrice(
                                                                double.parse(snapshot
                                                                    .requireData[
                                                                        index]
                                                                    .productPrice
                                                                    .toString()));
                                                          },
                                                          child: const Icon(
                                                              Icons.delete))
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                      "${snapshot.requireData[index].unitTag} \$${snapshot.requireData[index].productPrice}",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: InkWell(
                                                      onTap: () async {},
                                                      child: Container(
                                                        height: 35,
                                                        width: 100,
                                                        decoration: BoxDecoration(
                                                            color: Colors.green,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .requireData[
                                                                          index]
                                                                      .quantity;

                                                                  int price = snapshot
                                                                      .requireData[
                                                                          index]
                                                                      .initialPrice;
                                                                  quantity--;
                                                                  int newPrice =
                                                                      quantity *
                                                                          price;
                                                                  if (quantity >
                                                                      0) {
                                                                    DbHelper
                                                                        .instance
                                                                        .updateItem(
                                                                            Cart(
                                                                      id: snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .id,
                                                                      productId: snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      productName: snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .productName,
                                                                      initialPrice: snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .initialPrice,
                                                                      productPrice:
                                                                          newPrice,
                                                                      quantity:
                                                                          quantity,
                                                                      unitTag: snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .unitTag,
                                                                      image: snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .image,
                                                                    ))
                                                                        .then(
                                                                            (value) {
                                                                      newPrice =
                                                                          0;
                                                                      quantity =
                                                                          0;
                                                                      cardProvider.removeTotalPrice(double.parse(snapshot
                                                                          .requireData[
                                                                              index]
                                                                          .initialPrice
                                                                          .toString()));
                                                                    }).onError((error,
                                                                            stackTrace) {
                                                                      log(error
                                                                          .toString());
                                                                    });
                                                                  }
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.remove,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              Text(snapshot
                                                                  .requireData[
                                                                      index]
                                                                  .quantity
                                                                  .toString()),
                                                              InkWell(
                                                                onTap: () {
                                                                  int quantity = snapshot
                                                                      .requireData[
                                                                          index]
                                                                      .quantity;

                                                                  int price = snapshot
                                                                      .requireData[
                                                                          index]
                                                                      .initialPrice;
                                                                  quantity++;
                                                                  int newPrice =
                                                                      quantity *
                                                                          price;

                                                                  DbHelper
                                                                      .instance
                                                                      .updateItem(
                                                                          Cart(
                                                                    id: snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .id,
                                                                    productId: snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .id
                                                                        .toString(),
                                                                    productName: snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .productName,
                                                                    initialPrice: snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .initialPrice,
                                                                    productPrice:
                                                                        newPrice,
                                                                    quantity:
                                                                        quantity,
                                                                    unitTag: snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .unitTag,
                                                                    image: snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .image,
                                                                  ))
                                                                      .then(
                                                                          (value) {
                                                                    newPrice =
                                                                        0;
                                                                    quantity =
                                                                        0;
                                                                    cardProvider.addTotalPrice(double.parse(snapshot
                                                                        .requireData[
                                                                            index]
                                                                        .initialPrice
                                                                        .toString()));
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    log(error
                                                                        .toString());
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.add,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
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
                              }));
                    }
                  }
                  return const Center(
                    child: Text("No item"),
                  );
                }),
            Consumer<CardProvider>(
              builder: (context, value, child) {
                return Visibility(
                  visible: value.getTotalPrice().toStringAsFixed(2) == "0.00"
                      ? false
                      : true,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        ReusableWidget("Sub Total",
                            "\$${value.getTotalPrice().toStringAsFixed(2)}"),
                        ReusableWidget("Discount 50%",
                            "\$${(discountedPrice = (value.getTotalPrice() * (10 / 100))).toStringAsFixed(2)}"),
                        ReusableWidget("Total",
                            "\$${(value.getTotalPrice() - discountedPrice).toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ReusableWidget(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.subtitle2,
          ),
        ],
      ),
    );
  }
}
