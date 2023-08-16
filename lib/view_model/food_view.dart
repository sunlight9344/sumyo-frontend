import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/food_model.dart';
import '../pages/food_info_page.dart';
import '../providers/ingredient_provider.dart';

class FoodViewModel extends StatelessWidget {
  final List<Food> foods;
  final bool isFavoritePage;

  FoodViewModel({required this.foods,required this.isFavoritePage});

  countMatchingIngredients(Food food,IngredientProvider ingredientProvider) {
    int count = 0;
    for (var ingredient in ingredientProvider.ingredients) {
      for (var foodIngredient in food.ingredients!) {
        if (foodIngredient.name == ingredient.ingredient) {
          count++;
        }
      }
    }
    var result = (count/food.ingredients!.length)*100;
    var out = result.ceil();
    return out;
  }

  @override
  Widget build(BuildContext context) {

    var ingredientProvider = Provider.of<IngredientProvider>(context);

    return ListView.builder(
      itemCount: foods.length,
      itemBuilder: (context, i) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset(1, 1),
            ),
          ],
        ),
        margin: EdgeInsets.only(bottom: 15, left: 10, right: 10),
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FoodInfoPage(food: foods[i],isFavoritePage:isFavoritePage),
              ),
            );
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0), // 모서리 둥글기 지정
                child: Image.network(
                  foods[i].image_route!,
                  fit: BoxFit.fill,
                  height: 90,
                  width: 90,
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(foods[i].name.toString(),
                        style:TextStyle(
                          fontSize:15,
                          fontWeight:FontWeight.w900,
                          color:Color(0xFF484052),
                        )
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.whatshot, color: Colors.red),
                        const SizedBox(width:5),
                        Text(
                            isFavoritePage
                                ? '재료 보유율: ' + countMatchingIngredients(foods[i],ingredientProvider).toString()+'%'
                                :'재료 보유율: ' + foods[i].percent.toString() + '%',
                            style:TextStyle(
                              fontSize:13,
                              fontWeight:FontWeight.w700,
                              color:Color(0xFF434052),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
