import 'package:flutter/material.dart';
import 'package:wedevs_task/models/login_model.dart';
import 'package:wedevs_task/models/profile_model.dart';
import 'package:wedevs_task/progress_bar.dart';
import 'package:wedevs_task/services/ApiService.dart';
import 'package:wedevs_task/ui/register.dart';
import 'package:wedevs_task/ui/dashboard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String username, password;
  APIService apiService;

  bool isApiCallProcess = false;

  LoginRequestModel loginRequestModel;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  LoginResponseModel loginResponseModel;

  bool _obscureText = true;
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressBar(
      child: loginUiWidget(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget loginUiWidget(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orangeAccent,
          centerTitle: true,
          title: Text("Login"),
        ),
        resizeToAvoidBottomInset: true,
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: SafeArea(
                child: Form(
                  key: globalFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/wedevs.png',
                        height: 100,
                        width: 250,
                      ),
                      SizedBox(height: 20.0),
                      TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        onSaved: (input) {
                          return loginRequestModel.username = input;
                        },
                        validator: (input) {
                          return input.isEmpty ? "Enter valid username" : null;
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
                        obscureText: _obscureText,
                        onSaved: (input) {
                          return loginRequestModel.password = input;
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
                              backgroundColor: Colors.orange),
                          onPressed: () {
                            if (validateAndSave()) {
                              setState(() {
                                isApiCallProcess = true;
                              });
                              APIService()
                                  .loginResponseHttp(loginRequestModel)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    isApiCallProcess = false;
                                    final snackBar = SnackBar(
                                        content: Text("Login Successful"));
                                    scaffoldKey.currentState
                                        .showSnackBar(snackBar);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Dashboard()),
                                    );
                                  });
                                } else {
                                  final snackBar =
                                      SnackBar(content: Text("Login Failed"));
                                  scaffoldKey.currentState
                                      .showSnackBar(snackBar);
                                }
                              });
                            }
                          },
                          child: Text("Login")),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              minimumSize: Size(400, 40),
                              primary: Colors.white,
                              backgroundColor: Colors.green),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: Text("Go to register")),
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
