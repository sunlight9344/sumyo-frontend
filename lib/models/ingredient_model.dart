class Ingredient {
  String? ingredient;
  int quantity = 0;
  String? date;

  Ingredient(
      {required this.ingredient,
      required this.quantity,
      this.date="2023"});

  Ingredient.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'];
    quantity = json['quantity'];
    date = json['date'];
  }

  // parse SampleModel to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ingredient'] = ingredient;
    data['quantity'] = quantity;
    data['date'] = date;
    return data;
  }
}
