import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/food_provider.dart';
import '../view_model/food_view.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<FoodProvider>(context).getFoods().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();

  }

  @override
  void initState() {
    super.initState();
    // widget 이 모두 렌더링된 이후에 data 를 받아옴

    // widget 이 렌더링되기 전에 data 를 받아오면
    // build 중 setState 가 호출될 가능성이 있기 때문에 반드시 widget build 가 완료되고 데이터를 받아와야 함
    Future.microtask(() {
      context.read<FoodProvider>().getFoods();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Consumer<FoodProvider>(
        builder: (context, foodProvider, _) => Column(
          children: [
            const SizedBox(height: 59),
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
                        Text("오늘의 추천 음식이에요!",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF192E51))),
                      ],
                    ))),
            Expanded(
              child: FoodViewModel(
                foods: foodProvider.foods,
                isFavoritePage: false,
              ),
            ),
          ],
        ),
      ),
      //bottomNavigationBar: MyBar(),
    );
  }

}
