import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sonoreader2/Provider/patient_id_provider.dart';
import 'package:sonoreader2/screens/UltraSound.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';

import 'package:provider/provider.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../datamodel.dart';

String default_choice="";
String default_choice2="";
String default_choice3="";
String? patient_id;





class MyChoice{

  String choice;
  int index;
  MyChoice({required this.index,required this.choice});


}

class ChoiceScreen extends StatefulWidget {

  const ChoiceScreen({Key? key}) : super(key: key);


  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}
Future<DataModel?> submitData(String fname,String lname,String mname,String age,String gender,String job,String smokestatus,String district,String subcounty,String parish,String village) async {

   var response = await http.post(
       Uri.parse('http://api.sonoreader.com/patient_info'),
       body: {
         "first_name": fname,
         "last_name": lname,
         "middle_name": mname,
         "age": age,
         "gender": gender,
         "occupation": job,
         "smokingStatus": smokestatus,
         "district": district,
         "subcounty": subcounty,
         "parish": parish,
         "village": village,

       }
   );
   var data = response.body;
   print(data);

   if (response.statusCode == 201) {
     // String responseString = response.body;
     // dataModelFromJson(responseString);

     String responseString = response.body;
     var jsonData = json.decode(responseString);
     final id = jsonData['id'];
      patient_id = id.toString();


     // Create a DataModel object with the extracted id
     DataModel dataModel = DataModel(id: id);
   } else
     return null;

}

