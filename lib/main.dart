import 'package:best_calculator/about.dart';
import 'package:best_calculator/calculator/calculator_page.dart';
import 'package:best_calculator/calculator/calcule_model.dart';
import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/ruler/ruler_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'currency/compare_page.dart';
import 'currency/currency_model.dart';
import 'package:wakelock/wakelock.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter<CurrencyModel>(CurrencyModelAdapter());
  Hive.registerAdapter<CalculateModel>(CalculateModelAdapter());
  runApp( MyApp(title:"Best Calculator"));
}

class MyApp extends StatelessWidget {
   MyApp({Key? key, required this.title}) : super(key: key);
String title;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(title: 'Best Calculator'),
    );
  }
}

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
                alignment: Alignment.center,
                children:[
                   InkWell(
                  onTap: () => showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title:  Text('To get more themes, stay tuned to our product. We will add new themes with each update', style:TextStyle(fontSize: 32, color: curActiveMenuColor ),
        ),
        actions: [
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 50,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xffEC5C22), Color(0xffF0781A)],
                          transform: GradientRotation(62),
                        ),
                      ),
                      child: const Text(
                        "Ok",
                        style: TextStyle(fontSize: 24, color: Colors.white),
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
   bool isSwipe = false;
   bool isAnimation = false;
   bool isScreen = false;
   bool isVibration = false;
   bool isBar = false;
   final controller= TextEditingController();

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
              controller: controller,
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
         TextButton(onPressed: (){
         Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHomePage(title: controller.text)));
         }, 
         style:  ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white70), ),
         child: const Text("ok", style: TextStyle(color: Colors.black),),),
         ],),
       ),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Minimum accuracy", style:  TextStyle(color: Colors.black87, fontSize: 24),),
         Text("Limit minimum accuracy to 2 digits", style: TextStyle(color: Colors.black54, fontSize: 12),),
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
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Swipe to count", style:  TextStyle(color: Colors.black87, fontSize: 24),),
         Text("Swipe down the keyboard to calculate", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isSwipe,
            onChanged: (bool value) { 
              setState(() {
                isSwipe = value;
              });

              }, 
            ),
          ],
         ),
),
    Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Disable text animation", style:  TextStyle(color: Colors.black87, fontSize: 24),),
         Text("Turn off text animation in the main section", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isAnimation,
            onChanged: (bool value) { 
              setState(() {
                isAnimation = value;
              });

              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("Le tavehe screen on", style:  TextStyle(color: Colors.black87, fontSize: 24),),
         Text("Disable sleep mode while the application is \n running", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isScreen,
            onChanged: (bool value) { 
              setState(() {
                isScreen = value;
                 if(isScreen){
                  Wakelock.enable();
                }else{
                  Wakelock.disable();
                }
              });

              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("turn off the vibration", style:  TextStyle(color: Colors.black87, fontSize: 24),),
         Text("", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isVibration,
            onChanged: (bool value) { 
              setState(() {
                isVibration = value;
              });

              }, 
            ),
          ],
         ),
),
  Container(
  padding: const EdgeInsets.symmetric(horizontal: 10, vertical:20),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(children:  const [
       Text("hide status bar", style:  TextStyle(color: Colors.black87, fontSize: 24),),
         Text("", style: TextStyle(color: Colors.black54, fontSize: 12),),
      ],),
        Switch(
            value: isBar,
            onChanged: (bool value) { 
              setState(() {
                isBar = value;
                if(isBar){
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                }else{
                  SystemChrome.setEnabledSystemUIMode(
                    SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
                }
              });

              }, 
            ),
          ],
         ),
),
    Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(bottom: 40),
      child: TextButton.icon(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) =>  const About()));
      }, icon: const Icon(Icons.info) , label: const Text("About", style:TextStyle(color: Colors.black87, fontSize: 24) ,)),
    )
      ]),
    );
  }

}




class ThemaPage extends StatefulWidget {
  const ThemaPage({Key? key}) : super(key: key);

  @override
  State<ThemaPage> createState() => _ThemaPageState();
}

class _ThemaPageState extends State<ThemaPage> {
   @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: curAppBarColor,
      ),
    );
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
 GestureDetector _themeButton(String image) {
  var thema=int.parse(image);
    return GestureDetector(
      onTap: () {
          changeThemeColor(thema);
          Navigator.pop(context);      
      },
      child: Image.asset(
        "assets/calculator/$image.png",
        height: 250,
        width: 120,
      ),
    );
  }

}

