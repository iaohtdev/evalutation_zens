import 'dart:convert';

import 'package:evalutation_zens/gen/assets.gen.dart';
import 'package:evalutation_zens/model/drink_model.dart';
import 'package:evalutation_zens/model/option_model.dart';
import 'package:flutter/material.dart';

class DrinkRepository {
  static Future<List<T>> _fetchData<T>(BuildContext context,
      String jsonAssetPath, T Function(dynamic) fromJson) async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString(jsonAssetPath);
    final List<dynamic> parsedJson = json.decode(jsonString);
    return parsedJson.map((json) => fromJson(json)).toList();
  }

  static Future<List<DrinkModel>> fetchDrinks(BuildContext context) async {
    return _fetchData<DrinkModel>(
      context,
      Assets.json.drinkJson,
      (json) => DrinkModel.fromJson(json),
    );
  }

  static Future<List<OptionModel>> fetchSize(BuildContext context) async {
    return _fetchData<OptionModel>(
      context,
      Assets.json.sizeJson,
      (json) => OptionModel.fromJson(json),
    );
  }

  static Future<List<OptionModel>> fetchOption(BuildContext context) async {
    return _fetchData<OptionModel>(
      context,
      Assets.json.optionJson,
      (json) => OptionModel.fromJson(json),
    );
  }

  static Future<List<OptionModel>> fetchTopping(BuildContext context) async {
    return _fetchData<OptionModel>(
      context,
      Assets.json.toppingJson,
      (json) => OptionModel.fromJson(json),
    );
  }
}
