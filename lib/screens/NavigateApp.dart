import 'package:flutter/material.dart';
import  '../screens/choicescreen.dart';
import '../screens/UltraSound.dart';
import '../screens/navigation_screen.dart';


class MainNavigator extends StatefulWidget {
  const MainNavigator({Key? key}) : super(key: key);

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {

  int _currentIndex=0;

  List<Widget> screens =[

    ChoiceScreen(),
    UltraSound(PATID: '',),


  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:screens[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type:BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          backgroundColor: Color.fromRGBO(61, 226, 218, 20),
          iconSize: 20,
          selectedFontSize: 10,
          selectedLabelStyle:TextStyle(
            color: Colors.white,

          ) ,
          selectedIconTheme: IconThemeData(
            color: Colors.white,
          ),
          items:[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
              backgroundColor: Color.fromRGBO(61, 226, 218, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: "Search",
              backgroundColor: Color.fromRGBO(61, 226, 218, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
              backgroundColor: Color.fromRGBO(61, 226, 218, 20),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_forward_ios),
              label: "continue",
              backgroundColor: Color.fromRGBO(61, 226, 218, 20),
            ),
          ],
          onTap: (index){
            setState(() {
              _currentIndex=index;
            });
          },
        ),
      ),
    );
  }
}
