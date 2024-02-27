import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path_provider/path_provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:redux/redux.dart';
import 'package:sonoreader2/screens/choicescreen.dart';
import 'package:sonoreader2/screens/navigation_screen.dart';

import 'package:http_parser/http_parser.dart';

import '../datamodel2.dart';
import '../redux/app_state.dart';
import '../redux/store.dart';
import 'Response.dart';

String? diagnize;

class UltraSound extends StatefulWidget {
  const UltraSound({Key? key}) : super(key: key);

  @override
  State<UltraSound> createState() => _UltraSoundState();
}

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
  if (!image.existsSync()) {
    print('Error: Image is null');
    return null;
  }

  final url = Uri.parse('https://sonoreader.com/api/diagnose/');

  var request = http.MultipartRequest('POST', url);

  // Add the image as a MultipartFile
  request.files.add(await http.MultipartFile.fromPath(
    'scan1', // Use the correct parameter name expected by the server
    image.path,
    contentType: MediaType('image', 'png'), // Set the correct MIME type of the image
  ));

  // Add the rest of the data as fields
  request.fields['hemithorax'] = hemithorax;
  request.fields['lung_zone'] = lungzone;
  request.fields['location'] = location;
  request.fields['fname'] = fname;
  request.fields['lname'] = lname;
  request.fields['mname'] = mname;
  request.fields['age'] = age;
  request.fields['gender'] = gender;
  request.fields['job'] = job;
  request.fields['smokerstatus'] = smokerstatus;
  request.fields['district'] = district;
  request.fields['subcounty'] = subcounty;
  request.fields['parish'] = parish;
  request.fields['village'] = village;
  request.fields['fever'] = "yes";
  request.fields['dib'] = "yes";
  request.fields['chestpain'] = "yes";
  request.fields['cough'] = "";
  request.fields['year_of_birth'] = "1999"; // Assuming this is a placeholder year

  try {
    var streamedResponse = await request.send();
    final responses = await http.Response.fromStream(streamedResponse);
    if (responses.statusCode ==  200) {
      final jsonBody = jsonDecode(responses.body);
      final patientId = jsonBody['patient_id'];
      final diagnosis = jsonBody['diagnosis'];
      diagnize = diagnosis;
      print(jsonBody);
      print('Patient ID: $patientId');
      print('Diagnosis: $diagnosis');



      // return DataModel2.fromJson(jsonBody);
    } else {
      print("Error: Status Code ${responses.statusCode}");
      print("*********************************");
      return null;
    }
  } catch (e) {
    print('Error: $e');
    return null;
  }
}


Future<void> sendImageToApi(File image) async {
  // Check if the image file exists
  if (!image.existsSync()) {
    print('Error: Image file does not exist');
    return;
  }

  // Determine the MIME type of the image based on its file extension
  String? mimeType = lookupMimeType(image.path);
  if (mimeType == null) {
    print('Error: Could not determine the MIME type of the image');
    return;
  }

  // Define the URL of the API endpoint
  final url = Uri.parse('https://sonoreader.com/api/diagnose/');

  // Create a multipart request
  var request = http.MultipartRequest('POST', url);

  // Add the image as a MultipartFile with the determined MIME type
  request.files.add(await http.MultipartFile.fromPath(
    'scan1', // Parameter name as expected by the server
    image.path,
    contentType: MediaType.parse(mimeType), // Parse the MIME type string into a MediaType object
  ));

  // Send the request
  try {
    var streamedResponse = await request.send();
    final responses = await http.Response.fromStream(streamedResponse);
    if (responses.statusCode ==  200) {
      print('Image uploaded successfully');
      final jsonBody = jsonDecode(responses.body);
      final patientId = jsonBody['patient_id'];
      final diagnosis = jsonBody['diagnosis'];
      diagnize = diagnosis;
      print(jsonBody);
      print('Patient ID1: $patientId');
      print('Diagnosis1: $diagnosis');

    } else {
      print('Failed to upload image: ${responses.reasonPhrase}');
      print("........................");
    }
  } catch (e) {
    print('Error occurred while uploading image: $e');
  } finally {
    // Close the request stream
   // await request.close();
  }
}





