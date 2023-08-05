import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sonoreader2/screens/Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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

            Padding(
              padding: const EdgeInsets.only(bottom: 10,top:0),
              child: Center(
                child: Text("Register Here",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                  ),),
              ),
            ),
            Center(
              child: Text("Lets Help you get Started",
                style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold
                ),),
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
                      padding: const EdgeInsets.only(left:20,right:20, top:15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Email",
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
                      padding: const EdgeInsets.only(left:20,right:20, top:15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter password",
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
                      padding: const EdgeInsets.only(left:20,right:20, top:15),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: "Confirm password",
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
                            Navigator.push(context,
                                MaterialPageRoute(builder: (content)=> Login()));


                          },
                          child: const Text('Register',
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
                            Text("Already have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                              ),),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => Login()),
                                );
                              },
                              child: Text("Login",
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
