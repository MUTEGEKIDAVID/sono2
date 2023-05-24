

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right:200),
            child: Container(
              child:SvgPicture.asset("assets/images/corner shape.svg",
                color:Color.fromRGBO(61, 226, 218, 20) ,
              ),
            ),
          ),
          Text("Login Here"),
          

        ],
      ),
    );
  }
}
