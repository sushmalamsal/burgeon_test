class GetModel {
  bool? success;
  Data? data;

  GetModel({this.success, this.data});

  GetModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? name;
  String? image;
  String? address;
  List<Schools>? schools;

  Data({this.name, this.image, this.address, this.schools});

  Data.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    address = json['address'];
    if (json['schools'] != null) {
      schools = <Schools>[];
      json['schools'].forEach((v) {
        schools!.add(Schools.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    data['address'] = address;
    if (schools != null) {
      data['schools'] = schools!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Schools {
  String? name;
  String? code;
  String? address;
  String? email;
  String? contactNumber;
  List<String>? coverImages;
  String? location;
  SocialLinks? socialLinks;

  Schools(
      {this.name,
      this.code,
      this.address,
      this.email,
      this.contactNumber,
      this.coverImages,
      this.location,
      this.socialLinks});

  Schools.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    code = json['code'];
    address = json['address'];
    email = json['email'];
    contactNumber = json['contactNumber'];
    coverImages = json['coverImages'].cast<String>();
    location = json['location'];
    socialLinks = json['socialLinks'] != null
        ? SocialLinks.fromJson(json['socialLinks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['code'] = code;
    data['address'] = address;
    data['email'] = email;
    data['contactNumber'] = contactNumber;
    data['coverImages'] = coverImages;
    data['location'] = location;
    if (socialLinks != null) {
      data['socialLinks'] = socialLinks!.toJson();
    }
    return data;
  }
}

class SocialLinks {
  String? others;
  String? facebook;
  String? website;

  SocialLinks({
    this.facebook,
    this.website,
    this.others,
  });

  SocialLinks.fromJson(Map<String, dynamic> json) {
    facebook = json['Facebook'];
    website = json['Website'];
    others = json['Others'];
    facebook = json['facebook'];
    website = json['website'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Facebook'] = facebook;
    data['Website'] = website;
    data['Others'] = others;
    data['facebook'] = facebook;
    data['website'] = website;
    return data;
  }
}
