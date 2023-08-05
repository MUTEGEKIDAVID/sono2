

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sonoreader2/screens/Register.dart';
import 'package:sonoreader2/screens/choicescreen.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);





  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color.fromRGBO(245, 245, 245, 20),
      body: SingleChildScrollView(
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
            Center(
              child: Text("Login Here",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),),
            ),
            Padding(

              padding: const EdgeInsets.only(top:20),
              child: SvgPicture.asset("assets/images/undraw_medicine_b-1-ol.svg",
                  width:250
              ),
            ),
            Container(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:20,right:20, top:15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter UserName",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),

                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right:20,left:20,top:10),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ),

                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:20),
                      child: Center(
                        child: Text("Forgot your password?",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                          ),),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:30,bottom: 10),
                      child: SizedBox(
                        width:330,
                        height:40,
                        child: ElevatedButton(
                          style: ButtonStyle(

                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(61, 226, 218, 20)),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),

                                    //side: BorderSide(color: Colors.red)
                                  )
                              )

                          ),
                          onPressed: () {


                            // Validate returns true if the form is valid, or false otherwise.
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Processing Data')),
                              );
                            }
                            // Navigator.push(context,
                            // MaterialPageRoute(builder: (content)=> ChoiceScreen()));


                          },
                          child: const Text('Login',
                              style: TextStyle(fontSize: 18)
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10,bottom: 20,left:90),
                      child: Center(
                        child: Row(
                          children: [
                            Text("Dont have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Register()),
                                );
                              },
                              child: Text("sign up",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold
                                ),),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )


          ],
        ),
      ),
    );
  }
}
