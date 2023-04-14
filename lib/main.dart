import 'package:flutter/material.dart';
import './screens/NavigateApp.dart';
import 'package:sonoreader2/screens/choicescreen.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart';


void main() {
  runApp(
    const MyApp(),

  );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'SONOREADER',

      home:NavScreen(),
    );
  }
}

//--------THIS IS THE OLD PROGRAM CODE I HAVE COMMENTED OUT--------

// class HomeScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       resizeToAvoidBottomInset: false,
//         backgroundColor:Color.fromRGBO(245, 245, 245, 20),
//
//         body: SingleChildScrollView(
//           child: ConstrainedBox(
//             constraints: BoxConstraints(),
//             child:Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(right:200,top:0),
//                   child: Container(
//                     child:SvgPicture.asset("assets/images/corner shape.svg",
//                     color:Color.fromRGBO(61, 226, 218, 20)
//                     ),
//                   ),
//                 ),
//
//                 SvgPicture.asset("assets/images/undraw_medicine_b-1-ol.svg",
//                 width:250
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Text(
//                     "Get things started with SONOREADER",
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30, right: 30, top: 10,bottom:20 ),
//                   child: Text(
//                     "How to learn to use the above application properly. Follow these instructions strictly.Lorem ipsum que irelo ipsi lore si nosomos sotros. que pasa siempre sielo ocho.",
//                     textAlign:TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.normal),
//                   ),
//                 ),
//                 Container(
//                   height:50,
//                   width:250,
//                   child: ElevatedButton(
//
//                     child: Text(
//                         "Get Started".toUpperCase(),
//                         style: TextStyle(fontSize: 13)
//                     ),
//                     style: ButtonStyle(
//
//                         foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
//                         backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(61, 226, 218, 20)),
//                         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                             RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(0),
//
//                               //side: BorderSide(color: Colors.red)
//                             )
//                         )
//
//                     ),
//                     onPressed: (){
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (content)=> NavScreen()));
//
//                     },
//
//
//
//                   ),
//
//                 ),
//
//               ],
//             ),
//           ),
//         )
//     );
//
// }}
