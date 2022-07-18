import 'package:flutter/material.dart';
import 'constants.dart';
import 'scale_widget.dart';
import 'package:flutter/services.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({Key? key}) : super(key: key);

  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
 final editController = TextEditingController();
  final resultController = TextEditingController();
  Color numClr = const Color(0xff32363F);
  Color actionsClmnnClr = const Color(0xFF1F2229);
  Color actionsClrText = const Color(0xFFFCA300);
  Color numTxtClr = Colors.white54;
  Color actRowClr = const Color(0xFF1F2229);
  Color resultClr =  Colors.black;
  Color lastAction = const Color(0xFF747477);
  double editFontSize = 64;
  double resultFontSize = 28;
  String expression = "";


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ListView(
        children: [

          TextButton.icon(onPressed: (){}, icon: const Icon(Icons.history), label: const Text("Calculator", style: TextStyle(fontSize: 20, fontStyle: FontStyle.normal, color: Color(0xffFCA300)), ),
),
          Container(
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
                    color: lastAction,
                    fontSize: editFontSize,
                  ),
                ),
              ),
              TextField(
                controller: editController,
                decoration: const InputDecoration(
                    hintText: "0",
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none),
                readOnly: true,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: resultClr,
                  fontSize: resultFontSize,
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
                  button(actRowClr, "xⁿ", actionsClrText),
                  button(actRowClr, "%", actionsClrText),
                  button(actRowClr, "÷", actionsClrText),
                  button(actionsClmnnClr, "⌫", actionsClrText),
                  button(numClr, "7", numTxtClr),
                  button(numClr, "8", numTxtClr),
                  button(numClr, "9", numTxtClr),
                  button(actionsClmnnClr, "x", actionsClrText),
                  button(numClr, "4", numTxtClr),
                  button(numClr, "5", numTxtClr),
                  button(numClr, "6", numTxtClr),
                  button(actionsClmnnClr, "-", actionsClrText),
                  button(numClr, "1", numTxtClr),
                  button(numClr, "2", numTxtClr),
                  button(numClr, "3", numTxtClr),
                  button(actionsClmnnClr, "+", actionsClrText),
                  button(numClr, ".", numTxtClr),
                  button(numClr, "0", numTxtClr),
                  button(numClr, "()", numTxtClr),
                  button(actionsClmnnClr, "=", actionsClrText),
                ],
              ),

      InkWell(
        onTap: (){
          Scaffold.of(context).showBottomSheet<void>(
            (BuildContext context) {
              return Container(
                height: size.height*0.58,
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
                  button(actRowClr, "RAD", numTxtClr),
                  button(actRowClr, "sin", numTxtClr),
                  button(actRowClr, "cos", numTxtClr),
                  button(actionsClmnnClr, "tan", white),
                  button(numClr, "π", numTxtClr),
                  button(numClr, "sinh", numTxtClr),
                  button(numClr, "cosh", numTxtClr),
                  button(actionsClmnnClr, "tanh", white),
                  button(numClr, "x¯¹", numTxtClr),
                  button(numClr, "x²", numTxtClr),
                  button(numClr, "x³", numTxtClr),
                  button(actionsClmnnClr, "exp", white),
                  button(numClr, "log", numTxtClr),
                  button(numClr, "ln", numTxtClr),
                  button(numClr, "e", numTxtClr),
                  button(actionsClmnnClr, "eⁿ", white),
                  button(numClr, "|x|", numTxtClr),
                  button(numClr, "√", numTxtClr),
                  button(numClr, "∛", numTxtClr),
                  button(actionsClmnnClr, "n!", white),
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: Container(
          width: double.infinity,
          height: 31,
          padding: const EdgeInsets.all(2),
          decoration: const BoxDecoration(color:  Color(0xffFCA300)),
          child: Image.asset("assets/buttomSheet.png", height: 15, width: 29, color: const Color(0xffFCA300),),
        ),
      ),
        ],
      ),
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

   btnOnClick(String text) {
    setState(() {
      if (text == "C") {
        resultController.text = '';
        editController.text = "";
      } else if (text == "+/-") {
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
        } catch (e) {
          editController.text = "EROR";
          resultController.text = '';
        }
        resultController.text = editController.text;
      } else {
        if (resultController.text == '0') {
          resultController.text = text;
        } else {
          resultController.text += text;
          var a = int.parse(text);
          //editController.text=resultat(resultController.text);
          if (0 <= a && a <= 9) {
            if (resultController.text.contains('+') ||
                resultController.text.contains('-') ||
                resultController.text.contains('÷') ||
                resultController.text.contains('x')) {
              if (resultController
                          .text[resultController.text.length - 2] !=
                      '+' ||
                  resultController
                          .text[resultController.text.length - 2] !=
                      '-' ||
                  resultController
                          .text[resultController.text.length - 2] !=
                      '÷' ||
                  resultController.text[resultController.text.length - 2] !=
                      '-' ||
                  resultController.text[resultController.text.length - 2] !=
                      'x') {
                editController.text = "";
                editController.text += resultat(resultController.text);
              } else {
                editController.text = 'EROR';
              }
            } else {
              editController.text += text;
            }
          }
        }
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
}

