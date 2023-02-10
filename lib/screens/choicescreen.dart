import 'package:flutter/material.dart';
import 'package:sonoreader2/screens/UltraSound.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';
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

class _ChoiceScreenState extends State<ChoiceScreen> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      MaterialPageRoute(builder: (content)=> UltraSound()));
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
                  child: new SingleChildScrollView(
                    child: Column(
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0,top:30.0,right:30.0,bottom:0.0),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: "Enter FirstName"
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
                                decoration: InputDecoration(
                                    labelText: "Enter SecondName"
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
                          Padding(
                            padding: const EdgeInsets.only(left:0.0,right:250.0),
                            child: Text("Diagnosis",
                                style:TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                          ),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left:20.0,top:10.0,right:30.0,bottom:10.0),
                              child: TextFormField(
                                maxLines: 5,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(Radius.circular(0.0)),

                                    ),


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
                              padding: const EdgeInsets.only(bottom: 100),
                              child: Container(
                                child: SizedBox(
                                  width:200,
                                  child: ElevatedButton(


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
                                    onPressed: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (content)=> UltraSound()));

                                    },



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

    )
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
  String default_choice ="Employed";
  int default_index=0;


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

                      });
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
  String default_choice ="Male";
  int default_index=0;


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
                          default_choice = data.choice;
                          default_index= data.index;

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
  String default_choice ="Non-smoker";
  int default_index=0;


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
                          default_choice = data.choice;
                          default_index= data.index;

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






