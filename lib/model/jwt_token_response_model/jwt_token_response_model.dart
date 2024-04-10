class JwtTokeResponseModel {
  String? name;
  int? userId;
  String? groupId;

  String? phoneNumber;
  Role? role;
  int? iat;
  int? exp;

  JwtTokeResponseModel({
    this.name,
    this.userId,
    this.phoneNumber,
    this.role,
    this.iat,
    this.groupId,
    this.exp,
  });

  factory JwtTokeResponseModel.fromJson(Map<String, dynamic> json) =>
      JwtTokeResponseModel(
        name: json["name"],
        userId: json["userId"],
        groupId: json["groupId"],
        phoneNumber: json["phoneNumber"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
        iat: json["iat"],
        exp: json["exp"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "userId": userId,
        "groupId": groupId,
        "phoneNumber": phoneNumber,
        "role": role?.toJson(),
        "iat": iat,
        "exp": exp,
      };
}

class Role {
  int? roleId;
  String? name;
  List<String>? permissions;

  Role({
    this.roleId,
    this.name,
    this.permissions,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["roleId"],
        name: json["name"],
        permissions: json["permissions"] == null
            ? []
            : List<String>.from(json["permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "roleId": roleId,
        "name": name,
        "permissions": permissions == null
            ? []
            : List<dynamic>.from(permissions!.map((x) => x)),
      };
}
