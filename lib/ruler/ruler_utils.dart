
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
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          "${result*counts/value}",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}



  unitElementTemperature(String name, String shortName, Color color, String count, String value) {
  double counts = double.parse(count);
  double result=1;
    if(value=="celsius/C"){
      if(shortName=="K"){
        result=counts+273.15;
    }else {
      if(shortName=="F"){
      result = (counts*9/5)+32;
    }else{
      result = counts;
    }
    }}else  if(value=="kelvin/K"){
      if(shortName=="K"){
        result=counts;
    }else {
      if(shortName=="F"){
      result = (counts-273.15)*9/5+32;
    }else{
      result = counts-273.15;
    }
    }}else  if(value=="fahrenheit/F"){
      if(shortName=="K"){
        result=(counts-32)*5/9+273.15;
    }else {
      if(shortName=="F"){
      result = counts;
    }else{
      result = (counts-32)*5/9;
    }
    }}
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
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Text(
          "$result",
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}