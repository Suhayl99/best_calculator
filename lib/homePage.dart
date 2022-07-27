import 'package:best_calculator/calculator/calculator_page.dart';
import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/ruler/ruler_page.dart';
import 'package:best_calculator/settings.dart';
import 'package:best_calculator/thema_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'currency/compare_page.dart';
class MyHomePage extends StatefulWidget {
  
   MyHomePage({Key? key, required this.title}) : super(key: key);
   String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState(title);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  _MyHomePageState(this.title);
  String title;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: curAppBarColor,
      ),
    );
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: curBgColor,
        appBar: AppBar(
        
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                 _scaffoldKey.currentState!.openDrawer();
              },
              icon:  Icon(Icons.menu, color:  curActiveMenuColor, size: 28),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon:  Icon(Icons.settings, color: curActiveMenuColor, size: 28,),
            ),
          ],
          backgroundColor: curAppBarColor,
          title:  TabBar(
            indicatorWeight: 0.01,
            tabs: <Widget>[
              Tab(
                icon: ImageIcon(const AssetImage("assets/calculator.png"),
                    size: 28, color: curNotActiveMenuColor),
              ),
              Tab(
                icon: ImageIcon(const AssetImage("assets/money.png"),
                    size: 28, color: curNotActiveMenuColor),
              ),
              Tab(
                icon: ImageIcon(const AssetImage("assets/ruler.png"),
                    size: 28, color: curNotActiveMenuColor),
              ),
            ],
          ),
        ),
        body:  TabBarView(
          children: [CalculatorPage(title: title,),  const ComparePage(),  const RulerPage()],
        ),
        drawer: Drawer(
          width: 280,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: Container(
            height: 706,
            padding: const EdgeInsets.only(top: 48, left: 40, right: 30),
            child: ListView(children: [
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("1"),
                  _themeButton("2"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("3"),
                  _themeButton("4"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("5"),
                  _themeButton("6"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("7"),
                  _themeButton("8"),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                alignment: Alignment.center,
                children:[
                   InkWell(
                  onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text('To get more themes, stay tuned to our product. We will add new themes with each update', style:TextStyle(fontSize: 24, color: curBgColor ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 40,
              width: 80,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffEC5C22), Color(0xffF0781A)],
                          transform: GradientRotation(62),
                        ),
                      ),
                      child: const Text(
                        "Ok",
                        style: TextStyle(fontSize: 32, color: Colors.white),
                      ),
                    ),
          ),
        ],
      ),),
                  child: Container(
                    alignment: Alignment.center,
                    width: 262,
                    height: 33,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xffEC5C22), Color(0xffF0781A)],
                        transform: GradientRotation(62),
                      ),
                    ),
                    margin: const EdgeInsets.only(
                        top: 2, bottom: 9, left: 10, right: 8),
                    child: const Text(
                      "More Themes",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                ),
                ]
              ),
            ],
            ),
          ),
        ),
        endDrawer:  Drawer(
          width: double.infinity,
        child: DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xff22262F),
        appBar: AppBar(
          backgroundColor: Colors.white70,
          title: const TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 0.5,
            tabs: <Widget>[
              Tab(
                text: "Settings",
              ),
              Tab(
                text: "Themes",
              ),
            ],
          ),
        ),
        body:  const TabBarView(
          children: [SettingPage(label: 'Calculator',),   ThemaPage()],
        ),
      ),
      ),
        ),
      ),
    );
  }


GestureDetector _themeButton(String image) {
  var thema=int.parse(image);
    return GestureDetector(
      onTap: () {
        setState(() {
          changeThemeColor(thema);
        });
        Navigator.pop(context);
      },
      child: Image.asset(
        "assets/calculator/$image.png",
        height: 120,
        width: 80,
      ),
    );
  }

}






