import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sonoreader2/screens/choicescreen.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';



class UltraSound extends StatefulWidget {
  const UltraSound({Key? key}) : super(key: key);

  @override
  State<UltraSound> createState() => _UltraSoundState();
}

class _UltraSoundState extends State<UltraSound> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();
  String? _selectedOption;
  String? _selectedOption2;
  String? _selectedOption3;

  File? imageSelect;
  final _imagePicker =ImagePicker();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:AppBar(
          backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,
          title:Text("UltraSound Diagnosis "),

            actions: [

              PopupMenuButton(
                // add icon, by default "3 dot" icon
                // icon: Icon(Icons.book)
                  itemBuilder: (context){
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Text("Home"),
                      ),

                      PopupMenuItem<int>(
                        value: 1,
                        child: Text("Patient Information"),
                      ),

                      PopupMenuItem<int>(
                        value: 2,
                        child: Text("UltraSound Diagnosis"),
                      ),
                    ];
                  },
                  onSelected:(value){
                    if(value == 0){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content)=> NavScreen()));
                    }else if(value == 1){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content)=> ChoiceScreen()));
                    }else if(value == 2){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content)=> UltraSound()));
                    }
                  }
              ),


            ]
        ),
        body: SingleChildScrollView(
              child:Form(
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
                padding: const EdgeInsets.only(top:10),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left:8,bottom:8,right:30,top:8),
                      child: Container(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom:15),
                            child:  Text("Location:"),
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

                        value: _selectedOption3,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedOption3 = newValue;
                          });
                        },
                        items: ['Posterior', 'Auxillary','Anterior']
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
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  imageSelect == null?
                      AspectRatio(
                          aspectRatio: 1.5,
                          child:Container(
                            color:Colors.grey[300],
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image),
                                Text("No image selected")
                              ],
                            ),
                          ))
                      : AspectRatio(
                    aspectRatio: 1.5,
                    child:Image.file(
                      File(imageSelect!.path),
                      fit: BoxFit.cover ,
                    )
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width:250,
                        child: ElevatedButton(

                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(61, 226, 218, 20)),

    ),
                            onPressed: (){
                              pickImageCamera();
                            },


                            child: Row(
                              children: [
                                Icon(Icons.camera),
                                Padding(
                                  padding: const EdgeInsets.only(left:25),
                                  child: Text("Take Picture "),
                                ),
                              ],
                            ),
                        ),
                      ),
                      SizedBox(
                        width:250,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(61, 226, 218, 20)),

                          ),
                          onPressed: (){
                            pickImageGallary();
                          },
                          child: Row(
                            children: [
                              Icon(Icons.photo_camera_back),

                              Padding(
                                padding: const EdgeInsets.only(left:25),
                                child: Text("Pick Image Gallary"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],

                  )

                ],
              )



],
          ),
            )

        )
    );
  }
  //get image from camera
  pickImageCamera() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if(image != null){
      setState(() {
        imageSelect=File(image.path);
      });
    }
  }
  //get iamge from gallary
  pickImageGallary() async  {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if(image!=null){
      setState(() {
        imageSelect=File(image.path);
      });
    }
  }
}


