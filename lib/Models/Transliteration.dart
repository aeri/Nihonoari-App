/*
    Copyright (C) 2020 Naval Alcalá

    This file is part of Nihonoari.

    Nihonoari is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    Nihonoari is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with Nihonoari.  If not, see <https://www.gnu.org/licenses/>.
 */

import 'dart:convert';

Map<String, List<Transliteration>> kanasFromJson(String str) => Map.from(
        json.decode(str))
    .map((k, v) => MapEntry<String, List<Transliteration>>(k,
        List<Transliteration>.from(v.map((x) => Transliteration.fromJson(x)))));

String kanasToJson(Map<String, List<Transliteration>> data) =>
    json.encode(Map.from(data).map((k, v) => MapEntry<String, dynamic>(
        k, List<dynamic>.from(v.map((x) => x.toJson())))));

class Transliteration {
  Transliteration({
    this.system,
    this.value,
  });

  System? system;
  String? value;

  factory Transliteration.fromJson(Map<String, dynamic> json) =>
      Transliteration(
        system: systemValues.map[json["system"]],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "system": systemValues.reverse[system],
        "value": value,
      };
}

enum System {
  Romaji,
  Bondarenko,
  Nakazawa,
  Fedorishyn,
  Gojuon,
  Kovalenko,
  Ruble,
  DibrovaOdinets,
  Polivanov
}

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
