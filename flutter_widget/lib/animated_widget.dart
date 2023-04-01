
import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';

class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({Key? key}) : super(key: key);

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> with TickerProviderStateMixin {
  late AnimationController animationController=AnimationController(duration:const Duration(seconds: 10),
      vsync: this)..repeat();
  late final AnimationController _animationController=AnimationController(vsync: this,duration: const Duration(seconds: 1));
  @override
  void dispose(){
    super.dispose();
    animationController.dispose();
    _animationController.dispose();

  }
  bool selected=false;
  bool _isPlay=false;
   bool _first=true;
  double _fontSize=60;
  Color _color=Colors.blue;
  bool _selected=false;
  bool _bool=false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  setState((){
                    selected=!selected;
                  });
                },
                child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.grey[900],
                  child: AnimatedAlign(
                   alignment: selected?Alignment.topRight:Alignment.bottomLeft,
                    duration: const Duration(seconds: 2),
                    curve: Curves.fastOutSlowIn,
                    child: const FlutterLogo(size: 60,),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              AnimatedBuilder(
                  animation: animationController,
                  child: const FlutterLogo(size: 60,),
                  builder: (context,child){
                    return Transform.rotate(angle:animationController.value * 2.0 * math.pi,
                      child: child,
                    );
                  }
              ),
              const SizedBox(height: 30,),
              InkWell(
                onTap: (){
                  if(_isPlay==false){
                    _animationController.forward();
                    _isPlay=true;


                  }
                  else{
                    _animationController.reverse();
                    _isPlay=false;


                  }
                },
                child: AnimatedIcon(icon: AnimatedIcons.play_pause,size: 100,
                progress: _animationController,
                ),
              ),
              const SizedBox(height: 20,),
              AnimatedDefaultTextStyle(
                  style: TextStyle(fontSize: _fontSize,color: _color,fontWeight: FontWeight.bold),
                  duration: const Duration(milliseconds: 300),
                  child: const Text("Flutter")
              ),
              TextButton(onPressed: (){



                setState((){
                  _fontSize=_first?90:60;
                  _color=_first?Colors.blue:Colors.red;
                  _first = !_first;
                });



              },
                  child: const Text("Switch")
              ),
              const SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  _selected=!_selected;
                  setState((){});
                },
                child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    width: _selected?200:100,
                  height: _selected?100:200,
                  color: _selected?Colors.blueGrey:Colors.grey[300],
                  alignment: _selected?Alignment.center:Alignment.topCenter,
                  curve: Curves.fastOutSlowIn,
                  child: const FlutterLogo(),

                ),
              ),
              const SizedBox(height: 20,),
              AnimatedCrossFade(
                  firstChild: Image.asset("image/1.jpg",width: double.infinity,),
                  secondChild:Image.asset("image/2.jpg",width: double.infinity,),
                  crossFadeState: _bool?CrossFadeState.showFirst:CrossFadeState.showSecond,
                  duration: const Duration(seconds: 1),
              ),
              TextButton(onPressed: (){
                _bool=!_bool;
                setState((){});
              }, child: const Text("Switch Images"))


            ],
          ),
        ),
      ),
    );
  }
}
