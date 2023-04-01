import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';

final int userId=Random().nextInt(900000+100000);
Future main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Zego Live Streaming",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController=TextEditingController(text: Random().nextInt(900000+100000).toString());
    ButtonStyle buttonStyle= ElevatedButton.styleFrom(
        primary: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        )
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/livestream.svg"),
            const SizedBox(height: 20,),
            Text("Your UserId:$userId"),
            const Text("Please test with two or more devices"),
            const SizedBox(height: 30,),
            TextField(
              controller:textEditingController ,
              decoration: InputDecoration(
                  labelText: "Join or start a live by input an ID",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  )
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              jumpToLivePage(context: context, liveId: textEditingController.text, isHost: true);
            },style: buttonStyle, child: const Text("Start a live"),),
            const SizedBox(height: 16,),
            ElevatedButton(onPressed: (){
              jumpToLivePage(context: context, liveId: textEditingController.text, isHost: false);
            },style: buttonStyle, child: const Text("Join a live"),),





          ],
        ),
      ),

    );
  }

  jumpToLivePage({required BuildContext context,required String liveId,required bool isHost}){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>LiveScreen(liveId: liveId,isHost: isHost,)));

  }
}

class LiveScreen extends StatelessWidget {
  final int appId=int.parse(dotenv.get("ZEGO_APP_ID"));
  final String appSign=dotenv.get("ZEGO_APP_SIGN");
  final String liveId;
  final bool isHost;
  LiveScreen({Key? key,required this.liveId,this.isHost=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ZegoUIKitPrebuiltLiveStreaming(
          appID: appId,
          appSign: appSign,
          config: isHost?ZegoUIKitPrebuiltLiveStreamingConfig.host():ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
          liveID: liveId,
          userID: userId.toString(),
          userName:"user_$userId" ,

        ),
      ),
    );
  }
}


