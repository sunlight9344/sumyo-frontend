import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import '../models/ingredient_model.dart';
import '../repositories/ingredient_repository.dart';

class IngredientProvider with ChangeNotifier {
  final IngredientRepository ingredientRepository;
  List<Ingredient> _ingredients = [];
  IngredientProvider({required this.ingredientRepository});

  List<Ingredient> get ingredients => _ingredients;

  Future<void> getIngredients() async {
    _ingredients = await ingredientRepository.fetchIngredients();
    notifyListeners();
  }

  Future<void> captureAndUploadImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final detectedIngredients = await ingredientRepository.detectIngredientsFromImage(image);

    for (var ingredientName in detectedIngredients) {
      addOrUpdateIngredient(ingredientName, 1);
    }
  }

  void removeIngredient(int index) async {
    if (index < 0 || index >= _ingredients.length) return;
    await ingredientRepository.deleteIngredient(_ingredients[index].ingredient!);
    await getIngredients();
  }

  void incrementQuantity(int index) {
    if (index < 0 || index >= _ingredients.length) return;
    addOrUpdateIngredient(_ingredients[index].ingredient,_ingredients[index].quantity+1);
  }

  void decrementQuantity(int index) {
    if (index < 0 || index >= _ingredients.length) return;
    if (_ingredients[index].quantity > 0) {
      addOrUpdateIngredient(_ingredients[index].ingredient,_ingredients[index].quantity-1);
    }
  }

  void addOrUpdateIngredient(String? name, int quantity) async {
    bool isExistingIngredient = false;
    for (var ingredient in _ingredients) {
      if (ingredient.ingredient == name) {
        isExistingIngredient = true;
        await ingredientRepository.updateIngredient(name!,quantity);
        break;
      }
    }
    // if (!isExistingIngredient) {
    //   final newIngredient = Ingredient(name: name, quantity: quantity, imageUrl: '');
    //   _ingredients.add(newIngredient);
    //   await ingredientRepository.addIngredient(newIngredient);
    // }
    if (!isExistingIngredient) {
      final newIngredient = Ingredient(ingredient: name, quantity: quantity);
      //_ingredients.add(newIngredient);
      await ingredientRepository.addIngredient(newIngredient);
    }
    await getIngredients();
  }

  void sortByQuantity() {
    _ingredients.sort((a, b) => b.quantity.compareTo(a.quantity));
    notifyListeners();
  }

  void sortByTime() {
    //_ingredients.sort((a, b) => a.date).compareTo(b.date));
    notifyListeners();
  }
}
