import 'package:flutter/material.dart';
import 'package:wedevs_task/models/login_model.dart';
import 'package:wedevs_task/models/profile_model.dart';
import 'package:wedevs_task/models/registration_model.dart';
import 'package:wedevs_task/progress_bar.dart';
import 'package:wedevs_task/services/ApiService.dart';
import 'package:wedevs_task/ui/login.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => new _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String username, email, password;
  APIService apiService;

  bool isApiCallProcess = false;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  RegistrationRequestModel registerRequestModel;
  RegistrationResponseModel registerResponseModel;
  ProfileModel profileModel;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    registerRequestModel = new RegistrationRequestModel();
    registerResponseModel = new RegistrationResponseModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: registerUiWidget(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget registerUiWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.lightGreen,
          centerTitle: true,
          title: Text("Registration"),
        ),
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(40.0),
              child: SafeArea(
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        'assets/wedevs.png',
                        height: 80,
                        width: 250,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        onSaved: (input) {
                          return registerRequestModel.username = input;
                        },
                        validator: (input) {
                          return input.isEmpty
                              ? "Username cannot be empty"
                              : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Username',
                          prefixIcon: Icon(
                            Icons.people,
                            color: Colors.green,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        onSaved: (input) {
                          return registerRequestModel.email = input;
                        },
                        validator: (input) {
                          return input.isEmpty ? "Enter a valid email" : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.green,
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      TextFormField(
                        autofocus: false,
                        obscureText: _obscureText,
                        onSaved: (input) {
                          return registerRequestModel.password = input;
                        },
                        validator: (input) {
                          return input.isEmpty ? "Enter a password" : null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          ),
                          suffixIcon: InkWell(
                            onTap: _toggle,
                            child: Icon(
                              _obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              size: 25.0,
                              color: Colors.deepOrange,
                            ),
                          ),
                          contentPadding:
                              EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                        ),
                      ),
                      SizedBox(height: 50.0),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(400, 40),
                              primary: Colors.white,
                              backgroundColor: Colors.lightGreen),
                          onPressed: () async {
                            if (validateAndSave()) {
                              print(registerRequestModel.toJson());
                              setState(() {
                                isApiCallProcess = true;
                              });
                              await APIService()
                                  .registration(registerRequestModel)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                  if (value.code == 200) {
                                    registerResponseModel.message =
                                        value.message;
                                    final snackBar = SnackBar(
                                        content:
                                            Text("Registration Successful"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                        Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                                  } else {
                                    final snackBar = SnackBar(
                                        content: Text(
                                            "Failed! Try another username and email"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                  }
                                } else {
                                  setState(() {
                                    isApiCallProcess = false;
                                  });
                                }
                              });
                            }
                          },
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(400, 40),
                              primary: Colors.white,
                              backgroundColor: Colors.lightBlue),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()),
                            );
                          },
                          child: Text(
                            "Go Back To Login",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
