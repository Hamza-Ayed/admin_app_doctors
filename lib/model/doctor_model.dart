class DoctorModel {
  String name;
  String email;
  String site;
  String city;
  String phone;

  DoctorModel(
    this.city,
    this.email,
    this.name,
    this.phone,
    this.site,
  );
}

class Doctors {
  String? id;
  String? name;
  String? site;
  String? city;
  String? phone;
  String? email;

  Doctors({this.id, this.name, this.site, this.city, this.phone, this.email});

  Doctors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    site = json['site'];
    city = json['city'];
    phone = json['phone'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['site'] = site;
    data['city'] = city;
    data['phone'] = phone;
    data['email'] = email;
    return data;
  }
}
