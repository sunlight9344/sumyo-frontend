import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'food_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/mydog_default.png',
              height: 130, // 원하는 이미지 높이 설정
              width: 130, // 원하는 이미지 너비 설정
            ),
            const SizedBox(height: 20),
            Text("오늘은 어떤 음식이 좋을까요?",
                style:TextStyle(
                    fontSize:20,
                    fontWeight:FontWeight.w700,
                    color:Color(0xFF192E51)
                )
            ),
            const SizedBox(height: 50),
            Container(
              height: 60,
              width: 270,
              child: MaterialButton(
                color: Color(0xFF2B4F8A),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text('음식 추천 받기',
                    style:TextStyle(
                      fontSize:18,
                      fontWeight:FontWeight.w700,
                      color:Color(0xFFFDF8F8)
                    )
                ),
                onPressed: () {
                  //Provider.of<TabProvider>(context, listen: false).selectedIndex = 3;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodPage(),
                    ),
                  );
                },
              ),
            ),
            // ElevatedButton(
            //   child: Text('Ingredient Page'),
            //   onPressed: () {
            //     Provider.of<TabProvider>(context, listen: false).selectedIndex = 1;
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
