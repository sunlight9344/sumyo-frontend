import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorite_provider.dart';
import '../view_model/food_view.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<FavoriteProvider>().getFavorite();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<FavoriteProvider>(
        builder: (ctx, FavoriteProvider, _) => Column(
              children: [
                const SizedBox(height: 60),
                Container(
                    height: 200,
                    child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/mydog.png',
                              height: 130, // 원하는 이미지 높이 설정
                              width: 130, // 원하는 이미지 너비 설정
                            ),
                            Text("찜 목록!",
                                style:TextStyle(
                                    fontSize:20,
                                    fontWeight:FontWeight.w700,
                                    color:Color(0xFF192E51)
                                )
                            ),
                          ],
                        ))),
                Expanded(
                  child: FoodViewModel(foods: FavoriteProvider.favorites,isFavoritePage:true),
                ),
              ],
            ),
      ),
    );
  }
}
