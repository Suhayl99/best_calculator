
import 'dart:math';
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
   final ValueNotifier<String> radDeg = ValueNotifier<String>("RAD");
  String title;
 final editController = TextEditingController();
  final resultController = TextEditingController();

  double editFontSize = 28;
  double resultFontSize = 64;
  String expression = "";
  final controller = ScrollController(); 
  

  getList() async{
     if(getAllBox<CalculateModel>(calculateBox).toString().isEmpty){
      calculateList.value=[];
    }else{
      calculateList.value= await getAllListBox<CalculateModel>(calculateBox);
    }
  }


 getTextAnumation() async{
  if(getBox<bool>(settingBox, textKeyBox).toString().isEmpty){
    checkText = false;
  }else{
  checkText= await getBox(settingBox, textKeyBox);
  }
}

  getAccuracy() async{
  if(getBox<bool>(settingBox, accuracyKeyBox).toString().isEmpty){
    return false;
}else{
    return (await getBox<bool>(settingBox, accuracyKeyBox))!;
}
}

 bool checkAccuracy =false;
 bool checkText = false; 
@override
  void initState() {
    super.initState();
  getAccuracy();
  getTextAnumation(); 
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
      body: Container(
        color: curWorkSpaceColor,
        child: Column(
          children: [
             Container(
                    padding: const EdgeInsets.only( top: 25, right: 10),
                    margin:const EdgeInsets.symmetric(vertical: 15),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        colorizeAnimation(checkText),
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
                  alignment: Alignment.bottomRight,
                  height: size.height*0.15,
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
                  padding: const EdgeInsets.symmetric(vertical: 5) ,
                  height: size.height*0.07,
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
             
                Container(
                  height: size.height*0.531,
                  color: Colors.white,
                  child: GridView.count(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisSpacing: 2,
                    scrollDirection: Axis.vertical,
                    mainAxisSpacing: 2,
                    controller: controller,
                    childAspectRatio: size.height * 0.00163,
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
                ),

        InkWell(
          onTap: (){
            Scaffold.of(context).showBottomSheet<void>(
              (BuildContext context) {
                return Container(
                  color: Colors.white,
                  height: size.height*0.56,
                  child:Column(
                    children: [
                      
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                                width: double.infinity,
                                height: 20,
                                padding: const EdgeInsets.all(5),
                                decoration:  BoxDecoration(color:  curActiveMenuColor),
                                child: Image.asset("assets/buttomSheet.png", color: curFirstColor),
                              ),
                      ),
                      ValueListenableBuilder<String>( builder:(BuildContext context, String value, Widget? child){
                      return  Center(
                    child:  GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                  childAspectRatio: size.height * 0.00156,
                  crossAxisCount: 4,
                  primary: false,
                  children: [
                    button(curNumbersBgColor, radDeg.value, curNumbersColor),
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
                  );
               },
               valueListenable: radDeg,
                      ),
                    ],
                  )
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
  int qavsL=0;
  int qavsR=0;
  int rad=0;
  String char="";
   btnOnClick(String text) {
    char+=text;
    setState(() {


      if(editController.text.length>3){
        editFontSize=editController.text.length*28/(editController.text.length+2);
      }else if(editController.text.length>8){
          editFontSize=24;
      }else{
        editFontSize=28;
      }
       if(resultController.text.length>10){
        resultFontSize= 64*resultController.text.length/(resultController.text.length+10);
      }else if(resultController.text.length>20){
          resultFontSize=20;
      }else {
        resultFontSize=64;
      }

      if (text.contains(RegExp(r"[0-9]"))) {
        if(char[char.length-2]=="="){
          editController.text="";
          resultController.text="";
          qavsL=0;
          qavsR=0;
          rad=0;
        }
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
          qavsL=0;
          qavsR=0;
          rad=0;
        }
      } else if (text =="=") {
          editController.text = resultat(resultController.text);
           var model= CalculateModel(date: "${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')} ${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')}", caculate: resultController.text, result:editController.text);
            calculateList.value.add(model);
            addBox<CalculateModel>(calculateBox, model);
             qavsL=0;
             qavsR=0;
              rad=0;
          resultController.text=editController.text;
           if(checkAccuracy){
            editController.text = double.parse(editController.text).toStringAsFixed(2);
      }
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
          resultController.text+="^";         
        }else if(text=="( )"){

          if(qavsL<=qavsR){
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="x(";
            }else{
            resultController.text+="(";
            }
            qavsL++;
          }else{
            resultController.text+=")";
            qavsR++;
          }
        }else if(text=="RAD" || text=="DEG"){
          rad++;
          if(rad%2==1){
            radDeg.value="DEG";
          }
          if(rad%2==0){
            radDeg.value="RAD";
          }
        }else if(text=="sin"){
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xsin(";
            }else{
            resultController.text+="sin(";
            }
          qavsL++;
        }else if(text == "cos"){
          qavsL++;
           if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xcos(";
            }else{
            resultController.text+="cos(";
            }
        }else if(text == "tan") {
          qavsL++;
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xtan(";
            }else{
            resultController.text+="tan(";
            }
        }else if(text =="π"){
          resultController.text+="π";
        }else if(text =="sinh"){
          qavsL++;
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]")) || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xasin(";
            }else{
            resultController.text+="asin(";
            }
        }else if(text=="cosh"){
          qavsL++;
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xacos(";
            }else{
            resultController.text+="acos(";
            }
        }else if(text=="tanh"){
          qavsL++;
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xatan(";
            }else{
            resultController.text+="atan(";
            }
        }else if(text=="x¯¹"){
            resultController.text+="1/";
        }else if(text=="x²"){
            resultController.text+="^2";
        }else if(text=="x³"){
          resultController.text+="^3";
        }else if(text=="exp"){
          qavsL++;
          resultController.text+="exp(";
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]")) || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xexp(";
            }else{
            resultController.text+="exp(";
            }
        }else if(text =="log"){
          resultController.text+="log(";
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xlog(";
            }else{
            resultController.text+="log(";
            }
          qavsL++;
        }else if(text =="ln"){
          qavsL++;
          resultController.text+="ln(";
            if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !(resultController.text[resultController.text.length-2]=="+") || !(resultController.text[resultController.text.length-2]=="-") || !(resultController.text[resultController.text.length-2]=="x") || !(resultController.text[resultController.text.length-2]=="÷")){
              resultController.text+="xln(";
            }else{
            resultController.text+="ln(";
            }
        }else if(text=="e"){
          resultController.text+="e";
        }else if(text=="eⁿ"){
          resultController.text+="e^";
        }else if(text=="|x|"){
          resultController.text+=".abs()";
          qavsL++;
          qavsR++;
        }else if(text=="√"){
          qavsL++;
           if(resultController.text[resultController.text.length-2].contains(RegExp(r"[0-9]"))  || !resultController.text[resultController.text.length-2].contains("+") || !resultController.text[resultController.text.length-2].contains("-") || !resultController.text[resultController.text.length-2].contains("x") || !resultController.text[resultController.text.length-2].contains("÷")){
              resultController.text+="x√";
            }else{
            resultController.text+="√";
            }
        }else if(text=="∛"){
          resultController.text+="∛";
        }else if(text=="n!"){
          resultController.text+="!";
        }

         editController.text = resultat(resultController.text);
    });
  }

  String resultat(String text) {
    expression = resultController.text.replaceAll('÷', '/').replaceAll('x', '*').replaceAll("√", "sqrt(").replaceAll("e", "$e").replaceAll("π", "$pi");
    if(resultController.text.contains("∛")){
          List<String> ildiz3List = resultController.text.split("∛").toList();
    for( int i=1; i<ildiz3List.length; i++){
        String x="";
         x = ildiz3List[i].replaceAll("+", "|")
              .replaceAll("-", "|")
              .replaceAll("log(", "|")
              .replaceAll("ln(", "|")
              .replaceAll("sqrt(", "|")
              .replaceAll("∛", "|")
              .replaceAll("exp(", "|")
              .replaceAll("atan(", "|")
              .replaceAll("acos(", "|")
              .replaceAll("asin(", "|")
              .replaceAll("tan(", "|")
              .replaceAll("sin(", "|")
              .replaceAll("cos(", "|")
              .split("|")
              .first
              .toString();
      num r = pow( 1/3, double.parse(x));      
      expression = expression.replaceAll("∛$x", "$r");
    }
    }

if(resultController.text.contains("!")){
   List<String> factorList = resultController.text.split("!").toList();
    for( int i=0; i<factorList.length-1; i++){
        String x="";
         x = factorList[i].replaceAll("+", "|")
              .replaceAll("-", "|")
              .replaceAll("log(", "|")
              .replaceAll("ln(", "|")
              .replaceAll("sqrt(", "|")
              .replaceAll("∛", "|")
              .replaceAll("exp(", "|")
              .replaceAll("atan(", "|")
              .replaceAll("acos(", "|")
              .replaceAll("asin(", "|")
              .replaceAll("tan(", "|")
              .replaceAll("sin(", "|")
              .replaceAll("cos(", "|")
              .split("|")
              .last
              .toString();
      int r = int.parse(x);
      r = factorial(r);
      expression = expression.replaceAll("$x!", "$r");
    }

}
    if(resultController.text.contains("^")){List<String> xList = resultController.text.split("^").toList();
    for(int i=0; i<xList.length-2;i++){
      String x="";
      String  d="";
      if(i%2==0){
        x = xList[i].replaceAll("+", "|")
              .replaceAll("-", "|")              
              .replaceAll("log(", "|")
              .replaceAll("ln(", "|")
              .replaceAll("sqrt(", "|")
              .replaceAll("∛", "|")
              .replaceAll("exp(", "|")
              .replaceAll("atan(", "|")
              .replaceAll("acos(", "|")
              .replaceAll("asin(", "|")
              .replaceAll("tan(", "|")
              .replaceAll("sin(", "|")
              .replaceAll("cos(", "|")
              .split("|")
              .last
              .toString();
      }
      if(i%2==1){
        d = xList[i+1].replaceAll("+", "|")
              .replaceAll("-", "|")
              .replaceAll("log(", "|")
              .replaceAll("ln(", "|")
              .replaceAll("sqrt(", "|")
              .replaceAll("∛", "|")
              .replaceAll("exp(", "|")
              .replaceAll("atan(", "|")
              .replaceAll("acos(", "|")
              .replaceAll("asin(", "|")
              .replaceAll("tan(", "|")
              .replaceAll("sin(", "|")
              .replaceAll("cos(", "|")
              .split("|")
              .first
              .toString();
      }

      num r = pow(double.parse(x), double.parse(d));
      expression = expression.replaceAll("$x^$d", "$r");
    }
    }

    if(resultController.text.contains("(")){
    for( int i=qavsR; i<=qavsL; i++){
        expression += ")"; 
      }
    }


    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
     
         return "${exp.evaluate(EvaluationType.REAL, cm)}";
  }

    Widget colorizeAnimation(bool checked) {
    var colorizeColors = [
      curWorkSpaceColor,
      curWorkSpaceColor,
      Colors.grey,
      curWorkSpaceColor,
    ];
    const colorizeTextStyle = TextStyle(
      fontSize: 22,
    );

    return Visibility(
      visible:checked,
    maintainState: true,
    maintainAnimation: true,
      child: AnimatedTextKit(
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
    ),
    );
  }

  longClear(){
    resultController.text="";
    editController.text="";
      editFontSize = 28;
       resultFontSize = 64;
       char="";
  }


int factorial(int N) {
   int result = 1;
  for (int i = 1; i <= N; i++) {
    result *= i;
  }
    return result;
}

}

