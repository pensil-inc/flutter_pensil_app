import 'dart:convert';

class ActorModel {
    ActorModel({
        this.name,
        this.email,
        this.password,
        this.role,
        this.mobile,
        this.token
    });

    final String name;
    final String email;
    final String password;
    final String role;
    final String mobile;
    final String token;

    factory ActorModel.fromRawJson(String str) => ActorModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ActorModel.fromJson(Map<String, dynamic> json) => ActorModel(
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        role: json["role"] == null ? null : json["role"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        token: json["token"] == null ? null : json["token"],
    );
    
    Map<String, dynamic> toJson() => {
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "role": role == null ? null : role,
        "mobile": mobile == null ? null : mobile,
        "token": token == null ? null : token,
    };

    factory ActorModel.fromError(Map<String,dynamic> json) => ActorModel(
       password:json.containsKey("password") ? json["password"][0] : null,
       email: json.containsKey("email") ? json["email"][0] : null,
       mobile: json.containsKey("mobile") ? json["mobile"][0] : null
    );
}
