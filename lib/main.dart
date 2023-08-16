import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:v2/pages/favorite_page.dart';
import 'package:v2/pages/food_page.dart';
import 'package:v2/pages/home_page.dart';
import 'package:v2/providers/favorite_provider.dart';
import 'package:v2/providers/tab_provider.dart';
import 'package:v2/providers/token_provider.dart';
import 'package:v2/repositories/favorite_repository.dart';
import 'package:v2/repositories/food_repository.dart';
import 'package:v2/repositories/ingredient_repository.dart';
import 'package:v2/repositories/token_repository.dart';
import '../providers/food_provider.dart';
import '../providers/ingredient_provider.dart';
import '../pages/ingredient_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => FoodProvider(
                  foodRepository: FoodRepository(),
                )
        ),
        ChangeNotifierProvider(
            create: (context) => IngredientProvider(
                  ingredientRepository: IngredientRepository(),
                )
        ),
        ChangeNotifierProvider(
            create: (context) =>
                FavoriteProvider(favoriteRepository: FavoriteRepository(),
                )
        ),
        ChangeNotifierProvider(create: (context) => TabProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                TokenProvider(tokenRepository: TokenRepository())
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'NotoSansKR',
          primarySwatch: MaterialColor(0xFF2B4F8A, <int, Color>{
            50: Color(0xFFFBFCFF),
            100: Color(0xFFE9EBF8),
            200: Color(0xFFE3EDFB),
            300: Color(0xFFC6D9F7),
            400: Color(0xFF4784E6),
            500: Color(0xFF4077CF),
            600: Color(0xFF3563AD),
            700: Color(0xFF2B4F8A),
            800: Color(0xFF203B67),
            900: Color(0xFF192E51),
          }),
          primaryColor: Color(0xFF2B4F8A),
          hintColor: Colors.redAccent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: Color(0xFFFBFCFF),
        ),
        home: MyWidget(), // 홈스크린을 설정합니다.
        routes: {
          '/ingredient': (context) => IngredientPage(),
          '/food': (context) => FoodPage(),
        },
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 앱의 body 부분
      body: Center(
        child: TabPage(),
      ),
    );
  }
}

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TokenProvider>().fetchToken();
    });
  }

  List<Widget> _pages = [
    HomePage(),
    IngredientPage(),
    FavoritePage(),
    FoodPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(builder: (context, tabIndex, child) {
      return Scaffold(
        body: Center(
          child: _pages[tabIndex.selectedIndex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          onTap: (index) {
            tabIndex.selectedIndex = index;
          },
          currentIndex: tabIndex.selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Colors.black),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.kitchen_outlined, color: Colors.black),
              label: 'Ingredients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border, color: Colors.black),
              label: 'Food',
            ),
          ],
        ),
      );
    });
  }
}
