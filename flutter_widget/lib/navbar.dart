import 'package:flutter/material.dart';
import 'package:flutter_widget/birthday.dart';
import 'package:flutter_widget/flight.dart';
import 'package:flutter_widget/holiday.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({Key? key}) : super(key: key);

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> with SingleTickerProviderStateMixin {
  TabController? tabController;


  @override
  void initState(){
    super.initState();
    tabController=TabController(length: 3, vsync:this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("Navbar"),
        bottom:  TabBar(
          controller: tabController,
          unselectedLabelColor: Colors.green,
          labelColor: Colors.red,
          tabs: const [
            Tab(
              icon: Icon(Icons.cake),
              text: "Birthday",
            ),
            Tab(
              icon: Icon(Icons.flight),
              text: "FLight",
            ),
            Tab(
              icon: Icon(Icons.holiday_village),
              text: "Holiday",
            )
          ],
        ),
      ),
      body: TabBarView(
            controller: tabController,
            children:const [
              BirthDayScreen(),
              FlightScreen(),
              HolidayScreen(),
            ]
        ),
      // bottomNavigationBar:  SafeArea(
      //   child: TabBar(
      //     controller: tabController,
      //     unselectedLabelColor: Colors.green,
      //     labelColor: Colors.red,
      //     tabs: const [
      //       Tab(
      //         icon: Icon(Icons.cake),
      //         text: "Birthday",
      //       ),
      //       Tab(
      //         icon: Icon(Icons.flight),
      //         text: "FLight",
      //       ),
      //       Tab(
      //         icon: Icon(Icons.holiday_village),
      //         text: "Holiday",
      //       )
      //     ],
      //   ),
      // ),

    );
  }
}