Future<String> getIdFromAPI() async {
  final response = await http.get(Uri.parse('http://api.sonoreader.com/patient_info'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final results = data['results'];
    //final lastResult = results[results.length - 1];
    //final id = lastResult['id'];
    final id=data["id"];
     String patient_id = id.toString();
     return patient_id;


  } else {
    throw Exception('Failed to load id from API');
  }

}


class _ChoiceScreenState extends State<ChoiceScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();
  DataModel? _dataModel;
  //submission variables
  String fname ="";
  String lname="";
  String mname="";
  String age="";
  String gender="";
  String job="";
  String smokerstatus="";
  String district ="";
  String subcounty = "";
  String parish ="";
  String village="";
  String diagnosis ="";



  //........code for the check boxes
  bool? valuefirst = false;
  bool? valuesecond = false;
  bool? valuethird = false;
  bool? valuefourth = false;


  String clinical_data="";
  void submit_data(){


    if(valuefirst==true){
      clinical_data ="chest pain";
    }else if(valuesecond==true){
      clinical_data="cough";
    }else if(valuethird==true){
      clinical_data="Fever";
    }else if(valuefourth==true){
      clinical_data="DIB";
    }

  }



  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();
  final myController5 = TextEditingController();
  final myController6 = TextEditingController();
  final myController7 = TextEditingController();
  final myController8 = TextEditingController();

  final myControllerDialogue = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    myController5.dispose();
    myController6.dispose();
    myController7.dispose();
    myController8.dispose();
    myControllerDialogue.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PatientIdProvider(),
      child: Scaffold(
        appBar:AppBar(
          backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,
          title:Text("Patient information"),

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
                        MaterialPageRoute(builder: (content)=> UltraSound(PATID: '',)));
                  }
                }
            ),


          ],
        ),
        body: Column(
          children: [
            Form(
              key: formkey ,
                child:Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                          children: [
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:30.0,right:30.0,bottom:0.0),
                                child: TextFormField(
                                  controller: myController,
                                  decoration: InputDecoration(
                                    labelText: "Enter First Name"
                                      //border: OutlineInputBorder(
                                       // borderRadius: BorderRadius.all(Radius.circular(20.0)),

                                      //),
                                      //hintText:"Enter your Last name"
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:0.0),
                                child: TextFormField(
                                  controller: myController2,
                                  decoration: InputDecoration(
                                      labelText: "Enter Middle Name"
                                    //border: OutlineInputBorder(
                                    // borderRadius: BorderRadius.all(Radius.circular(20.0)),

                                    //),
                                    //hintText:"Enter your Last name"
                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:0.0),
                                child: TextFormField(
                                  controller: myController3,
                                  decoration: InputDecoration(
                                      labelText: "Enter last Name"
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      //
                                      // ),
                                      //hintText:"Enter your First Name"
                                  ),
                                  validator:(value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:10.0),
                                child: TextFormField(
                                  controller: myController4,
                                  decoration: InputDecoration(
                                      labelText: "Enter Your Age",
                                          labelStyle:TextStyle(

                                          )

                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                      //
                                      // ),

                                     // hintText:"Enter your Age"
                                  ),
                                  validator:  (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:20,right :158),
                              child: Container(child: Text("Address information",
                                  style:TextStyle(
                                      fontWeight: FontWeight.bold,
                                    fontSize: 18
                                  )
                              )),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:10.0),
                                child: TextFormField(
                                  controller: myController5,
                                  decoration: InputDecoration(
                                      labelText: "Enter District",
                                      labelStyle:TextStyle(

                                      )

                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    //
                                    // ),

                                    // hintText:"Enter your Age"
                                  ),
                                  validator:  (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),

                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:10.0),
                                child: TextFormField(
                                  controller: myController6,
                                  decoration: InputDecoration(
                                      labelText: "Enter subcounty",
                                      labelStyle:TextStyle(

                                      )

                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    //
                                    // ),

                                    // hintText:"Enter your Age"
                                  ),
                                  validator:  (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),

                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:10.0),
                                child: TextFormField(
                                  controller: myController7,
                                  decoration: InputDecoration(
                                      labelText: "Enter Parish",
                                      labelStyle:TextStyle(

                                      )

                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    //
                                    // ),

                                    // hintText:"Enter your Age"
                                  ),
                                  validator:  (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),

                              ),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:10.0),
                                child: TextFormField(
                                  controller: myController8,
                                  decoration: InputDecoration(
                                      labelText: "Enter village",
                                      labelStyle:TextStyle(

                                      )

                                    // border: OutlineInputBorder(
                                    //   borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                    //
                                    // ),

                                    // hintText:"Enter your Age"
                                  ),
                                  validator:  (value){
                                    if(value!.isEmpty){
                                      return "Required";
                                    }else{
                                      return null;
                                    }
                                  },

                                ),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:0.0,right:222.0),
                              child: Text("Clinical data",
                                  style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:2),
                              child: CheckboxListTile(

                                value: this.valuefirst,
                                onChanged: ( bool? value) {
                                  setState(() {
                                    this.valuefirst = value;
                                  });
                                  submit_data();
                                  print(clinical_data);
                                  print(myController);

                                },
                                title: const Text('Chest pain'),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:2),
                              child: CheckboxListTile(
                                title: const Text('Cough'),
                                value: this.valuesecond,
                                onChanged: ( bool? value) {
                                  setState(() {
                                    this.valuesecond = value;
                                  });
                                  submit_data();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:2),
                              child: CheckboxListTile(
                                title: const Text('Fever'),
                                value: this.valuethird,
                                onChanged: ( bool? value) {
                                  setState(() {
                                    this.valuethird = value;
                                  });
                                  submit_data();
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:2),
                              child: CheckboxListTile(
                                title: const Text('DIB'),
                                value: this.valuefourth,
                                onChanged: ( bool? value) {
                                  setState(() {
                                    this.valuefourth = value;
                                  });
                                  submit_data();
                                },
                              ),
                            ),



                            Padding(
                              padding: const EdgeInsets.only(left:0.0,right:230.0),
                              child: Text("Occupation",
                                  style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: RadioGroup(),

                                ),

                              ],

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:0.0,right:270.0),
                              child: Text("Gender",
                                  style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ),
                            Column(
                              children: [
                                Container(
                                  child: RadioGroupGender(),

                                ),

                              ],

                            ),
                            Padding(
                              padding: const EdgeInsets.only(left:0.0,right:250.0),
                              child: Text("Is patient",
                                  style:TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  )),
                            ),

                            Column(
                              children: [
                                Container(
                                  child: RadioGroupPatient(),

                                ),

                              ],

                            ),


                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 100),
                                child: Container(
                                  child: SizedBox(
                                    width:200,
                                    child: Builder(
                                      builder: (BuildContext context) {
                                        return ElevatedButton(


                                          child: Text(
                                              "Continue".toUpperCase(),
                                              style: TextStyle(fontSize: 18)
                                          ),
                                          style: ButtonStyle(

                                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                              backgroundColor: MaterialStateProperty.all<Color>(Color.fromRGBO(61, 226, 218, 20)),
                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(0),

                                                    //side: BorderSide(color: Colors.red)
                                                  )
                                              )

                                          ),
                                          onPressed: () async {




                                             fname= myController.text;
                                             lname=myController2.text;
                                             mname=myController3.text;
                                             age=myController4.text;
                                             gender=default_choice2;
                                             job=default_choice;
                                             smokerstatus =default_choice3;
                                             district= myController5.text;
                                             subcounty=myController6.text;
                                             parish=myController7.text;
                                             village=myController8.text;
                                             diagnosis=myControllerDialogue.text;

                                              DataModel? data = await submitData(fname,lname,mname,age,gender,job,smokerstatus,district,subcounty,parish,village);
                                            //String pad=await getIdFromAPI();

                                             //print(pad);



                                             setState(() {
                                                _dataModel=data;

                                              });


                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (content)=> UltraSound(PATID:"5")));

                                          },



                                        );
                                      }
                                    ),
                                  ),

                                ),
                              ),
                            )






                          ]
                      ),
                )
        ))
          ]

      ),

      ),
    );
  }
}