class _UltraSoundState extends State<UltraSound> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  late StreamSubscription _intentDataStreamSubscription;
  late List<SharedMediaFile> _sharedFiles;

  File? _imageFile;

  @override
  void initState() {
    super.initState();

    // For sharing images coming from outside the app while the app is in the memory
    _intentDataStreamSubscription = ReceiveSharingIntent.getMediaStream()
        .listen((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        _imageFile = File(_sharedFiles.first.path);
      });
    }, onError: (err) {
      print("getIntentDataStream error: $err");
    });

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() {
        _sharedFiles = value;
        _imageFile = File(_sharedFiles.first.path);
      });
    });
  }

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    _intentDataStreamSubscription.cancel();

    super.dispose();
  }

  DataModel2? _dataModel2;
  //variables for data to be submitted
  String hemithorax = "";
  String lungzone = "";
  String location = "";
  String image = "";

  //selected options
  String? _selectedOption;
  String? _selectedOption2;
  String? _selectedOption3;
  String? _selectedOption4;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: source);

    if (pickedImage != null) {
      print("i am picked:$pickedImage");
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    } else {
      setState(() {
        _imageFile = File('assets/images/sick_372.png');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, IncrementCounterViewModel>(
        converter: (Store<AppState> store) =>
            IncrementCounterViewModel.fromStore(store),
        builder: (BuildContext context, IncrementCounterViewModel vm) {
          return Scaffold(
            appBar: AppBar(
                leading: Image.asset(
                  'assets/images/sono2.jpg', // Replace with your logo image path
                  width: 30,
                  height: 30,
                ),
                backgroundColor: Color.fromRGBO(61, 226, 218, 20),
                title: Text("UltraSound information"),
                actions: [
                  PopupMenuButton(
                      // add icon, by default "3 dot" icon
                      // icon: Icon(Icons.book)
                      itemBuilder: (context) {
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
                  }, onSelected: (value) {
                    if (value == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (content) => NavScreen()));
                    } else if (value == 1) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => ChoiceScreen()));
                    } else if (value == 2) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (content) => UltraSound()));
                    }
                  }),
                ]),
            body: StoreConnector<AppState, AppState>(
                converter: (store) => store.state,
                builder: (context, state) {
                  return SingleChildScrollView(
                      child: Form(
                    key: formkey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, right: 120),
                          child: Container(
                              child: Text(
                                  "Zonal location of chest ray opacities:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text("Homothorax:"),
                                )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 58,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: "Select Location",
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedOption,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption = newValue;
                                    });
                                    print(_selectedOption);
                                  },
                                  items: ['Right', 'left']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 8, right: 18, top: 8),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text("Lung Zone:"),
                                )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 55,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: "Select Location",
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedOption2,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption2 = newValue;
                                    });
                                  },
                                  items: ['Upper', 'Middle', 'Lower']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, bottom: 8, right: 30, top: 8),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
                                  child: Text("Location:"),
                                )),
                              ),
                              SizedBox(
                                width: 250,
                                height: 55,
                                child: DropdownButtonFormField<String>(
                                  decoration: InputDecoration(
                                    labelText: "Select Location",
                                    border: OutlineInputBorder(),
                                  ),
                                  value: _selectedOption3,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedOption3 = newValue;
                                    });
                                  },
                                  items: ['Posterior', 'Auxillary', 'Anterior']
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
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
                          padding: const EdgeInsets.only(right: 250, top: 8),
                          child: Container(
                              child: Text("upload images:",
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold))),
                        ),

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
                              onPressed: () {
                                _pickImage(ImageSource.gallery);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.photo_camera_back),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text("Pick Image Gallary"),
                                  ),
                                ],
                              ),
                            ),
                            OutlinedButton(
                              onPressed: () {
                                _pickImage(ImageSource.camera);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.camera),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 25),
                                    child: Text("Take picture"),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                    child: Padding(
                                  padding: const EdgeInsets.only(bottom: 15),
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
                                width: 250,
                                child: ElevatedButton(
                                  child: Text("Save".toUpperCase(),
                                      style: TextStyle(fontSize: 18)),
                                  style: ButtonStyle(
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color.fromRGBO(61, 226, 218, 20)),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0),

                                        //side: BorderSide(color: Colors.red)
                                      ))),
                                  onPressed: () async {
                                    print("i am here");
                                    print(_imageFile);

                                    hemithorax = _selectedOption.toString();
                                    lungzone = _selectedOption2.toString();
                                    location = _selectedOption3.toString();

                                    String diagnosis = diagnize.toString();
                                    String fname = vm.firstName;
                                    String lname = vm.lastName;
                                    String mname = vm.middleName;
                                    String district = vm.district;
                                    String age = vm.age;
                                    String job = vm.job;
                                    String gender = vm.gender;
                                    String smokerstatus = vm.smokerStatus;
                                    String village = vm.village;
                                    String parish = vm.parish;
                                    String subcounty = vm.subcounty;

                                    // sendImageToApi(_imageFile!);

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

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (content) =>
                                                ResponseScreen( Image: _imageFile,)));


                                  },
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ));
                }),
          );
        });
  }

}
