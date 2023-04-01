import 'package:flutter/material.dart';

class AnimationScreen extends StatefulWidget {
  const AnimationScreen({Key? key}) : super(key: key);

  @override
  State<AnimationScreen> createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
   double _height=100;
    double _width=100;
    double _opacity=1.0;
    Color _color=Colors.blue;
    bool _crossFadeState=true;
    String title="Tap Button";
  void increaseSize(){
 _height<390?_height+=50:_height=100;
 _width<390?_width+=50:_width=100;

 setState((){

 });
  }
  void changeOpacity(){
    _opacity>0.1?_opacity-=0.1:_opacity=1.0;
    _opacity<0.3?_color=Colors.black:_color=Colors.blue;
    setState((){

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve:Curves.bounceOut ,
                  height: _height,
                  width: _width,
                  color: Colors.purple,
                  child: Center(
                    child: TextButton(
                      onPressed: (){
                        increaseSize();
                      },
                      child: const Text("Tap to increase size",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
                    ),
                  ),

                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height*0.09,),
              Center(
                child: AnimatedOpacity(
                  duration:const  Duration(seconds: 1),
                  opacity: _opacity,
                  curve: Curves.bounceInOut,
                  child: Container(
                    height: 250,
                    width: 250,
                    color: Colors.lightBlueAccent,
                    child: TextButton(
                      onPressed: (){
                        changeOpacity();
                      },
                      child:  Text("Tap to Transparent",style: TextStyle(fontSize: 20,color: _color),),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              Stack(
                children: [
                  AnimatedCrossFade(
                    sizeCurve: Curves.bounceInOut,
                      firstChild: Container(
                        height: 350,
                        width: 350,
                        color: Colors.orange,
                      ),
                      secondChild:Container(
                        height: 150,
                        width: 150,
                        color: Colors.pinkAccent,
                      ),
                      crossFadeState:_crossFadeState? CrossFadeState.showFirst:CrossFadeState.showSecond,
                      duration: const Duration(seconds: 1)
                  ),
                  Positioned.fill(

                      child: TextButton(
                    child: const Text("Tap to Change",style: TextStyle(color: Colors.blue),),
                    onPressed: (){
                      setState((){
                        //_crossFadeState=!_crossFadeState;
                        _crossFadeState?_crossFadeState=false:_crossFadeState=true;
                      });
                    },
                  ))
                ],
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  setState((){
                    title="Click";
                  });
                },
                onDoubleTap: (){
                  setState((){
                    title="DoubleClick";
                  });
                },

                onTapDown: (details){
                  setState((){
                    title="Tap Down";
                  });
                },
                onTapUp: (details){
                  setState((){
                    title="Tap Up";
                  });
                },

                child: Container(
                  height: 250,
                  width: 250,
                  color: Colors.lightBlueAccent,
                  child: const Icon(Icons.account_circle,size: 50,),
                ),
              ),
              Text(title,style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

            ],
          ),
        ),
      ),
    );
  }
}
