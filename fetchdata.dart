import 'dart:convert';
import 'package:http/http.dart' as http;

import 'RecipeModel.dart';

class DataFetcher {
  static Future<List<RecipeModel>> fetchData(String query) async {
    List<RecipeModel> recipeList = [];
    String url =
        "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";

    http.Response response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
    });

    return recipeList;
  }
}
