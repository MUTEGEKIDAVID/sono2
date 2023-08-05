import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
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
import '../redux/app_state.dart';
import '../redux/store.dart';
import 'package:redux/redux.dart';

import 'Response.dart';



String? diagnize;

class UltraSound extends StatefulWidget {

  const UltraSound({Key? key}) : super(key: key);


  

  @override
  State<UltraSound> createState() => _UltraSoundState();
}


// Future<DataModel2?> submit_Data(
//     File image,
//     String hemithorax,
//     String lungzone,
//     String location,
//     String fname,
//     String lname,
//     String mname,
//     String age,
//     String gender,
//     String job,
//     String smokerstatus,
//     String district,
//     String subcounty,
//     String parish,
//     String village,
//     ) async {
//   final url = Uri.parse('https://sonoreader.com/api/diagnose/');
//
//   final requestHeaders = {'Content-Type': 'application/json'};
//   final bytes = await image.readAsBytes();
//   final base64Image = base64Encode(bytes);
//   final requestBody = jsonEncode({
//      'scan1': image,
//     'hemithorax': hemithorax,
//     'lung_zone': lungzone,
//     'local_position': location,
//     'first_name': fname,
//     'last_name': lname,
//     'middle_name': mname,
//     'village': village,
//     'parish': parish,
//     'sub_county': subcounty,
//     'district': district,
//     'fever':"yes",
//     'dib':"yes",
//     'chestpain':"yes",
//     'cough':"",
//     'smoking_status': smokerstatus,
//     'occupation': job,
//     //'age': age,
//     'sex': gender,
//     'year_of_birth':1999,
//
//
//
//
//
//
//   });
//
//   try {
//     final response = await http.post(url, headers: requestHeaders, body: requestBody);
//
//     // Log the response
//     print('Response Body: ${response.body}');
//
//     if (response.statusCode == 200) {
//       final jsonBody = jsonDecode(response.body);
//       final patientId = jsonBody['patient_id'];
//       final diagnosis =jsonBody['diagnosis'];
//       diagnize = diagnosis;
//       print('Patient ID: $patientId');
//       print('Diagnosis: $diagnosis');
//
//       return DataModel2.fromJson(jsonBody);
//     } else {
//       return null;
//     }
//   } catch (e) {
//     print('Error: $e');
//     return null;
//   }
// }
Future<void> saveImageToLocalStorage(File image) async {
  try {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/image.png';

    await image.copy(imagePath);

  } catch (e) {
    print('Error saving image: $e');

  }
}




