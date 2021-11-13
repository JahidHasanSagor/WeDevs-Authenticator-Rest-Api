import 'package:flutter/material.dart';
import 'package:wedevs_task/models/login_model.dart';
import 'package:wedevs_task/models/profile_model.dart';
import 'package:wedevs_task/services/ApiService.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  ProfileModel profileModel;
  Future<ProfileModel> _futureProfileModel;
  String _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvYXBwdGVzdC5kb2thbmRlbW8uY29tIiwiaWF0IjoxNjM2NzM4MDMwLCJuYmYiOjE2MzY3MzgwMzAsImV4cCI6MTYzNzM0MjgzMCwiZGF0YSI6eyJ1c2VyIjp7ImlkIjoiMTg0In19fQ.4d-2h-jhMsLOkeBw-OAHeAa-0md4oSBbS5xIAgaYuqY";

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileModel = new ProfileModel();
    _futureProfileModel = APIService().updateDataPostRequest(_token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        title: Text("Profile"),
        key: scaffoldKey,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  //Model data container
                  // SafeArea(
                  //   child: TextButton.icon(
                  //     icon: Icon(Icons.edit, color: Colors.white),
                  //     onPressed: () => showDialog<String>(
                  //       context: context,
                  //       builder: (BuildContext context) => AlertDialog(
                  //         title: const Text('AlertDialog Title'),
                  //         content: Column(
                  //           children: [
                  //             TextFormField(
                  //               onSaved: (input) {
                  //                 profileModel.firstName = input;
                  //               },
                  //             ),
                  //             TextFormField(
                  //               onSaved: (input) {
                  //                 profileModel.lastName = input;
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //         actions: <Widget>[
                  //           TextButton(
                  //             onPressed: () => Navigator.pop(context, 'Cancel'),
                  //             child: const Text('Cancel'),
                  //           ),
                  //           TextButton(
                  //             onPressed: () => Navigator.pop(context, 'OK'),
                  //             child: const Text('OK'),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     label: const Text(
                  //       'Edit',
                  //       style: TextStyle(
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _futureProfileModel =
                              APIService().updateDataPostRequest(_token);
                        });
                      },
                      icon: Icon(Icons.rotate_right),
                      label: Text('Reload')),

                  SizedBox(
                    height: 20,
                  ),

                  FutureBuilder<ProfileModel>(
                    future: _futureProfileModel,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 10,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    children: [
                                      Text(
                                        "Profile Data",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        width: 300,
                                        height: 50,
                                        padding: EdgeInsets.all(12),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "First Name:  ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.deepOrange),
                                            ),
                                            Text(
                                              snapshot.data.firstName != null
                                                  ? snapshot.data.firstName
                                                  : "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Container(
                                        width: 300,
                                        height: 50,
                                        padding: EdgeInsets.all(12),
                                        alignment: Alignment.centerLeft,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8.0)),
                                        ),
                                        child: Row(
                                          children: [
                                            Text(
                                              "Last Name:  ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.deepOrange),
                                            ),
                                            Text(
                                              snapshot.data.lastName != null
                                                  ? snapshot.data.lastName
                                                  : "",
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Container(
                                height: 300,
                                width: 350,
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: SafeArea(
                                      child: Form(
                                        key: globalFormKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "Edit profile",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green),
                                            ),
                                            SizedBox(height: 10.0),
                                            TextFormField(
                                              autofocus: false,
                                              keyboardType: TextInputType.text,
                                              onSaved: (input) {
                                                return profileModel.firstName =
                                                    input;
                                              },
                                              validator: (input) {
                                                return input.isEmpty
                                                    ? "Enter your name"
                                                    : null;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'First Name',
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 10.0, 20.0, 10.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0)),
                                              ),
                                            ),
                                            SizedBox(height: 10.0),
                                            TextFormField(
                                              autofocus: false,
                                              onSaved: (input) {
                                                return profileModel.firstName =
                                                    input;
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Last Name',
                                                contentPadding:
                                                    EdgeInsets.fromLTRB(
                                                        20.0, 10.0, 20.0, 10.0),
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12.0)),
                                              ),
                                            ),
                                            SizedBox(height: 50.0),
                                            OutlinedButton(
                                                style: OutlinedButton.styleFrom(
                                                    minimumSize: Size(400, 40),
                                                    primary: Colors.white,
                                                    backgroundColor:
                                                        Colors.orange),
                                                onPressed: () async {
                                                  if (validateAndSave()) {
                                                    print(
                                                        profileModel.toJson());

                                                    await APIService()
                                                        .updateDataGetRequest(
                                                            _token,
                                                            profileModel);
                                                  }
                                                },
                                                child: Text("Update")),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          );
                        } else if (snapshot.hasError) {
                          return Text('${snapshot.error}');
                        }
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
                ],
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
