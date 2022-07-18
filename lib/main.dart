import 'package:best_calculator/calculator/calculator_page.dart';
import 'package:best_calculator/ruler/ruler_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'currency/compare_page.dart';
import 'currency/currency_model.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: const Color(0xff22262F),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () {
                 _scaffoldKey.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu, color: Color(0xffFCA300), size: 28),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                _scaffoldKey.currentState!.openEndDrawer();
              },
              icon: const Icon(Icons.settings, color: Color(0xffFCA300), size: 28,),
            ),
          ],
          backgroundColor: const Color(0xff1F2229),
          title: const TabBar(
            indicatorColor: Color(0xff1F2229),
            indicatorWeight: 0.01,
            tabs: <Widget>[
              Tab(
                icon: ImageIcon(AssetImage("assets/calculator.png"),
                    size: 28, color: Color(0xffFCA300)),
              ),
              Tab(
                icon: ImageIcon(AssetImage("assets/money.png"),
                    size: 28, color: Color(0xffFCA300)),
              ),
              Tab(
                icon: ImageIcon(AssetImage("assets/ruler.png"),
                    size: 28, color: Color(0xffFCA300)),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [CalculatorPage(),  ComparePage(),  RulerPage()],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("9"),
                  _themeButton("10"),
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children:[
                   InkWell(
                  onTap: () {},
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





  InkWell _themeButton(String image) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        "assets/calculator/$image.png",
        height: 120,
        width: 80,
      ),
    );
  }
}




class SettingPage extends StatefulWidget {
  const SettingPage({Key? key, required this.label}) : super(key: key);
  final String label;

  @override
  State<SettingPage> createState() => _SettingPageState(label);
}

class _SettingPageState extends State<SettingPage> {
  _SettingPageState(this.label);
  String label;
   bool isAccuracy = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffC1C1C1),
      child: ListView(
        children:  [
       Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(top: 40, left: 20),
        child: const Text("Change the text of the man screen", style: TextStyle(color: Colors.black87, fontSize: 12),)),
       Padding(
        padding: const EdgeInsets.only( left: 15, right: 20),
         child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          SizedBox(
            width: 250,
            child: TextField(
                style: const TextStyle(
            fontSize: 12,
            color: Colors.black                  
            ), 
            decoration: InputDecoration(
              hintText: label,
              labelText: label,
               border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
            ),
            
          ),
          ),
         TextButton(onPressed: (){}, 
         style:  ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), ),
         child: const Text("ok", style: TextStyle(color: Colors.black),),),
         ],),
       ),
  _itemSettings("Minimum accuracy","Limit minimum accuracy to 2 digits"),
  _itemSettings("Swipe to count","Swipe down the keyboard to calculate"),
  _itemSettings("Disable text animation","Turn off text animation in the main section"),
  _itemSettings("Leave the screen on","Disable sleep mode while the application is \n running"),
  _itemSettings("turn off the vibration",""),
  _itemSettings("hide status bar",""),
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 40),
      child: TextButton.icon(onPressed: (){}, icon: const Icon(Icons.info) , label: const Text("About", style:TextStyle(color: Colors.black87, fontSize: 24) ,)),
    )
      ]),
    );
  }

  Container _itemSettings(String text1, String text2) {
    return Container(
  padding: const EdgeInsets.symmetric(horizontal: 20, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  [
       Text(text1, style: const TextStyle(color: Colors.black87, fontSize: 24),),
         Text(text2, style: const TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isAccuracy,
            onChanged: (bool value) { 
              setState(() {
                isAccuracy = value;
              });
             }, 
            ),
          ],
         ),
);
  }
}


class ThemaPage extends StatelessWidget {
  const ThemaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
            color:  const Color(0xffC1C1C1),
            padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
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
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _themeButton("9"),
                 
                  _themeButton("10"),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              
            ]),
    );
  }

   InkWell _themeButton(String image) {
    return InkWell(
      onTap: () {},
      child: Image.asset(
        "assets/calculator/$image.png",
        height: 250,
        width: 120,
      ),
    );
  }
}