Future<DataModel2?> submit_Data(
    File image,
    String hemithorax,
    String lungzone,
    String location,
    String fname,
    String lname,
    String mname,
    String age,
    String gender,
    String job,
    String smokerstatus,
    String district,
    String subcounty,
    String parish,
    String village,
    ) async {
  final url = Uri.parse('https://sonoreader.com/api/diagnose/');

  final requestHeaders = {'Content-Type': 'application/json'};

  final bytes = await image.readAsBytes();
  final base64Image = base64Encode(bytes);

  final requestBody = jsonEncode({
    'scan 1': base64Image,
    'hemithorax': hemithorax,
    'lung_zone': lungzone,
    'local_position': location,
    'first_name': fname,
    'last_name': lname,
    'middle_name': mname,
    'village': village,
    'parish': parish,
    'sub_county': subcounty,
    'district': district,
    'fever': "yes",
    'dib': "yes",
    'chestpain': "yes",
    'cough': "",
    'smoking_status': smokerstatus,
    'occupation': job,
    //'age': age,
    'sex': gender,
    'year_of_birth': 1999,
  });



  try {
    final response = await http.post(url, headers: requestHeaders, body: requestBody);

    // Log the response
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      final patientId = jsonBody['patient_id'];
      final diagnosis = jsonBody['diagnosis'];
      diagnize = diagnosis;
      print('Patient ID: $patientId');
      print('Diagnosis: $diagnosis');

      return DataModel2.fromJson(jsonBody);
    } else {
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}





class _UltraSoundState extends State<UltraSound> {
  GlobalKey<FormState> formkey = GlobalKey<FormState >();






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

  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, IncrementCounterViewModel>(
        converter: (Store<AppState> store) => IncrementCounterViewModel.fromStore(store),
        builder: (BuildContext context, IncrementCounterViewModel vm) {

    return Scaffold(
    appBar:AppBar(
        leading: Image.asset(
          'assets/images/sono2.jpg', // Replace with your logo image path
          width: 30,
          height: 30,
        ),
    backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,

    title: Text("UltraSound information"),

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
    body: StoreConnector<AppState, AppState>(
    converter: (store) => store.state,

    builder: (context, state) {


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
    child: Text("Homothorax:"),
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
    child: Text("Lung Zone:"),
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
    child: Text("Location:"),
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
    // Row(
    // children: [
    // Expanded(
    // child: Container(
    // color: Colors.grey,
    // child: GridView.builder(
    // shrinkWrap: true,
    // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
    // itemCount: _imageList.length,
    // itemBuilder: (BuildContext context, int index){
    // return Image.file(
    // File(_imageList[index].path),
    // fit: BoxFit.cover ,
    // );
    // }
    // ),
    // )
    // ),
    // ],
    // ),
      if (_imageFile != null)
        Image.file(
          _imageFile!,
          height: 150,
        ),
      SizedBox(height: 16),

    Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [

    OutlinedButton(
    onPressed: (){
      _pickImage(ImageSource.gallery);
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
      _pickImage(ImageSource.camera);
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
    child: Text(""),
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


    print(_imageFile);



    hemithorax=_selectedOption.toString();
    lungzone=_selectedOption2.toString();
    location=_selectedOption3.toString();

    String diagnosis= diagnize.toString();
    String fname = vm.firstName;
    String lname =vm.lastName;
    String mname=vm.middleName;
    String district=vm.district;
    String age=vm.age;
    String job=vm.job;
    String gender =vm.gender;
    String smokerstatus= vm.smokerStatus;
    String village=vm.village;
    String parish=vm.parish;
    String subcounty=vm.subcounty;


    submit_Data(
       _imageFile!,
       hemithorax,
       lungzone,
       location,

       fname,
       lname,
       mname,
       age,
       gender,
       job,
       smokerstatus,
       district,
       subcounty,
       parish,
      village,
    );


    vm.setUltraSoundData(
      hemithorax: hemithorax,
      lungZone: lungzone,
      location: location,
      image: image,
      diagnosis: diagnosis,
    );

    Navigator.push(context,
        MaterialPageRoute(builder: (content)=> ResponseScreen()));


    // String hemi="";
    // String lung="";
    // String loc="";
    //
    // if(hemithorax=="Right"){
    // hemi="R";
    // }else{
    // hemi="L";
    // }
    //
    // if(lungzone=="Upper"){
    // lung="U";
    // }else if(lungzone=="Middle"){
    // lung="M";
    // }else{
    // lung="L";
    // }
    //
    // if(location=="Posterior"){
    // loc="P";
    // }else if(location=="Auxillary"){
    // loc="AU";
    // }else{
    // loc="AN";
    // }


    //String Diagnosis= await getDiagnosisFromAPI();
    // showDialog(context: context, builder: (context){
    // return Container(
    // child:AlertDialog(
    // backgroundColor:Color.fromRGBO(61, 226, 218, 20) ,
    // titleTextStyle: TextStyle(
    // color: Colors.white,
    // fontSize: 25,
    // ),
    // title: Center(child: Text("welcome")),
    // actions: [
    // TextButton(onPressed: (){
    // Navigator.pop(context);
    // }, child: Text("ok",style:TextStyle(
    // fontSize: 20.0,
    // ) ,))
    // ],
    // )
    //
    // );
    // });
    // print("");

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
    );
  }
  //get image from camera
//   pickImageCamera(List<File> images) async {
//     final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//     if(image != null){
//
//
//       setState(() {
//         images.add(File(image.path));
//       });
//     }
//   }
//   //get iamge from gallary
//   pickImageGallary(List<File> images) async  {
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//     if(image!=null){
//
//       setState(() {
//         images.add(File(image.path));
//       });
//     }
//   }
}


