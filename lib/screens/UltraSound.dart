import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sonoreader2/Provider/patient_id_provider.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sonoreader2/screens/choicescreen.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:http_parser/http_parser.dart';

import '../datamodel2.dart';





class UltraSound extends StatefulWidget {
  String PATID;
  UltraSound({Key? key, required this.PATID}): super(key: key);


  

  @override
  State<UltraSound> createState() => _UltraSoundState(PATID);
}
Future<DataModel2?> submit_Data(String hemithorax, String lungzone, String location, List<File> images, int patient_id) async {
  final url = Uri.parse('http://api.sonoreader.com/diagnose');

  final boundary = '----${DateTime.now().millisecondsSinceEpoch}';
  final request = http.MultipartRequest('POST', url);
  request.headers.addAll({'Content-Type': 'multipart/form-data; boundary=$boundary'});

  final resizedImages = await Future.wait(images.map((image) async {
    final bytes = await image.readAsBytes();
    final part = http.MultipartFile('image', Stream.value(bytes), bytes.length, filename: 'image.jpg');
    return part;
  }));


  final nonEmptyEncodedImages = resizedImages.where((part) => part.length != null).toList();
  final requestBody = <http.MultipartFile>[
    http.MultipartFile('hemithorax', Stream.value(utf8.encode(hemithorax)), utf8.encode(hemithorax).length, contentType: MediaType.parse('text/plain')),
    http.MultipartFile('lungzone', Stream.value(utf8.encode(lungzone)), utf8.encode(lungzone).length, contentType: MediaType.parse('text/plain')),
    http.MultipartFile('location', Stream.value(utf8.encode(location)), utf8.encode(location).length, contentType: MediaType.parse('text/plain')),
    http.MultipartFile('patientId', Stream.value(utf8.encode(patient_id.toString())), utf8.encode(patient_id.toString()).length, contentType: MediaType.parse('text/plain')),
    ...nonEmptyEncodedImages,
  ];

  request.fields['hemithorax'] = hemithorax;
  request.fields['lungzone'] = lungzone;
  request.fields['location'] = location;
  request.fields['patientId'] = patient_id.toString();
  request.files.addAll(requestBody);

  // Log the request body
  print('Request Body: ${requestBody.toString()}');

  try {
    final response = await http.Response.fromStream(await request.send());

    // Log the response
    print('Response Body: ${response.body}');

    if (response.statusCode == 201) {
      return DataModel2.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}

Future<String> getDiagnosisFromAPI() async {
  final response = await http.get(Uri.parse('http://api.sonoreader.com/diagnose'));
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    final results = data['results'];
    final lastResult = results[results.length - 1];
    final id = lastResult['diagnosis'];
    String diagnosis= id.toString();
    return diagnosis;


  } else {
    throw Exception('Failed to load id from API');
  }

}

class _UltraSoundState extends State<UltraSound> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();

  String PATID;
  _UltraSoundState(this.PATID);



  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();

    super.dispose();
  }

  DataModel2? _dataModel2;
  //variables for data to be submitted
  String hemithorax="";
  String lungzone="";
  String location="";
  String image="";

  //selected options
  String? _selectedOption;
  String? _selectedOption2;
  String? _selectedOption3;
  String? _selectedOption4;

  File? imageSelect;
  final  ImagePicker _picker =ImagePicker();
  List<File> _imageList =[];



  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar:AppBar(
          backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,

          title: Text(PATID),

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


            ]
        ),
        body: Builder(
          builder: (BuildContext context) {


            return SingleChildScrollView(
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
                              print(_selectedOption);
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
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                            color:  Colors.grey,
                            child: GridView.builder(
                              shrinkWrap: true,
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                itemCount: _imageList.length,
                                itemBuilder: (BuildContext context, int index){
                                  return Image.file(
                                    File(_imageList[index].path),
                                    fit: BoxFit.cover ,
                                  );
                                }
                            ),
                          )
                      ),
                    ],
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      OutlinedButton(
                          onPressed: (){
                            pickImageGallary(_imageList);
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
                      OutlinedButton(
                        onPressed: (){
                          pickImageCamera(_imageList);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.camera),

                            Padding(
                              padding: const EdgeInsets.only(left:25),
                              child: Text("Take picture"),
                            ),
                          ],
                        ),

                      )



                    ],
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
                                child:  Text(""),
                              )),
                        ),

                      ],
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Container(
                        child: SizedBox(
                          width:250,
                          child: ElevatedButton(


                            child: Text(
                                "Save".toUpperCase(),
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
                              print(PATID);
                              print(_imageList);


                               hemithorax=_selectedOption.toString();
                               lungzone=_selectedOption2.toString();
                               location=_selectedOption3.toString();
                               image=_imageList.toString();
                               int? patientID= int.parse(PATID);
                               int pat= patientID;


                               String hemi="";
                               String lung="";
                               String loc="";

                               if(hemithorax=="Right"){
                                 hemi="R";
                               }else{
                                 hemi="L";
                               }

                               if(lungzone=="Upper"){
                                 lung="U";
                               }else if(lungzone=="Middle"){
                                 lung="M";
                               }else{
                                 lung="L";
                               }

                               if(location=="Posterior"){
                                 loc="P";
                               }else if(location=="Auxillary"){
                                 loc="AU";
                               }else{
                                 loc="AN";
                               }

                                submit_Data(hemi, lung, loc,_imageList,pat);
                               //String Diagnosis= await getDiagnosisFromAPI();
                               showDialog(context: context, builder: (context){
                                 return Container(
                                   child:AlertDialog(
                                     backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,
                                     titleTextStyle: TextStyle(
                                       color: Colors.white,
                                       fontSize: 25,
                                     ),
                                     title: Center(child: Text("welcome")),
                                     actions: [
                                       TextButton(onPressed: (){
                                         Navigator.pop(context);
                                       }, child: Text("ok",style:TextStyle(
                                         fontSize: 20.0,
                                       ) ,))
                                     ],
                                   )

                                 );
                               });
                               print("");

                               // setState(() {
                               //
                               //   _dataModel2=data;
                               // });
                              //Navigator.push(context,
                                 // MaterialPageRoute(builder: (content)=> ));

                            },



                          ),
                        ),

                      ),
                    ),
                  )



],
              ),
                )

            );
          }
        ),

    );
  }
  //get image from camera
  pickImageCamera(List<File> images) async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null){


      setState(() {
        images.add(File(image.path));
      });
    }
  }
  //get iamge from gallary
  pickImageGallary(List<File> images) async  {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image!=null){

      setState(() {
        images.add(File(image.path));
      });
    }
  }
}


