import 'package:flutter/material.dart';
import 'package:sonoreader2/screens/choicescreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavScreen extends StatefulWidget {
  const NavScreen({Key? key}) : super(key: key);

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(245, 245, 245, 20),
      body: Padding(
        padding: const EdgeInsets.only(top:0),
        child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right:200),
                child: Container(
                  child:SvgPicture.asset("assets/images/corner shape.svg",
                  color:Color.fromRGBO(61, 226, 218, 20) ,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top:60),
                child: Text("Welcome on Board",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight:FontWeight.bold ,
                  ),

                ),
              ),
              Text("Select and option to get started",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                ),

              ),

            Padding(
              padding: const EdgeInsets.only(top:40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  SizedBox(
                    width:120,
                    height:100,
                    child: ElevatedButton(

                      child: Padding(
                        padding: const EdgeInsets.only(top:8),
                        child: Column(
                          children: [
                            Icon(
                              Icons.medical_services_outlined,
                              color:Color.fromRGBO(61, 226, 218, 20),
                              size:50,
                            ),
                            Text("Diagnosis",
                            style: TextStyle(
                              color:Color.fromRGBO(61, 226, 218, 20)
                            ),
                            )
                          ],
                        ),
                      ),

                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(245, 245, 245, 20)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                  side:BorderSide(
                                      width:3,
                                      color:Color.fromRGBO(61, 226, 218, 30)
                                  )

                                //side: BorderSide(color: Colors.red)
                              )
                          )

                      ),

                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (content)=> ChoiceScreen()));

                      },




                    ),
                  ),

                  SizedBox(
                    width:120,
                    height:100,
                    child: ElevatedButton(

                      child: Padding(
                        padding: const EdgeInsets.only(top:8),
                        child: Column(
                          children: [
                            Icon(
                              Icons.message,
                              color:Color.fromRGBO(61, 226, 218, 20) ,
                              size:50,
                            ),
                            Text("Forum",
                            style:TextStyle(
                              color: Color.fromRGBO(61, 226, 218, 20)
                            )
                            )
                          ],
                        ),
                      ),

                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(245, 245, 245, 50)),
                          backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(245, 245, 245, 20)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                                side:BorderSide(
                                  width:3,
                                  color:Color.fromRGBO(61, 226, 218, 20)
                                )

                                //side: BorderSide(color: Colors.red)
                              )
                          )

                      ),

                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (content)=> ChoiceScreen()));

                      },




                    ),
                  ),

                ],
              ),
            )
        ],
    ),
      ) ,);

  }}
