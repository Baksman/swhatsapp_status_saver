import 'package:flutter/material.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class SendMessageScreen extends StatefulWidget {
  @override
  _SendMessageScreenState createState() => _SendMessageScreenState();
}

class _SendMessageScreenState extends State<SendMessageScreen> {
  final _formKey = GlobalKey<FormState>();
  String phoneNumber;
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {},
                child: Image.asset(
                  "assets/images/whatsapp.png",
                  height: 30,
                  width: 30,
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Text("Send a Whatsapp message without saving the mobile number",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 17,
                    )),
                SizedBox(height: 20),
                InternationalPhoneNumberInput(
                  onInputChanged: (val) {
                    phoneNumber = val.phoneNumber;
                  },
                  // onSaved: (val) {
                  //   phoneNumber = val.phoneNumber;
                  //   print(phoneNumber);
                  // },
                  maxLength: 11,
                  validator: (val) {
                    String input = val.replaceAll(" ", "")?.trim() ?? "";
                    int number = int.tryParse(input);
                    if (number == null || input.length < 9) {
                      return "invalid";
                    }

                    return null;
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                      validator: (val) {
                        message = val ?? "";
                        return null;
                      },
                      decoration: InputDecoration(
                          hintText: "Enter a message",
                          border: new OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(10.0),
                            ),
                          ))),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    child: Text("Send"),
                    onPressed: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();

                        FlutterOpenWhatsapp.sendSingleMessage(
                            phoneNumber, message);
                      }
                    })
              ],
            ),
          ),
        ));
  }
}

//  FlutterOpenWhatsapp.sendSingleMessage("+2347030467685", "Hello");
