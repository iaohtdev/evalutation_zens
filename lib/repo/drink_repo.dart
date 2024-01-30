import 'dart:convert';

import 'package:evalutation_zens/gen/assets.gen.dart';
import 'package:evalutation_zens/model/drink_model.dart';
import 'package:evalutation_zens/model/option_model.dart';
import 'package:flutter/material.dart';

class DrinkRepository {
  static Future<List<DrinkModel>> fetchDrinks(BuildContext context) async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString(Assets.json.drinkJson);
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => DrinkModel.fromJson(json)).toList();
  }

  static Future<List<OptionModel>> fetchSize(BuildContext context) async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString(Assets.json.sizeJson);
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => OptionModel.fromJson(json)).toList();
  }

  static Future<List<OptionModel>> fetchOption(BuildContext context) async {
    String jsonString =
        await DefaultAssetBundle.of(context).loadString(Assets.json.optionJson);
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => OptionModel.fromJson(json)).toList();
  }

  static Future<List<OptionModel>> fetchTopping(BuildContext context) async {
    String jsonString = await DefaultAssetBundle.of(context)
        .loadString(Assets.json.toppingJson);
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => OptionModel.fromJson(json)).toList();
  }
}
