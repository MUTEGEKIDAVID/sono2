import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:sonoreader2/screens/choicescreen.dart';

import '../redux/app_state.dart';
import '../redux/store.dart';

class ResponseScreen extends StatefulWidget {
  final File? Image;
  const ResponseScreen({Key? key, this.Image}) : super(key: key);

  @override
  State<ResponseScreen> createState() => _ResponseScreenState();
}

class _ResponseScreenState extends State<ResponseScreen> {

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
              title: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(" Diagnosis Results "),
              ),
            ),
            body: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.only(top:8.0),
                  child: Container(
                    height: 200,
                    width: 200,
                    child: widget.Image != null
                        ? Image.file(
                      widget.Image!,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      child: Text("NO IMAGE SUBMITTED"),
                    ), // or you can provide a placeholder widget or handle it differently
                  ),
                ),
                Container(
                    child: Expanded(
                  child: ListView(children: [
                    ListTile(
                        subtitle: Text("${vm.lastName} ${vm.firstName} "),
                        title: Text(
                          "PatientName",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    ListTile(
                        subtitle: Text("${vm.hemithorax}"),
                        title: Text(
                          "Homothorax:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    ListTile(
                        subtitle: Text("${vm.lungZone}"),
                        title: Text(
                          "Lungzone:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    ListTile(
                        subtitle: Text("${vm.location}"),
                        title: Text(
                          "Location:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                    ListTile(
                        subtitle: Text(
                          "${vm.diagnosis}",
                          style: TextStyle(color: Colors.cyanAccent),
                        ),
                        title: Text(
                          "Diagnosis:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ]),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 30),
                  child: SizedBox(
                    width: 330,
                    height: 40,
                    child: ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromRGBO(61, 226, 218, 20)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),

                            //side: BorderSide(color: Colors.red)
                          ))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (content) => ChoiceScreen()));
                      },
                      child: const Text('Done', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
