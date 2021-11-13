class ProfileModel {
  String name;
  String firstName;
  String lastName;

  ProfileModel({this.name, this.firstName, this.lastName});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'] != null ? json['name'] : '';
    firstName = json['first_name'] != null ? json['first_name'] : 'name';
    lastName = json['last_name'] != null ? json['last_name'] : 'aame';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    // data['name'] = this.name;
    return data;
  }
}
