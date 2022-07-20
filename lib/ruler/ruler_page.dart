import 'package:best_calculator/change_theme.dart';
import 'package:best_calculator/ruler/area.dart';
import 'package:best_calculator/ruler/cooking.dart';
import 'package:best_calculator/ruler/distance.dart';
import 'package:best_calculator/ruler/fuel.dart';
import 'package:best_calculator/ruler/temperature.dart';
import 'package:best_calculator/ruler/volume.dart';
import 'package:flutter/material.dart';

import 'mass.dart';

class RulerPage extends StatefulWidget {
  const RulerPage({Key? key}) : super(key: key);

  @override
  State<RulerPage> createState() => _RulerPageState();
}

class _RulerPageState extends State<RulerPage> {
  
  @override
  Widget build(BuildContext context) {
    
    return DefaultTabController(
      initialIndex: 0,
      length: 7,
      child: Scaffold(
          backgroundColor: curAppBarColor,
          appBar: AppBar(
            backgroundColor: curAppBarColor,
            title:  TabBar(
              indicatorColor: curActiveMenuColor,
              unselectedLabelColor: curActiveMenuColor,
              isScrollable: true,
              indicatorWeight: 1,
              tabs: const <Widget>[
                Tab(
                  text: "DISTANCE",
                ),
                Tab(
                  text: "AREA",
                ),
                Tab(
                  text: "MASS",
                ),
                Tab(
                  text: "VOLUME",
                ),
                Tab(
                  text: "TEMPERATURA",
                ),
                Tab(
                  text: "FUEL",
                ),
                Tab(
                  text: "COOKING",
                ),
              ],
            ),
          ),
          body:  const TabBarView(
                children: [
                  Dictance(),
                  Area(),
                  Mass(),
                  Volume(),
                  Temperature(),
                  Fuel(),
                  Cooking()
                ],
              ),
          
          ),
    );
  }
}
