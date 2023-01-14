import 'dart:convert';

List<Heroes> employeeFromJson(String str) =>
    List<Heroes>.from(json.decode(str).map((x) => Heroes.fromJson(x)));

String employeeToJson(List<Heroes> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Heroes {
  String? id;
  String? name;
  String? desc;
  String? tipus;
  String? imatge;

  Heroes({
    this.id,
    this.name,
    this.desc,
    this.tipus,
    this.imatge,
  });

  factory Heroes.fromJson(Map<String, dynamic> json) => Heroes(
        id: json["id"],
        name: json["name"],
        desc: json["desc"],
        tipus: json["tipus"],
        imatge: json["imatge"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "desc": desc,
        "tipus": tipus,
        "imatge": imatge,
      };
  
}
