import 'package:best_calculator/change_theme.dart';
import 'package:flutter/material.dart';


class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: curWorkSpaceColor,
          body: SafeArea(
              child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/best.png',
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 40),
                const Text(
                  'Best Calculator ver 1.0',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                const SizedBox(height: 5),
                const Text("Creator: To'xtamatov Kamoliddin",
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                const SizedBox(height: 20),
                TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                    label: const Text('suhaylibnamir@gmail.com',
                        style:
                            TextStyle(fontSize: 20, color: Colors.white)))
              ],
            ),
          )),
        ));
  }
}