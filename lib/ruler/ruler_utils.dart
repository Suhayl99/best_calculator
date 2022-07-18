
import 'package:flutter/material.dart';

unitElements(String name, String shortName, double result, Color color, String count, double value) {
  double counts = double.parse(count);
  return Container(
    margin: const EdgeInsets.only(top: 1),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    color: color,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              shortName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          "${result*counts/value}",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}

Color firstColor = const Color(0xFF454545);
Color secondColor = const Color(0xFF555454);


  Color numClr = const Color(0xff32363F);
  Color actionsClmnnClr = const Color(0xFF1F2229);
  Color actionsClrText = const Color(0xFFFCA300);
  Color numTxtClr = Colors.white54;
  Color actRowClr = const Color(0xFF1F2229);
  Color resultClr = Colors.black;
  Color lastAction = const Color(0xFF747477);


  unitElementTemperature(String name, String shortName, Color color, String count) {
  double counts = double.parse(count);
  double result=1;
    if(shortName=="K"){
        result=counts+273.15;
    }else if(shortName=="F"){
      result = (counts*9/5)+32;
    }else{
      result = counts;
    }
  return Container(
    margin: const EdgeInsets.only(top: 1),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
    color: color,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            Text(
              shortName,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          "$result",
          style: const TextStyle(
            fontSize: 24,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}