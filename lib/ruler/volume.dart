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
  ];
  String? _value = "cubic millimeter/mm³";
  String count = "1";
 final List<double> qiymat = [
      1000000000, 1000000, 1000, 1000000, 1000, 35.314725, 61023.844502, 264.172052, 1056.688209, 2113.376419, 33814.022702, 4226.752838, 67628.04504, 202884.136211, 219.9691157, 879.894413, 1759.633996, 35195.079728, 3519.503328, 56312.647821, 168947.457341, 270512.181615, 6.289811, 0.276, 8453.799983
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
                          "${e.split('/').first}\n(${e.split('/').last}) ",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffFCA300)),
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
              unitElements(
                  "cubic millimeter", "mm³", 1000000000,  firstColor, count, value1),
              unitElements(
                  "cubic santimeter", "cm³", 1000000, secondColor, count, value1),
              unitElements("cubic decimeter", "dm³",  1000,  firstColor, count, value1),
              unitElements("milliliter", "ml (cc)", 1000000, secondColor, count, value1),
              unitElements("liter", "L",  1000, firstColor, count, value1),
              unitElements("cubic foot", "ft³", 35.314725, secondColor, count, value1),
              unitElements("cubic inch", "in³", 61023.844502,  firstColor, count, value1),
              unitElements("(US) gallon", "gal (US)", 264.172052, secondColor, count, value1),
              unitElements(
                  "(US) quart", "qt lqd (US)", 1056.688209,  firstColor, count, value1),
              unitElements(
                  "(US) pint", "pt lqd (US)", 2113.376419,  secondColor, count, value1),
              unitElements("(US) ounce", "oz (US)", 33814.022702,  firstColor, count, value1),
              unitElements("(US) cup", "cup (US)", 4226.752838,  secondColor, count, value1),
              unitElements(
                  "(US) tablespoon", "tbsp (US)", 67628.04504, firstColor, count, value1),
              unitElements(
                  "(US) teaspoon", "tsp (US)", 202884.136211, secondColor, count, value1),
              unitElements("(UK) gallon", "gal (UK)",  219.9691157,  secondColor, count, value1),
              unitElements("(UK) quart", "qt (UK)", 879.894413, firstColor, count, value1),
              unitElements("(UK) pint", "pt (UK)", 1759.633996, secondColor, count, value1),
              unitElements("(UK) ounce", "oz (UK)",  35195.079728, firstColor, count, value1),
              unitElements("(UK) cup", "cup (UK)", 3519.503328, secondColor, count, value1),
              unitElements("(UK) tablespoon", "tbsp (UK)",  56312.647821, firstColor, count, value1),
              unitElements("(UK) teaspoon", "tsp (UK)", 168947.457341, secondColor, count, value1),
              unitElements("dram", "dr",  270512.181615, firstColor, count, value1),
              unitElements("barrel", "bbl",  6.289811, secondColor, count, value1),
              unitElements("cord", "cord", 0.276,  firstColor, count, value1),
              unitElements("gill", "gill", 8453.799983, secondColor, count, value1),
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