class RadioGroup extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RadioGroupState ();
  }

}

class RadioGroupState  extends State<RadioGroup>{

  int? default_index;


  List<MyChoice> choices=[
    MyChoice(index:0,choice:"Employed"),
    MyChoice(index:1,choice:"Unemployed"),
    MyChoice(index:2,choice:"Peasant Farmer"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Wrap(
          children: [
            Container(
              child: Column(
                children: choices.map((data) => RadioListTile(
                    title: Text('${data.choice}'),
                    value: data.index,
                    groupValue: default_index,
                    onChanged:(value){

                      setState(() {
                        default_choice = data.choice;
                        default_index= data.index;
                        if(default_choice=="Employed"){
                          default_choice="E";
                        }else if(default_choice=="Unemployed"){
                          default_choice="NE";
                        }else if(default_choice=="Peasant Farmer"){
                          default_choice="PF";
                        }

                      });
                      print(default_choice);
                    }),
                   // Text('${data.choice}'),
                ).toList(),
              )
            )
          ],
        ),
        // Padding(padding: EdgeInsets.all(14.0),
        // child: Text('${default_choice}',
        //   style: TextStyle(
        //     fontSize: 23.0,
        //   ),
        //
        // ),
        // )
      ],
    );
  }
}

//gender radio buttons logic
class RadioGroupGender extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RadioGroupGenderState ();
  }

}

class RadioGroupGenderState  extends State<RadioGroupGender>{

  int? default_index;


  List<MyChoice> choices=[
    MyChoice(index:0,choice:"Male"),
    MyChoice(index:1,choice:"Female"),

  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Wrap(
          children: [
            Container(
                child: Column(
                  children: choices.map((data) => RadioListTile(
                      title: Text('${data.choice}'),
                      value: data.index,
                      groupValue: default_index,
                      onChanged:(value){

                        setState(() {
                          default_choice2 = data.choice;
                          default_index= data.index;
                          if(default_choice2=="Male"){
                            default_choice2="M";
                          }else{
                            default_choice2="F";
                          }

                        });
                      })).toList(),
                )
            )
          ],
        ),

      ],
    );
  }
}
//patient is radio buttons
class RadioGroupPatient extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RadioGroupPatientState ();
  }

}

class RadioGroupPatientState  extends State<RadioGroupPatient>{

  int? default_index;


  List<MyChoice> choices=[
    MyChoice(index:0,choice:"Smoker"),
    MyChoice(index:1,choice:"Non-Smoker"),

  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Wrap(
          children: [
            Container(
                child: Column(
                  children: choices.map((data) => RadioListTile(
                      title: Text('${data.choice}'),
                      value: data.index,
                      groupValue: default_index,
                      onChanged:(value){

                        setState(() {
                          default_choice3 = data.choice;
                          default_index= data.index;

                          if(default_choice3=="smoker"){
                            default_choice3="S";
                          }else{
                            default_choice3="NS";
                          }

                        });
                      })).toList(),
                )
            )
          ],
        ),
        // Padding(padding: EdgeInsets.all(14.0),
        // child: Text('${default_choice}',
        //   style: TextStyle(
        //     fontSize: 23.0,
        //   ),
        //
        // ),
        // )
      ],
    );
  }
}






