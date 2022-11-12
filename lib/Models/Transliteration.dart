// To parse this JSON data, do
//
//     final kanas = kanasFromJson(jsonString);

import 'dart:convert';

Map<String, List<Transliteration>> kanasFromJson(String str) => Map.from(json.decode(str)).map((k, v) => MapEntry<String, List<Transliteration>>(k, List<Transliteration>.from(v.map((x) => Transliteration.fromJson(x)))));

String kanasToJson(Map<String, List<Transliteration>> data) => json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, List<dynamic>.from(v.map((x) => x.toJson())))));

class Transliteration {
  Transliteration({
    this.system,
    this.value,
  });

  System? system;
  String? value;

  factory Transliteration.fromJson(Map<String, dynamic> json) => Transliteration(
    system: systemValues.map[json["system"]],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "system": systemValues.reverse[system],
    "value": value,
  };
}

enum System { Romaji, Bondarenko, Nakazawa, Fedorishyn, Gojuon, Kovalenko, Ruble, DibrovaOdinets, Polivanov }

final systemValues = EnumValues({
  "Бондаренко": System.Bondarenko,
  "Накадзава": System.Nakazawa,
  "Федоришин": System.Fedorishyn,
  "Система Ґоджюон": System.Gojuon,
  "Коваленко": System.Kovalenko,
  "Rōmaji": System.Romaji,
  "Рубель": System.Ruble,
  "Діброва-Одинець": System.DibrovaOdinets,
  "Поливанова": System.Polivanov
});

class EnumValues<T> {
  late Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    return reverseMap;
  }
}
