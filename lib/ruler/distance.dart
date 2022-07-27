import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/ruler/ruler_utils.dart';
import 'package:flutter/material.dart';
import '../calculator/scale_widget.dart';

class Dictance extends StatefulWidget {
  const Dictance({Key? key}) : super(key: key);

  @override
  State<Dictance> createState() => _DictanceState();
}

class _DictanceState extends State<Dictance> {
  final List<String> cityName = [
   "kilometer/km",
    "millimeter/mm",
    "centimeter/cm",
    "mile/mi",
    "yard/yd",
    "foot/ft",
    "inch/in",
    "nautical mile/nmi",
  ];
   final List<double> qiymat = [
    0.001, 1000, 100, 0.000621, 1.093613, 3.28084, 39.370079, 0.00054
   ];
  String? _value = "kilometer/km";
  String count ="1";
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
                      alignment: Alignment.center,
                      dropdownColor: curFirstColor,
                      iconDisabledColor: curActiveMenuColor,
                      value: _value,
                      items: cityName
                          .map(
                            (e) => DropdownMenuItem<String>(
                              value: e,
                              child:Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                   Text(
                                e.split('/').last,
                                style:  TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.normal, color:curFirstColor ),
                              ),
                               Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.only(bottom: 10),
                                 child: Text(
                                  e.split('/').first,
                                  style: TextStyle(
                                      fontSize: 16, fontWeight: FontWeight.normal, color: curSecondColor ),
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
                height: size.height*0.54,
                color: curBgColor,
                child: Center(
                  child:  GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: size.height * 0.00164,
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
      Expanded(
        flex: 6,
        child: ListView(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            unitElements("kilometer", "km", qiymat[0], curFirstColor, count, value1),
            unitElements("millimeter", "mm", qiymat[1], curSecondColor, count, value1),
            unitElements("centimeter", "cm", qiymat[2], curFirstColor,count, value1),
            unitElements("mile", "mi", qiymat[3], curSecondColor, count, value1),
            unitElements("yard", "yd", qiymat[4], curFirstColor, count, value1),
            unitElements("foot", "ft", qiymat[5], curSecondColor, count, value1),
            unitElements("inch", "in", qiymat[6], curFirstColor, count, value1),
            unitElements("nautical mile", "nmi", qiymat[7], curSecondColor,count, value1),
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
