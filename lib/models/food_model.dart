class Food {
  late int id;
  String? image_route;
  String? name;
  late int percent;
  String? status;
  List<String>? ingredient;
  List<FoodRecipe>? recipes;
  List<FoodIngredient>? ingredients;

  Food(
      {required this.id,
      required this.image_route,
        required this.name,
        required this.percent,
        required this.status,
        required this.ingredient,
        required this.recipes,
        required this.ingredients,
      });

  Food.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image_route = json['image_route'];
    name = json['name'];
    percent = json['percent'];
    status = json['status'];
    ingredient = List<String>.from(json['ingredient']);
    if (json['recipes'] != null) {
      recipes = List<FoodRecipe>.from(
          json['recipes'].map((x) => FoodRecipe.fromJson(x)));
    }

    if (json['ingredients'] != null) {
      ingredients = List<FoodIngredient>.from(
          json['ingredients'].map((x) => FoodIngredient.fromJson(x)));
    }
  }

  // parse SampleModel to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image_route'] = image_route;
    data['name'] = name;
    data['percent'] = percent;
    data['status'] = status;
    data['ingredient'] = ingredient;
    data['recipes'] = recipes?.map((x) => x.toJson()).toList();
    data['ingredients'] = ingredients?.map((x) => x.toJson()).toList();
    return data;
  }
}

class FoodIngredient {
  String? name;

  FoodIngredient({required this.name});

  FoodIngredient.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    return data;
  }
}

class FoodRecipe {
  late int number;
  String? detail;
  String? image_route;

  FoodRecipe({required this.number, required this.detail, required this.image_route});

  FoodRecipe.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    detail = json['detail'];
    image_route = json['image_route'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['number'] = number;
    data['detail'] = detail;
    data['image_route'] = image_route;
    return data;
  }
}
