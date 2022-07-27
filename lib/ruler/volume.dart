import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/ruler/ruler_utils.dart';
import 'package:flutter/material.dart';

import '../calculator/scale_widget.dart';

class Volume extends StatefulWidget {
  const Volume({Key? key}) : super(key: key);

  @override
  State<Volume> createState() => _VolumeState();
}

class _VolumeState extends State<Volume> {
  final List<String> cityName = [
    "cubic millimeter/mm³",
    "cubic santimeter/cm³",
    "cubic decimeter/dm³",
    "milliliter/ml (cc)",
    "cubic foot/ft³",
    "cubic inch/in³",
    "(US) gallon/gal (US)",
    "(US) quart/qt lqd (US)",
    "(US) pint/pt lqd (US)",
    "(US) ounce/oz (US)",
    "(US) cup/cup (US)",
    "(US) tablespoon/tbsp (US)",
    "(US) teaspoon/tsp (US)",
    "(UK) gallon/gal (UK)",
    "(UK) quart/qt (UK)",
    "(UK) pint/pt (UK)",
    "(UK) ounce/oz (UK)"
    "(UK) cup/cup (UK)",
    "(UK) tablespoon/tbsp (UK)",
    "(UK) teaspoon/tsp (UK)",
    "dram/dr",
    "barrel/bbl",
    "cord/cord",
    "gill/gill",
    "cubic meter/m³"
  ];
  String? _value = "cubic meter/m³";
  String count = "1";
 final List<double> qiymat = [
      1000000000, 1000000, 1000, 1000000, 1000, 35.314725, 61023.844502, 264.172052, 1056.688209, 2113.376419, 33814.022702, 4226.752838, 67628.04504, 202884.136211, 219.9691157, 879.894413, 1759.633996, 35195.079728, 3519.503328, 56312.647821, 168947.457341, 270512.181615, 6.289811, 0.276, 8453.799983, 1
   ];
  double? sizeText=48;
  double value1=1;

  @override
  Widget build(BuildContext context) {
     Size size = MediaQuery.of(context).size;
    return ListView(
      children: [
       Container(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
          child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      itemHeight: 70,
                      dropdownColor: curFirstColor,
                      iconDisabledColor: curActiveMenuColor,
                      value: _value,
                      items: cityName
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                   Text(
                                e.split('/').last,
                                style:  TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.normal, color:curFirstColor),
                              ),
                               Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(bottom: 10),
                                 child: Text(
                                  e.split('/').first,
                                  style:  TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.normal, color:curSecondColor),
                              ),
                               ),
                                ],
                              )
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
                color: curBgColor,
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
                 button(curAppBarColor, "7", curActiveMenuColor),
                button(curAppBarColor, "8", curActiveMenuColor),
                button(curAppBarColor, "9", curActiveMenuColor),
                button(curAppBarColor, "⌫", curActiveMenuColor),
                button(curAppBarColor, "4", curActiveMenuColor),
                button(curAppBarColor, "5", curActiveMenuColor),
                button(curAppBarColor, "6", curActiveMenuColor),
                button(curAppBarColor, "OK", curActiveMenuColor),
                button(curAppBarColor, "1", curActiveMenuColor),
                button(curAppBarColor, "2", curActiveMenuColor),
                button(curAppBarColor, "3", curActiveMenuColor),
                button(curAppBarColor, "C", curActiveMenuColor),
                button(curAppBarColor, ".", curActiveMenuColor),
                button(curAppBarColor, "0", curActiveMenuColor),
                button(curAppBarColor, "00", curActiveMenuColor),
                 button(curAppBarColor, "▽", curActiveMenuColor),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Expanded(child: Text(count, style:  TextStyle(color: curActiveMenuColor, fontSize: sizeText),)),
      ),

            ],
          ),
        ),
        SizedBox(
          height: 500,
          child: ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: [
              unitElements(
                  "cubic millimeter", "mm³", 1000000000,  curFirstColor, count, value1),
              unitElements(
                  "cubic santimeter", "cm³", 1000000, curSecondColor, count, value1),
              unitElements("cubic decimeter", "dm³",  1000,  curFirstColor, count, value1),
              unitElements("milliliter", "ml (cc)", 1000000, curSecondColor, count, value1),
              unitElements("liter", "L",  1000, curFirstColor, count, value1),
              unitElements("cubic foot", "ft³", 35.314725, curSecondColor, count, value1),
              unitElements("cubic inch", "in³", 61023.844502,  curFirstColor, count, value1),
              unitElements("(US) gallon", "gal (US)", 264.172052, curSecondColor, count, value1),
              unitElements(
                  "(US) quart", "qt lqd (US)", 1056.688209,  curFirstColor, count, value1),
              unitElements(
                  "(US) pint", "pt lqd (US)", 2113.376419,  curSecondColor, count, value1),
              unitElements("(US) ounce", "oz (US)", 33814.022702,  curFirstColor, count, value1),
              unitElements("(US) cup", "cup (US)", 4226.752838,  curSecondColor, count, value1),
              unitElements(
                  "(US) tablespoon", "tbsp (US)", 67628.04504, curFirstColor, count, value1),
              unitElements(
                  "(US) teaspoon", "tsp (US)", 202884.136211, curSecondColor, count, value1),
              unitElements("(UK) gallon", "gal (UK)",  219.9691157,  curFirstColor, count, value1),
              unitElements("(UK) quart", "qt (UK)", 879.894413, curSecondColor, count, value1),
              unitElements("(UK) pint", "pt (UK)", 1759.633996, curFirstColor, count, value1),
              unitElements("(UK) ounce", "oz (UK)",  35195.079728, curSecondColor, count, value1),
              unitElements("(UK) cup", "cup (UK)", 3519.503328, curFirstColor, count, value1),
              unitElements("(UK) tablespoon", "tbsp (UK)",  56312.647821, curSecondColor, count, value1),
              unitElements("(UK) teaspoon", "tsp (UK)", 168947.457341, curFirstColor, count, value1),
              unitElements("dram", "dr",  270512.181615, curSecondColor, count, value1),
              unitElements("barrel", "bbl",  6.289811, curFirstColor, count, value1),
              unitElements("cord", "cord", 0.276,  curSecondColor, count, value1),
              unitElements("gill", "gill", 8453.799983, curFirstColor, count, value1),
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
