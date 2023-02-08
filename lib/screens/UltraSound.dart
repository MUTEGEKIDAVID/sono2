
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class UltraSound extends StatefulWidget {
  const UltraSound({Key? key}) : super(key: key);

  @override
  State<UltraSound> createState() => _UltraSoundState();
}

class _UltraSoundState extends State<UltraSound> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();
  String? _selectedOption;
  String? _selectedOption2;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,
          title:Text("UltraSound Diagnosis Information"),
        ),
        body:Form(
            key: formkey ,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:20,right :120),
                child: Container(child: Text("Zonal location of chest ray opacities:",
                style:TextStyle(
                  fontWeight: FontWeight.bold
                )
                )),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:15),
                            child:  Text("Homothorax:"),
                          )),
                    ),
                    SizedBox(
                      width:250,
                      height:55,
                      child: DropdownButtonFormField<String>(

                        decoration: InputDecoration(
                          labelText: "Select Location",
                          border: OutlineInputBorder(


                          ),
                        ),
                        value: _selectedOption,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption = newValue;
                          });
                        },
                        items: ['Right', 'left']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8,bottom:8,right:18,top:8),
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:15),
                            child:  Text("Lung Zone:"),
                          )),
                    ),
                    SizedBox(
                      width:250,
                      height:55,
                      child: DropdownButtonFormField<String>(

                        decoration: InputDecoration(
                          labelText: "Select Location",
                          border: OutlineInputBorder(


                          ),
                        ),

                        value: _selectedOption2,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption2 = newValue;
                          });
                        },
                        items: ['Upper', 'Middle','Lower']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right:250,top:8),
                child: Container(
                  child:Text("upload images:",
                  style:TextStyle(
                    fontWeight:FontWeight.bold
                  )
                  )
                ),
              )





],
          ),
            )


    );
  }
}
