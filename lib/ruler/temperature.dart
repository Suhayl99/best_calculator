import 'package:best_calculator/ruler/ruler_utils.dart';
import 'package:flutter/material.dart';

import '../calculator/scale_widget.dart';

class Temperature extends StatefulWidget {
  const Temperature({Key? key}) : super(key: key);

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  final List<String> cityName = [
    "celsius/C",
    "kelvin/K",
    "fahrenheit/F",
  ];
  String? _value = "celsius/C";
  String count ="1";
final List<double> qiymat = [
    
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
                                "${e.split('/').first}\n${e.split('/').last}",
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
                          };
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
          unitElementTemperature("Celsius", "C", firstColor, count),
          unitElementTemperature("Kelvin", "K", firstColor, count),
            unitElementTemperature("fahrenheit", "F", secondColor, count),
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