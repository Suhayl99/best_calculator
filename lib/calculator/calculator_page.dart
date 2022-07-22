import 'dart:developer';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:best_calculator/calculator/calcule_model.dart';
import 'package:best_calculator/calculator/constants.dart';
import 'package:best_calculator/calculator/hive_utills.dart';
import 'package:best_calculator/change_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'scale_widget.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
   CalculatorPage({Key? key, required this.title}) : super(key: key);
  String title;
  @override
  State<CalculatorPage> createState() => _CalculatorPageState(title); 
}

class _CalculatorPageState extends State<CalculatorPage> with HiveUtills{
  _CalculatorPageState(this.title);

   final ValueNotifier< List<CalculateModel>> calculateList = ValueNotifier<List<CalculateModel>>([]);
  String title;
 final editController = TextEditingController();
  final resultController = TextEditingController();

  double editFontSize = 28;
  double resultFontSize = 64;
  String expression = "";


  
  

  getList() async{
     if(getAllBox<CalculateModel>(calculateBox).toString().isEmpty){
      calculateList.value=[];
    }else{
      calculateList.value= await getAllListBox<CalculateModel>(calculateBox);
    }
  }





  @override
  Widget build(BuildContext context) {
   getList();
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: curAppBarColor,
      ),
    );
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [
           Container(
                     color: curWorkSpaceColor,
                  padding: const EdgeInsets.only( top: 25, right: 10),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      colorizeAnimation(),
                      Align(
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: (() {
                            Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                color: curBgColor,
               height: size.height*0.9,
                child:Column(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("history", style: TextStyle(color: curActiveMenuColor, fontSize: 24),),
                        TextButton(onPressed: () { 
                            clearAllBox<CalculateModel>(calculateBox);
                            calculateList.value=[];
                         },
                        child: Text("🗑", style: TextStyle(color: curActiveMenuColor, fontSize: 32),)),
                      ],
                    ),
                   ValueListenableBuilder<List<CalculateModel>>( builder:(BuildContext context, List<CalculateModel> value, Widget? child){

                  return  Container(
                      decoration: BoxDecoration(border:  Border(top: BorderSide(color: curActiveMenuColor, width: 2))),
                      height: size.height*0.7,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child:ListView.builder(
                      itemCount: calculateList.value.length,
                      itemBuilder: (context, i) {

                      return Container(
                      decoration: BoxDecoration(border: Border(top: BorderSide(color: curActiveMenuColor, width: 1), bottom: BorderSide(color: curActiveMenuColor, width: 1), left: BorderSide(color: curActiveMenuColor, width: 1) , right: BorderSide(color: curActiveMenuColor, width: 1) ), ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(right: 5),
                        leading:   TextButton( onPressed: () {
                          setState(() {
                            print(calculateList.value);
                          deleteAtBox<CalculateModel>(calculateBox, i);
                          calculateList.value.removeAt(i);
                          });
                          },
                        child: Text("🗑", style: TextStyle(color: curActiveMenuColor, fontSize: 20),),),
                   title: Text("${calculateList.value[i].caculate}",style:TextStyle(color: firstColor, fontSize: 16) ),
                   subtitle: Text("${calculateList.value[i].result}",style:TextStyle(color: secondColor, fontSize: 18) ),
                   trailing:   Text("${calculateList.value[i].date}", style: TextStyle(color: curActiveMenuColor, fontSize: 12),),
                   ),
                    );
                   
                      },
                ),
                      
                    );
                     },
                    valueListenable: calculateList,
                    
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                              width: double.infinity,
                              height: 20,
                              padding: const EdgeInsets.all(5),
                              decoration:  BoxDecoration(color:  curActiveMenuColor),
                              child: Image.asset("assets/buttomSheet.png", color: curFirstColor ),
                            ),
                    )
                  
                ],
               )
              );
            },
          );
                          }),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: curWorkSpaceColor,
                              ),
                              child: const Icon(
                                Icons.history,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          
          Container(
            color: curWorkSpaceColor,
              height: size.height*0.18,
              alignment: Alignment.bottomRight,
                child: TextField(
                  controller: resultController,
                  decoration: const InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.black87),
                      border: InputBorder.none),
                  readOnly: true,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: curNumbersColor,
                    fontSize: resultFontSize
                  ),
                ),
              ),
              Container(
                 color: curWorkSpaceColor,
                child: TextField(
                  controller: editController,
                  decoration: const InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.black54),
                      border: InputBorder.none),
                  readOnly: true,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: curNumbersColor,
                    fontSize: editFontSize,
                  ),
                ),
              ),


           
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: size.height * 0.0016,
                crossAxisCount: 4,
                primary: false,
                children: [
                  button(curOperandsBgColor, "xⁿ", curOperandsColor),
                  button(curOperandsBgColor, "%", curOperandsColor),
                  button(curOperandsBgColor, "÷", curOperandsColor),
                  button(curOperandsBgColor, "⌫", curOperandsColor),
                  button(curNumbersBgColor, "7", curNumbersColor),
                  button(curNumbersBgColor, "8", curNumbersColor),
                  button(curNumbersBgColor, "9", curNumbersColor),
                  button(curOperandsBgColor, "x", curOperandsColor),
                  button(curNumbersBgColor, "4", curNumbersColor),
                  button(curNumbersBgColor, "5", curNumbersColor),
                  button(curNumbersBgColor, "6", curNumbersColor),
                  button(curOperandsBgColor, "-", curOperandsColor),
                  button(curNumbersBgColor, "1", curNumbersColor),
                  button(curNumbersBgColor, "2", curNumbersColor),
                  button(curNumbersBgColor, "3", curNumbersColor),
                  button(curOperandsBgColor, "+", curOperandsColor),
                  button(curNumbersBgColor, ".", curNumbersColor),
                  button(curNumbersBgColor, "0", curNumbersColor),
                  button(curNumbersBgColor, "( )", curNumbersColor),
                  button(curOperandsBgColor, "=", curOperandsColor),
                ],
              ),

      InkWell(
        onTap: (){
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                color: curBgColor,
                height: size.height*0.58,
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
                  button(curNumbersBgColor, "RAD", curNumbersColor),
                  button(curNumbersBgColor, "sin", curNumbersColor),
                  button(curNumbersBgColor, "cos", curNumbersColor),
                  button(curNumbersBgColor, "tan", curNumbersColor),
                  button(curNumbersBgColor, "π", curNumbersColor),
                  button(curNumbersBgColor, "sinh", curNumbersColor),
                  button(curNumbersBgColor, "cosh", curNumbersColor),
                  button(curNumbersBgColor, "tanh", curNumbersColor),
                  button(curNumbersBgColor, "x¯¹", curNumbersColor),
                  button(curNumbersBgColor, "x²", curNumbersColor),
                  button(curNumbersBgColor, "x³", curNumbersColor),
                  button(curNumbersBgColor, "exp", curNumbersColor),
                  button(curNumbersBgColor, "log", curNumbersColor),
                  button(curNumbersBgColor, "ln", curNumbersColor),
                  button(curNumbersBgColor, "e", curNumbersColor),
                  button(curNumbersBgColor, "eⁿ", curNumbersColor),
                  button(curNumbersBgColor, "|x|", curNumbersColor),
                  button(curNumbersBgColor, "√", curNumbersColor),
                  button(curNumbersBgColor, "∛", curNumbersColor),
                  button(curNumbersBgColor, "n!", curNumbersColor),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          height: 20,
          padding: const EdgeInsets.all(5),
          decoration:  BoxDecoration(color:  curActiveMenuColor),
          child: Image.asset("assets/buttomSheet.png", color: curFirstColor,),
        ),
      ),
        ],
      ),
    );
  }

 Widget button(Color bgclr, String text, Color curNumbersColor) {
     Decoration activeDec = curCalcOperPadDec;
    if (text.contains(RegExp(r"[0-9]")) || text == "( )" || text == ".") {
      activeDec = curCalcNumPadDec;
    }
    return scaleWidget(
      onTap: () => btnOnClick(text),
      longTap: ()=>longClear(),
      scale: 0.7,
      child: Container(
        alignment: Alignment.center,
        decoration: activeDec,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: curNumbersColor,
          ),
        ),
      ),
    );
  }

   btnOnClick(String text) {
    setState(() {
      if(editController.text.length>15){
        editFontSize=11*editFontSize/editController.text.length+10;
      }
       if(resultController.text.length>10){
        resultFontSize=10*resultFontSize/resultController.text.length+5;
      }
      if (text.contains(RegExp(r"[0-9]"))) {
      resultController.text += text;
    }else if (text == "+/-") {
        editController.text =
            "${double.parse(resultat(resultController.text)) * (-1)}";
        resultController.text = editController.text;
      } else if (text == "%") {
        if (resultController.text.contains('+') ||
            resultController.text.contains('-') ||
            resultController.text.contains('÷') ||
            resultController.text.contains('x')) {
          double char = double.parse(resultController.text
              .replaceAll("+", "|")
              .replaceAll("-", "|")
              .replaceAll("x", "|")
              .replaceAll("÷", "|")
              .split("|")
              .last
              .toString());
          resultController.text =
              "${resultController.text.replaceAll("${char.toInt()}", "")}${char / 100}";
          editController.text =
              "${double.parse(resultat(resultController.text)) / 100}";
        } else {
          editController.text =
              "${double.parse(resultat(resultController.text)) / 100}";
          resultController.text = editController.text;
        }
      } else if (text == ".") {
        var isPoint = resultController.text.split('.').toList().length;
        if (isPoint == 2 && resultController.text.length == 1 ||
            isPoint == 2 &&
                (resultController.text[resultController.text.length - 1] !=
                        '+' ||
                    resultController.text[resultController.text.length - 1] !=
                        '-' ||
                    resultController.text[resultController.text.length - 1] !=
                        '÷' ||
                    resultController.text[resultController.text.length - 1] !=
                        '-' ||
                    resultController.text[resultController.text.length - 1] !=
                        'x')) {
          resultController.text += "0.";
          editController.text = resultat(resultat(resultController.text));
        }
        editController.text =
            "${double.parse(resultat(resultController.text))}";
      } else if (text == '⌫') {
        resultController.text = resultController.text
            .substring(0, resultController.text.length - 1);
        editController.text = resultat(resultController.text);
        if (resultController.text == "") {
          resultController.text = "";
          editController.text = '';
        }
        editController.text = resultat(resultController.text);
      } else if (text == "=") {
        try {
          editController.text = resultat(resultController.text);
           var model= CalculateModel(date: "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}", caculate: resultController.text, result:editController.text);
            calculateList.value.add(model);
            addBox<CalculateModel>(calculateBox, model);
        } catch (e) {
          editController.text = "EROR";
          resultController.text = '';
        }
        resultController.text = editController.text;
      }else if(text == "+" || text =="-" || text =="÷" || text =="x"){
        if(resultController.text.isEmpty || (resultController
                          .text[resultController.text.length - 1] !=
                      '+' &&
                  resultController
                          .text[resultController.text.length - 1] !=
                      '-' &&
                  resultController
                          .text[resultController.text.length - 1] !=
                      '÷' &&
                  resultController.text[resultController.text.length - 1] !=
                      '-' &&
                  resultController.text[resultController.text.length - 1] !=
                      'x') ){
           resultController.text+=text;   
            editController.text=resultat(resultController.text);
            
                    }
        }else if(text=="xⁿ"){
          resultController.text+=text;
          
        }
    });
  }

  String resultat(String text) {
    expression = resultController.text;
    expression = expression.replaceAll('÷', '/');
    expression = expression.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return "${exp.evaluate(EvaluationType.REAL, cm)}";

  }

    Widget colorizeAnimation() {
    var colorizeColors = [
      curWorkSpaceColor,
      curWorkSpaceColor,
      Colors.grey,
      curWorkSpaceColor,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 22,
    );

    return AnimatedTextKit(
      isRepeatingAnimation: true,
      pause: const Duration(seconds: 1),
      animatedTexts: [
        ColorizeAnimatedText(
          title,
          textStyle: colorizeTextStyle,
          colors: colorizeColors,
          textAlign: TextAlign.center,
          speed: const Duration(milliseconds: 1000),
        ),
      ],
      repeatForever: true,
    );
  }

  longClear(){
    resultController.text="";
    editController.text="";
      editFontSize = 28;
       resultFontSize = 64;
  }

}

