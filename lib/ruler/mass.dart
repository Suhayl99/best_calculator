import 'package:best_calculator/ruler/ruler_utils.dart';
import 'package:flutter/material.dart';

import '../calculator/scale_widget.dart';

class Mass extends StatefulWidget {
  const Mass({Key? key}) : super(key: key);

  @override
  State<Mass> createState() => _MassState();
}

class _MassState extends State<Mass> {
  final List<String> cityName = [
   "milligram/mg",
    "gram/g",
    "ton/t",
    "long ton/ton(UK)",
    "short ton/ton(US)",
    "pound/lb",
    "ounce/ounce",
    "stone/st",
    "carat/ct"
  ];
  String? _value = "milligram/mg";
    String count ="1";
 final List<double> qiymat = [
  1000000, 1000, 0.001, 0.000984, 0.0011, 2.204622, 35.273991, 0.157, 5000
   ];
  double? sizeText=48;
  double value1=1;

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
     return Column(
    children: [
       Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      dropdownColor: firstColor,
                      iconDisabledColor: const Color(0xffFCA300),
                      value: _value,
                      items: cityName
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child: Text(
                                "${e.split('/').first}\n(${e.split('/').first}) ",
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold, color:Color(0xffFCA300) ),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (item) {
                        setState(() {
                           _value = item;
                          if(cityName.contains(_value)){
                              value1=qiymat[cityName.indexOf(_value!)];
                          }
                        });
                      },
                    ),
                   InkWell(
        onTap: (){
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                height: size.height*0.44,
                color: Colors.amber,
                child: Center(
                  child:  GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: size.height * 0.0016,
                crossAxisCount: 4,
                primary: false,
                children: [
                 button(numClr, "7", numTxtClr),
                button(numClr, "8", numTxtClr),
                button(numClr, "9", numTxtClr),
                button(actionsClmnnClr, "⌫", actionsClrText),
                button(numClr, "4", numTxtClr),
                button(numClr, "5", numTxtClr),
                button(numClr, "6", numTxtClr),
                button(actionsClmnnClr, "OK", actionsClrText),
                button(numClr, "1", numTxtClr),
                button(numClr, "2", numTxtClr),
                button(numClr, "3", numTxtClr),
                button(actionsClmnnClr, "C", actionsClrText),
                button(numClr, ".", numTxtClr),
                button(numClr, "0", numTxtClr),
                button(numClr, "00", numTxtClr),
                 button(actionsClmnnClr, "▽", actionsClrText),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Expanded(child: Text(count, style:  TextStyle(color: const Color(0xffFCA300), fontSize: sizeText),)),
      ),
                  ],
                ),
        ),
      SizedBox(
        height: 450,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
             unitElements("milligram", "mg",  1000000, firstColor,count, value1),
            unitElements("gram", "g",  1000,  secondColor, count, value1),
            unitElements("ton", "t", 0.001, firstColor, count, value1),
            unitElements("long ton", "ton(UK)",  0.000984, secondColor, count, value1),
            unitElements("short ton", "ton(US)", 0.0011, firstColor, count, value1),
            unitElements("pound", "lb", 2.204622,  secondColor, count, value1),
            unitElements("ounce", "ounce", 35.273991, firstColor, count, value1),
            unitElements("stone", "st", 0.157,  secondColor, count, value1),
            unitElements("carat", "ct", 5000, firstColor, count, value1),
          ],
        ),
      ),
    ],
  );
  }
  Widget button(Color bgclr, String text, Color numTxtClr) {
    return scaleWidget(
      onTap: () => btnOnClick(text),
      scale: 0.7,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgclr,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: numTxtClr,
          ),
        ),
      ),
    );
  }

    String countText="";
  btnOnClick(String text) {
    setState(() {
      if (text == "C") {
         count="1";
         countText="";
      } else if (text == "⌫"){
        if (count.length<2) {
        count = "1";
         countText="";
        } else {
          count=countText;
        }
      }else if (text == "▽"){
        count="1";
        Navigator.pop(context);
      } else if (text == "OK") {
        Navigator.pop(context);
      }else if(text == "."){
        var isPoint = countText.split('.').toList().length;
        if (isPoint == 2 || countText.length >1) {
          countText += ".";
          count=countText;
        }else{
          count="1";
          countText+="0.";
          count=countText;
        }
      }else{
        countText+=text;
        count=countText;
      }

      if(count.length>4){
        sizeText=4*sizeText!/count.length;
      }
    });
  }
}