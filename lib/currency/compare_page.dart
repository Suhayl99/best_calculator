import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/currency/currency_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import '../calculator/constants.dart';
import '../calculator/scale_widget.dart';
import 'currency_model.dart';
import 'hive_utils.dart';
import 'package:math_expressions/math_expressions.dart';

class ComparePage extends StatefulWidget {
  const ComparePage({Key? key}) : super(key: key);

  @override
  State<ComparePage> createState() => _ComparePageState();
}

class _ComparePageState extends State<ComparePage> with HiveUtil {
   final TextEditingController _editingControllerTop = TextEditingController();
   final TextEditingController _editingControllerBottom = TextEditingController();
  final FocusNode _topFocus = FocusNode();
  final FocusNode _bottomFocus = FocusNode();
  List<CurrencyModel> _listCurrency = [];
  late CurrencyModel topCur;
  late CurrencyModel bottomCur;
   String expression = "";

  @override
  void initState() {
    super.initState();
    _editingControllerTop.addListener(() {
      if (_topFocus.hasFocus) {
        setState(() {
          if (_editingControllerTop.text.isNotEmpty) {
            double sum = double.parse(topCur.rate ?? '0') /
                double.parse(bottomCur.rate ?? '0') *
                double.parse(_editingControllerTop.text);
            _editingControllerBottom.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerBottom.clear();
          }
        });
      }
    });
    _editingControllerBottom.addListener(() {
      if (_bottomFocus.hasFocus) {
        setState(() {
          if (_editingControllerBottom.text.isNotEmpty) {
            double sum = double.parse(bottomCur.rate ?? '0') /
                double.parse(topCur.rate ?? '0') *
                double.parse(_editingControllerBottom.text);
            _editingControllerTop.text = sum.toStringAsFixed(2);
          } else {
            _editingControllerTop.clear();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _editingControllerTop.dispose();
    _editingControllerBottom.dispose();
    _topFocus.dispose();
    _bottomFocus.dispose();
    super.dispose();
  }

  Future<bool?> _loadData() async {
    var isLoad = await loadLocalData();
    if (true) {
      try {
        var response = await get(
            Uri.parse('https://cbu.uz/uz/arkhiv-kursov-valyut/json/'));
        if (response.statusCode == 200) {
          for (final item in jsonDecode(response.body)) {
            var model = CurrencyModel.fromJson(item);
            if (model.ccy == 'USD') {
              topCur = model;
            } else if (model.ccy == 'RUB') {
              bottomCur = model;
            }
            _listCurrency.add(model);
            await saveBox<String>(dateBox, topCur.date ?? '', key: dateKey);
            await saveBox<List<dynamic>>(currencyBox, _listCurrency,
                key: currencyListKey);
          }
          return true;
        } else {
          _showMessage('Unknown error');
        }
      } on SocketException {
        _showMessage('Connection error');
      } catch (e) {
        _showMessage(e.toString());
      }
    } else {
      return true;
    }
    return null;
  }

  Future<bool> loadLocalData() async {
    try {
      var date = await getBox<String>(dateBox, key: dateKey);
      if (date ==
          DateFormat('dd.MM.yyyy')
              .format(DateTime.now().add(const Duration(days: -1)))) {
        var list =
            await getBox<List<dynamic>>(currencyBox, key: currencyListKey) ??
                [];
        _listCurrency = List.castFrom<dynamic, CurrencyModel>(list);
        for (var model in _listCurrency) {
          if (model.ccy == 'USD') {
            topCur = model;
          } else if (model.ccy == 'RUB') {
            bottomCur = model;
          }
        }
        return false;
      } else {
        return true;
      }
    } catch (e) {
      log(e.toString());
    }
    return true;
  }

  _showMessage(String text, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isError ? Colors.red : Colors.green[400],
        content: Text(
          text,
          style: kTextStyle(size: 15, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: curWorkSpaceColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: FutureBuilder(
                  future: _listCurrency.isEmpty ? _loadData() : null,
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: curAppBarColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                           
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  children: [
                                    _itemExch(
                                        _editingControllerTop, topCur, _topFocus,
                                        ((value) {
                                      if (value is CurrencyModel) {
                                        setState(() => topCur = value);
                                      }
                                    })),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    _itemExch(_editingControllerBottom, bottomCur,
                                        _bottomFocus, ((value) {
                                      if (value is CurrencyModel) {
                                        setState(() => bottomCur = value);
                                      }
                                    })),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      var model = topCur.copyWith();
                                      topCur = bottomCur.copyWith();
                                      bottomCur = model;
                                      _editingControllerTop.clear();
                                      _editingControllerBottom.clear();
                                    });
                                  },
                                  child: Container(
                                    height: 35,
                                    width: 35,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xff2d334d),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white12),
                                    ),
                                    child: const Icon(
                                      Icons.currency_exchange,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Expanded(
                        child: Center(
                          child: Text(
                            'Error',
                            style: kTextStyle(size: 18),
                          ),
                        ),
                      );
                    } else {
                      return const Expanded(
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                  })),
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                alignment: Alignment.centerRight,
                child: Text(
                  "Courses as of-${DateTime.now().year}-${DateTime.now().month.toString().padLeft(2, '0')}-${DateTime.now().day.toString().padLeft(2, '0')}(${DateTime.now().hour.toString().padLeft(2, '0')}:${DateTime.now().minute.toString().padLeft(2, '0')})",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                )),
            Expanded(
              flex: 5,
              child: GridView.count(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 2,
                childAspectRatio: size.height * 0.00164,
                crossAxisCount: 4,
                primary: false,
                children: [
                  button(curAppBarColor, "7", curOperandsColor),
                  button(curAppBarColor, "8", curOperandsColor),
                  button(curAppBarColor, "9", curOperandsColor),
                  button(curAppBarColor, "⌫", curOperandsColor),
                  button(curAppBarColor, "4", curOperandsColor),
                  button(curAppBarColor, "5", curOperandsColor),
                  button(curAppBarColor, "6", curOperandsColor),
                  button(curAppBarColor, "⟠", curOperandsColor),
                  button(curAppBarColor, "1", curOperandsColor),
                  button(curAppBarColor, "2", curOperandsColor),
                  button(curAppBarColor, "3", curOperandsColor),
                  button(curAppBarColor, "C", curOperandsColor),
                  button(curAppBarColor, ".", curOperandsColor),
                  button(curAppBarColor, "0", curOperandsColor),
                  button(curAppBarColor, "00", curOperandsColor),
                  button(curAppBarColor, "OK", curOperandsColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemExch(TextEditingController controller, CurrencyModel? model,
      FocusNode focusNode, Function callback) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white12),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: TextField(
                  controller: controller,
                  showCursor: true,
                  readOnly: true,
                  style: kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isDense: true,
                    hintText: '0.00',
                    hintStyle:
                        kTextStyle(size: 24, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return CurrencyPage(
                      listCurrency: _listCurrency,
                      topCur: topCur.ccy,
                      bottomCur: bottomCur.ccy);
                })).then((value) {
                  if (value is CurrencyModel) {
                    setState(() {
                      model = value;
                    });
                  }
                }),
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff10a4d4)),
                  child: Row(children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SvgPicture.asset(
                        'assets/flags/${model?.ccy?.substring(0, 2).toLowerCase()}.svg',
                        height: 20,
                        width: 20,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Text(
                        model?.ccy ?? 'UNK',
                        style:
                            kTextStyle(size: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.white54,
                      size: 15,
                    )
                  ]),
                ),
              )
            ],
          ),
          Text(
            controller.text.isNotEmpty
                ? (double.parse(controller.text) * 0.05).toStringAsFixed(2)
                : '0.00',
            style:
                kTextStyle(fontWeight: FontWeight.w600, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Widget button(Color bgclr, String text, Color curOperandsColor) {
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
            color: curOperandsColor,
          ),
        ),
      ),
    );
  }

  btnOnClick(String text) {
    setState(() {
      if (text == "C") {
        _editingControllerTop.text = "";
        _editingControllerBottom.text = "";
      } else if (text == "⌫") {
        if (_editingControllerTop.text.isEmpty) {
          _editingControllerBottom.text = "";
          _editingControllerBottom.text = "";
        } else {
          _editingControllerTop.text = _editingControllerTop.text
              .substring(0, _editingControllerTop.text.length - 1);
              String a=bottomCur.rate ?? "0";
          _editingControllerBottom.text=(double.parse(resultat(_editingControllerTop.text))*double.parse(a)).toStringAsFixed(2);
        }
      } else if (text == "⟠") {
        var model = topCur.copyWith();
        topCur = bottomCur.copyWith();
        bottomCur = model;
        _editingControllerTop.clear();
        _editingControllerBottom.clear();
      }else if(text == "."){
          String a=bottomCur.rate ?? "0";
        var isPoint = _editingControllerTop.text.split('.').toList().length;
        if (isPoint == 2 && _editingControllerTop.text.length == 1) {
          _editingControllerTop.text += "0.";
        }
          _editingControllerBottom.text =(double.parse(resultat(_editingControllerTop.text))*double.parse(a)).toStringAsFixed(2);
      }else if(text == "00"){
          String a=bottomCur.rate ?? "0";
        if ( _editingControllerTop.text.isEmpty) {
          _editingControllerTop.text += "0.";
        }else{
          _editingControllerTop.text +="00";
        }
          _editingControllerBottom.text =(double.parse(resultat(_editingControllerTop.text))*double.parse(a)).toStringAsFixed(2);
      }else if(text=="OK"){
          
      }else{
        String a=bottomCur.rate ?? "0";
        _editingControllerTop.text+=text;
        _editingControllerBottom.text=(double.parse(resultat(_editingControllerTop.text))*double.parse(a)).toStringAsFixed(2);
      }
    });
  }

   String resultat(String text) {
    expression = _editingControllerTop.text;
    Parser p = Parser();
    Expression exp = p.parse(expression);
    ContextModel cm = ContextModel();
    return "${exp.evaluate(EvaluationType.REAL, cm)}";
  }
}
