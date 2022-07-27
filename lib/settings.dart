import 'package:best_calculator/calculator/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';

import 'about.dart';
import 'calculator/hive_utills.dart';
import 'homePage.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.label}) : super(key: key);
  final String label;
  
  @override
  State<SettingPage> createState() => _SettingPageState(label);
}

class _SettingPageState extends State<SettingPage> with HiveUtills  {
  _SettingPageState(this.label);
  String label;

   final controller= TextEditingController();
   bool isAccuracy =false;
   bool isSwipe = false;
   bool isAnimation = false;
   bool isScreen = false;
   bool isVibration = false;
   bool isBar = false;


  @override
  Widget build(BuildContext context) { 
 
   getListBox(isAnimation, isAccuracy, isBar, isVibration, isSwipe, isScreen);
    return Container(
      color: const Color(0xffC1C1C1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
       Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 40, left: 20),
        child: const Text("Change the text of the man screen", style: TextStyle(color: Colors.black87, fontSize: 12),)),
       Padding(
        padding: const EdgeInsets.only( left: 15, right: 10),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          SizedBox(
            width: 250,
            child: TextField(
              controller: controller,
                style: const TextStyle(
            fontSize: 12,
            color: Colors.black                  
            ), 
            decoration: InputDecoration(
              hintText: label,
              labelText: label,
               border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
            ),
            
          ),
          ),
         TextButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: controller.text)));
         }, 
         style:  ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), ),
         child: const Text("ok", style: TextStyle(color: Colors.black),),),
         ],),
       ),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  const [
       Text("Minimum accuracy        ", style:  TextStyle(color: Colors.black87, fontSize: 18),),
         Text("Limit minimum accuracy to 2 digits", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isAccuracy,
            onChanged: (value) { 
              setState(() {
                putBox<bool>(settingBox, accuracyKeyBox, value);
                isAccuracy = value;
                getListBox(isAnimation, isAccuracy, isBar, isVibration, isSwipe, isScreen);
              });

              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Swipe to count                   ", style:  TextStyle(color: Colors.black87, fontSize: 18),),
         Text("Swipe down the keyboard to calculate", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isSwipe,
            onChanged: (bool value) { 
              setState(() {
                putBox<bool>(settingBox, swipeKeyBox, value);
                  isSwipe = value;
              });

              }, 
            ),
          ],
         ),
),
    Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Disable text animation            ", style:  TextStyle(color: Colors.black87, fontSize: 18),),
         Text("Turn off text animation in the main section   ", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isAnimation,
            onChanged: (bool value) { 
              setState(() {
                putBox<bool>(settingBox, textKeyBox, value);
                isAnimation = value;
              });

              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Le tavehe screen on                      ", style:  TextStyle(color: Colors.black87, fontSize: 18),),
         Text("Disable sleep mode while the application is        \n running", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isScreen,
            onChanged: (bool value) { 
              setState(() {
                putBox<bool>(settingBox, screenKeyBox, value);
                isScreen = value;
                 if(isScreen){
                  Wakelock.enable();
                }else{
                  Wakelock.disable();
                }
              });

              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("turn off the vibration", style:  TextStyle(color: Colors.black87, fontSize: 18),),
         Text("", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isVibration,
            onChanged: (bool value) { 
              setState(() {
               putBox<bool>(settingBox, vibrationKeyBox, value);
               isVibration = value;
              });
              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:10),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("hide status bar", style:  TextStyle(color: Colors.black87, fontSize: 18),),
         Text("", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isBar,
            onChanged: (bool value) { 
              setState(() {
                putBox<bool>(settingBox, barKeyBox, value);
                isBar = value;
                if(isBar){
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                }else{
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
                }
              });

              }, 
            ),
          ],
         ),
),
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 20),
      child: TextButton.icon(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const About()));
      }, icon: const Icon(Icons.info) , label: const Text("About", style:TextStyle(color: Colors.black87, fontSize: 20) ,)),
    )
      ]),
    );
  }




 getListBox ( bool isAnimation, bool isAccuracy, bool isBar, bool isVibration, bool isSwipe, bool isScreen) async{
  if(await keyContaBox<bool>(settingBox, textKeyBox)){
    isAnimation = true;
  }else{
  isAnimation= await getBox(settingBox, textKeyBox);
  }

  if(await keyContaBox<bool>(settingBox, accuracyKeyBox)){
    isAccuracy = false;
}else{
   isAccuracy = (await getBox<bool>(settingBox, accuracyKeyBox))!;
}

  if(await keyContaBox<bool>(settingBox, barKeyBox)){
    isBar = false;
}else{
   isBar = (await getBox<bool>(settingBox, barKeyBox))!;
}
  if(await keyContaBox<bool>(settingBox, vibrationKeyBox)){
    isVibration = false;
}else{
   isVibration = (await getBox<bool>(settingBox, vibrationKeyBox))!;
}

  if(await keyContaBox<bool>(settingBox, swipeKeyBox)){
    isSwipe = false;
}else{
   isSwipe = (await getBox<bool>(settingBox, swipeKeyBox))!;
}

  if(await keyContaBox<bool>(settingBox, screenKeyBox)){
    isScreen = false;
}else{
   isScreen = (await getBox<bool>(settingBox, screenKeyBox))!;
}
}



}