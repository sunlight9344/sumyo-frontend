import 'package:flutter/material.dart';
import '../models/food_model.dart';
import '../providers/favorite_provider.dart';
import '../providers/ingredient_provider.dart';
import 'package:provider/provider.dart';

class FoodInfoPage extends StatefulWidget {
  final Food food;
  final bool isFavoritePage;
  FoodInfoPage({required this.food,required this.isFavoritePage});

  @override
  _FoodInfoPageState createState() => _FoodInfoPageState();
}

class _FoodInfoPageState extends State<FoodInfoPage> {
  bool showDetails = false;


  @override
  Widget build(BuildContext context) {
    var ingredientProvider = Provider.of<IngredientProvider>(context);

    Map<String, int> ingredients = {};
    for (var ingredient in ingredientProvider.ingredients) {
      ingredients[ingredient.ingredient!] = ingredient.quantity;
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                height: MediaQuery.of(context).size.height / 2.5,
                width: double.infinity,
                child: Image.network(
                  widget.food.image_route!,
                  fit: BoxFit.cover,
                ),
              ),
                Positioned(
                  top: 40.0,
                  left: 20.0,
                  child: Container(
                    height:40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pop(context), // 뒤로가기 기능
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 25,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 40.0,
                  right: 15.0,
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(widget.isFavoritePage ? Icons.close : Icons.favorite),
                      onPressed: () {
                        if (widget.isFavoritePage) {
                          Provider.of<FavoriteProvider>(context, listen: false).DELFavorite(widget.food);

                        } else {
                          Provider.of<FavoriteProvider>(context, listen: false).ADDFavorite(widget.food);
                        }
                      },
                    ),
                  )
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 30.0, left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.food.name.toString(),
                      style:TextStyle(
                        fontSize:24,
                        fontWeight:FontWeight.w700,
                        color:Color(0xFF192E51),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 50,
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5, // 선의 두께
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showDetails = !showDetails;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 0, left: 30, right: 30),
                    child: Text(
                      '식재료',
                      style:TextStyle(
                        fontSize:16,
                        fontWeight:FontWeight.w500,
                        color:Color(0xFF5A5A6C),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showDetails = !showDetails;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 0.0, left: 30, right: 30),
                    child: Text('More +',
                      style:TextStyle(
                        fontSize:16,
                        fontWeight:FontWeight.w500,
                        color:Color(0xFF5A5A6C),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 20,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 0.0, left: 30, right: 30),
              child: Stack(
                children: [
                  if (!showDetails) _buildActionChipsContainer(),
                  if (showDetails) _buildDetailsContainer(),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: SizedBox(
                height: 50,
                child: Divider(
                  color: Colors.grey,
                  thickness: 0.5, // 선의 두께
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 30, right: 30, top: 0),
              child: Text('레시피',
                style:TextStyle(
                  fontSize:16,
                  fontWeight:FontWeight.w500,
                  color:Color(0xFF5A5A6C),
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: widget.food.recipes?.length ?? 0,
              itemBuilder: (context, index) {
                FoodRecipe recipe = widget.food.recipes![index];
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(bottom: 15, left: 25, right: 25),
                  padding: EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10.0), // 모서리 둥글기 지정
                          child: Image.network(
                            recipe.image_route.toString(),
                            fit: BoxFit.fill,
                            height: 90,
                            width: 90,
                          ),
                        ),
                        SizedBox(width: 15),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${recipe.number}',
                                style:TextStyle(
                                  fontSize:20,
                                  fontWeight:FontWeight.w700,
                                  color:Color(0xFF192E51),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                '${recipe.detail}',
                                style:TextStyle(
                                  fontSize:12,
                                  fontWeight:FontWeight.w700,
                                  color:Color(0xFF5A5A6C),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionChipsContainer() {
    var ingredientProvider =
        Provider.of<IngredientProvider>(context, listen: false);

    Map<String, int> ingredients = {};
    for (var ingredient in ingredientProvider.ingredients) {
      ingredients[ingredient.ingredient!] = ingredient
          .quantity; // create a map of ingredient names and quantities
    }

    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: widget.food.ingredients!.map((FoodIngredient stuff) {
        return ActionChip(
          label: Padding(
            padding: EdgeInsets.all(5.0),
            child: Text(
              '${stuff.name}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: (ingredients[stuff.name] != null &&
                          ingredients[stuff.name]! > 0)
                      ? Colors.white
                      : Color(0xFF5A5A6C)),
            ),
          ),
          backgroundColor:
              (ingredients[stuff.name] != null && ingredients[stuff.name]! > 0)
                  ? Color(0xFF2B4F8A)
                  : Color(0xFFE9EBF8),
          onPressed: () {
            print("${stuff.name} selected");
          },
        );
      }).toList(),
    );
  }

  Widget _buildDetailsContainer() {
    return Container(
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
      height: 200,
      child: Scrollbar(
        //isAlwaysShown: true,
        //controller: _scrollController,
        child: GridView.builder(
          padding: EdgeInsets.all(0), // set the padding to minimum
          scrollDirection: Axis.vertical,
          //controller: _scrollController,
          itemCount: widget.food.ingredient!.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // set the number of items per row
            mainAxisSpacing: 0.0, // set the vertical gap to minimum
            crossAxisSpacing: 0.0, // set the horizontal gap to minimum
            childAspectRatio: 7.0, // adjust this value to reduce the height
          ),
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Row(
                mainAxisSize: MainAxisSize
                    .min, // make the column occupy the least space possible
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Container(

                      child: Text(
                          widget.food.ingredient![index],
                          style:TextStyle(
                            fontSize:12,
                            fontWeight:FontWeight.w500,
                            color:Color(0xFF192E51),
                          )
                      )

                  ),
                  // Container(
                  //     child: Text(
                  //         '${widget.food.ingredients![index].quantity}',
                  //         style:TextStyle(
                  //           fontSize:12,
                  //           fontWeight:FontWeight.w500,
                  //           color:Color(0xFF192E51),
                  //         )
                  //     )
                  // ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
