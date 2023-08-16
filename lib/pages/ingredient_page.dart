import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import '../providers/ingredient_provider.dart';

class IngredientPage extends StatefulWidget {
  const IngredientPage({super.key});

  @override
  State<IngredientPage> createState() => _IngredientPageState();
}

class _IngredientPageState extends State<IngredientPage> {
  String dropdownValue = '등록순';

  List<bool> _isSelected = [true, false, false];

  @override
  void initState() {
    super.initState();
    // widget 이 모두 렌더링된 이후에 data 를 받아옴

    // widget 이 렌더링되기 전에 data 를 받아오면
    // build 중 setState 가 호출될 가능성이 있기 때문에 반드시 widget build 가 완료되고 데이터를 받아와야 함
    Future.microtask(() {
      context.read<IngredientProvider>().getIngredients();
    });
  }

  void sortIngredients(IngredientProvider ingredientProvider, int index) {
    if (index == 0) {
      ingredientProvider.sortByTime();
    } else if (index == 1) {
      ingredientProvider.sortByQuantity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IngredientProvider>(
        builder: (ctx, ingredientProvider, _) => Column(
          children: [
            SizedBox(height: 100),
            Container(
              height: 115,
              padding: const EdgeInsets.only(bottom: 40.0, top: 40),
              child: ToggleButtons(
                borderColor: Colors.grey,
                fillColor: Color(0xFFE9EBF8),
                borderWidth: 1.2,
                selectedBorderColor: Colors.black,
                selectedColor: Colors.black,
                borderRadius: BorderRadius.circular(50),
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    width: 110,
                    //padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '등록순',
                        style:TextStyle(
                            fontSize:15,
                            fontWeight:FontWeight.w500,
                            color:Color(0xFF203B67),
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 110,
                    //padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '보유량순',
                        style:TextStyle(
                          fontSize:15,
                          fontWeight:FontWeight.w500,
                          color:Color(0xFF203B67),
                        )
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: 110,
                    //padding: const EdgeInsets.all(15.0),
                    child: Text(
                      '유통기한순',
                        style:TextStyle(
                          fontSize:15,
                          fontWeight:FontWeight.w500,
                          color:Color(0xFF203B67),
                        )
                    ),
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    for (int i = 0; i < _isSelected.length; i++) {
                      _isSelected[i] = i == index;
                    }
                    sortIngredients(ingredientProvider, index);
                  });
                },
                isSelected: _isSelected,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: ingredientProvider.ingredients.length,
                itemBuilder: (ctx, i) => Container(
                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
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
                  height: 70,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 20, right: 20),
                        child: Dismissible(
                          key: Key(ingredientProvider.ingredients[i].ingredient
                              .toString()),
                          onDismissed: (direction) {
                            // 해당 ListTile을 삭제하는 로직을 구현합니다.
                            ingredientProvider.removeIngredient(i);
                          },
                          child: ListTile(
                            title: Text(ingredientProvider.ingredients[i].ingredient
                                .toString(),
                                style:TextStyle(
                                  fontSize:15,
                                  fontWeight:FontWeight.w700,
                                  color:Color(0xFF203B67),
                                )
                            )
                            ,
                            // leading: Image.network(ingredientProvider.ingredients[i].imageUrl.toString()),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(width: 8.0),
                                IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () {
                                    ingredientProvider.decrementQuantity(i);
                                  },
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  ingredientProvider.ingredients[i].quantity
                                          .toString(),
                                  style:TextStyle(
                                    fontSize:20,
                                    fontWeight:FontWeight.w700,
                                    color:Color(0xFF203B67),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add),
                                  onPressed: () {
                                    ingredientProvider.incrementQuantity(i);
                                  },
                                ),
                              ],
                            ),
                          ),
                          background: Container(
                            color: Colors.red,
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Color(0xFF2B4F8A),
        children: [
          SpeedDialChild(
            child: Icon(Icons.camera_alt),
            label: "사진 촬영",
            labelStyle: TextStyle(
                          fontSize:20,
                          fontWeight:FontWeight.w500,
                          color:Color(0xFF192E51),
                        ),
            onTap: () {
              Provider.of<IngredientProvider>(context, listen: false)
                  .captureAndUploadImage();
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.edit),
            label: "직접 입력",
            labelStyle: TextStyle(
              fontSize:20,
              fontWeight:FontWeight.w500,
              color:Color(0xFF192E51),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => IngredientInputDialog(),
              );
            },
          ),
        ],
      ),
      //bottomNavigationBar: MyBar(),
    );
  }
}

class IngredientInputDialog extends StatefulWidget {
  @override
  _IngredientInputDialogState createState() => _IngredientInputDialogState();
}

class _IngredientInputDialogState extends State<IngredientInputDialog> {
  String? _ingredientName;
  int _quantity = 0;

  final List<String> _ingredientNameOptions = [
    "조선부추",
    "날콩가루  저염간장",
    "다진 대파",
    "흰 후추 약간",
    "오이",
    "요리당",
    "식용유  오렌지즙",
    "참깨 약간",
    "감자",
    "방울토마토",
    "멸치액젓",
    "발사믹식초",
    "매실액",
    "호박",
    "통깨 약간",
    "청양고추",
    "다진 땅콩  순두부",
    "사과",
    "북엇국북어채",
    "부추  고춧가루",
    "국간장",
    "발사믹크레마",
    "황태해장국황태",
    "배",
    "모시조개",
    "물",
    "빨강 파프리카",
    "된장국두부",
    "애느타리버섯",
    "노랑 파프리카",
    "양파",
    "다시마",
    "무",
    "국물용 멸치",
    "다시마 장",
    "표고버섯 기둥",
    "아몬드",
    "물  청경채",
    "소금",
    "치커리",
    "적양배추",
    "꿀",
    "당근  올리브유",
    "간장",
    "브로콜리",
    "스트로베리 샐러드딸기",
    "양상추",
    "새우",
    "오렌지",
    "식초 약간",
    "소금 약간",
    "시금치우유 소스",
    "닭 가슴살",
    "후춧가루",
    "크랜베리",
    "치커리 약간 시금치",
    "홍고추",
    "올리브유  치커리  연두부",
    "다진 양파",
    "다진 오이피클",
    "올리브유",
    "마늘",
    "가지",
    "당근",
    "올리브유 약간 저염간장",
    "콩나물",
    "메추리알",
    "새송이버섯",
    "컬리플라워",
    "적양파",
    "강낭콩",
    "건포도 알",
    "호두 /알",
    "소금 약간 두유",
    "돼지고기",
    "설탕 약간",
    "오렌지 당근펀치당근",
    "두부",
    "소면",
    "저염소금",
    "식초  석류  잣",
    "호두",
    "해바라기씨",
    "토마토",
    "호박씨",
    "쪽파",
    "저염간장",
    "미나리",
    "볶은 흑임자",
    "호두 ●장식오이",
    "실곤약",
    "돌나물",
    "주재료만두피",
    "파",
    "소면  함초",
    "노루궁뎅이버섯",
    "양배추",
    "식초",
    "검은콩",
    "청피망",
    "냉이",
    "간장  달걀",
    "베이컨",
    "실고추",
    "된장",
    "쌀뜨물",
    "참기름",
    "다진 마늘",
    "청고추",
    "미니새송이버섯",
    "떡국 떡",
    "스팸",
    "다진 생강",
    "김치",
    "레몬즙",
    "소시지",
    "우민찌",
    "고춧가루",
    "저염된장",
    "달걀",
    "석류즙",
    "부침가루",
    "표고버섯",
    "참기름 약간 마요네즈",
    "머스터드",
    "대파",
    "참기름 약간",
    "소금  무",
    "밀가루  유자청",
    "황파프리카",
    "우유",
    "새우젓국",
    "대구살",
    "홍파프리카",
    "설탕",
    "청파프리카",
    "황금팽이버섯",
    "블루베리",
    "화이트와인  대파",
    "자색고구마",
    "숙주",
    "배추",
    "쌀",
    "소금  멥쌀",
    "물엿",
    "저염살라미",
    "사과 양파",
    "올리브오일",
    "저염국간장",
    "민들레 잎",
    "김치두부",
    "오렌지  간장",
    "다진 홍고추",
    "무순",
    "올리브오일  올리브오일",
    "배춧잎",
    "표고버섯 밑동",
    "소고기",
    "우렁이",
    "오징어",
    "붉은 고추다진 돼지고기",
    "부추",
    "고추장",
    "새우젓육수 대파",
    "양송이",
    "배추잎",
    "후춧가루두부",
    "가시오가피",
    "대추",
    "비트",
    "치자가루",
    "쇠고기",
    "호박잎",
    "인삼",
    "찹쌀",
    "밀가루",
    "황태채",
    "곤약",
    "건미역",
    "들깨가루",
    "액젓",
    "청주",
    "순두부육수 마른 다시마",
    "오리고기",
    "닭고기",
    "파슬리",
    "백김치",
    "시금치",
    "찹쌀가루",
    "후춧가루(",
    "전복",
    "함초소금",
    "해초",
    "다진마늘",
    "유자청",
    "식용꽃",
    "메밀면",
    "땅콩",
    "잣",
    "참깨",
    "산마",
    "참나물",
    "돈나물",
    "레디쉬",
    "어린잎",
    "겨자가루",
    "다진양파",
    "쑥갓완자 다진 돼지고기",
    "두부김치",
    "달걀육수 다시마",
    "마른 고추",
    "멸치마늘",
    "콩비지양념 참기름",
    "양송이버섯",
    "다진 파",
    "붉은 고추고구마",
    "쑥갓육수 무",
    "물양념 참기름",
    "멸치",
    "단호박",
    "배즙",
    "팽이버섯 다시마",
    "콩",
    "콩나물배추",
    "돼지고기쇠고기",
    "불린 당면",
    "조랭이떡다시마육수 다시마",
    "대파무",
    "마른 고추고기완자양념 생강즙",
    "다진 파다진 마늘",
    "소금(",
    "느타리버섯표고버섯",
    "레몬",
    "감자무",
    "애호박양파",
    "통깨",
    "후춧가루소금",
    "홀토마토",
    "달걀노른자육수 사골육수",
    "다시마양념 들깻가루",
    "주꾸미",
    "붉은 고추풋고추",
    "쑥갓",
    "표고버섯애호박",
    "팽이버섯당면",
    "떡육수 당귀",
    "건새우",
    "오가피",
    "함초양념장 겨자가루",
    "콩가루",
    "쌀겨",
    "통조림 햄",
    "쑥갓 다시마",
    "물 설탕",
    "순두부",
    "녹말",
    "굴",
    "물 저염된장",
    "물김치국물",
    "무양파",
    "느타리버섯",
    "순두부양념 다진 마늘",
    "청양고추백합",
    "풋고추",
    "바지락저염된장",
    "순두부 다시마",
    "팽이버섯",
    "먹물파스타",
    "토란",
    "붉은 고추",
    "파프리카",
    "바질",
    "로즈마리",
    "깻잎",
    "치즈 파슬리가루",
    "들깻가루",
    "올리브오일 곁들이 야채 : 양파",
    "가지색 파프리카",
    "발사믹소스",
    "달걀 개당근",
    "닭가슴살",
    "애호박",
    "레몬즙 탄산수",
    "생강",
    "홍고추 양념장 : 다진마늘",
    "설탕 올리고당",
    "시금치당근",
    "참기름 고명 : 볶은 현미",
    "후르츠칵테일",
    "샐러리",
    "탄산수",
    "쇠고기등심",
    "건바질 감자",
    "파슬리가루 소스 : 르네디종 홀그레인머스터",
    "오징어 마리",
    "옥수수",
    "파프리카느타리",
    "강낭콩 당근",
    "미니파프리카",
    "양파 카레가루",
    "소고기 우둔살",
    "꽈리고추",
    "양파 양념장 : 맛간장",
    "청경채누룽지",
    "어간장",
    "소고기우둔살",
    "로즈마리소금",
    "양파 화이트와인",
    "파슬리가루",
    "설탕소금",
    "후춧가루 와인",
    "버터 소스 : 맛간장",
    "커피",
    "삼겹살",
    "마늘기름",
    "후추",
    "통후추 대파",
    "꽈리고추 대파채 : 대파",
    "귀리밥",
    "아욱",
    "칵테일새우",
    "저염 된장",
    "백일송이 다진마늘",
    "다진대파",
    "양파토마토",
    "우유 생크림",
    "볶은 현미 버섯마늘소금",
    "저염간장녹말가루",
    "치즈가루",
    "라이스버거 : 밥",
    "전분가루",
    "흰후추",
    "달걀 떡갈비 : 다진소고기",
    "다진돼지고기",
    "다진쪽파",
    "생크림",
    "후추 토마토겉절이 : 토마토",
    "맛간장",
    "오이고추",
    "영양부추",
    "천일염",
    "무 해물육수",
    "어간장 고춧가루",
    "생강청",
    "생강즙",
    "밀가루달걀",
    "올리브오일 플레인요거트",
    "오이소금",
    "모짜렐라치즈",
    "달걀빵가루",
    "튀김기름",
    "코코넛밀크",
    "통마늘",
    "감자버터",
    "광어",
    "강황가루",
    "버터마늘",
    "새송이",
    "파프리카소고기",
    "후춧가루하얀된장",
    "버터",
    "월계수잎",
    "식초 아몬드",
    "달걀녹말가루",
    "백년초국수",
    "뽕잎국수치자국수",
    "튀김기름 레몬",
    "연유",
    "물다진 마늘",
    "녹말가루",
    "육수월계수잎",
    "발사믹소스 아스파라거스",
    "브로컬리새송이",
    "통삼겹살",
    "함초가루",
    "후춧가루부추",
    "버터 유자청",
    "쌈장",
    "생크림연두부",
    "다진 돼지고기",
    "다진 소고기",
    "다진 마늘로즈마리",
    "빵가루",
    "파프리카 양파",
    "플레인요거트",
    "설탕매실액",
    "녹말가루 어린잎",
    "삼치",
    "도라지",
    "연어",
    "브로컬리",
    "펜네",
    "올리브오일후춧가루 마늘",
    "방울토마토올리브오일",
    "육수",
    "또띠아",
    "생강정종",
    "사과오이",
    "올리고당",
    "닭고기살",
    "토마토두부",
    "흑임자",
    "통오징어",
    "부추견과류",
    "소금녹말가루",
    "정종",
    "당근양파",
    "통후추",
    "콜리플라워",
    "스파게티",
    "피망",
    "와사비",
    "연근",
    "계피가루",
    "식용유",
    "카레가루",
    "청포묵",
    "쌈무",
    "라이스페이퍼",
    "오곡",
    "디종머스터드",
    "콜라비",
    "오미자",
    "무화과",
    "치즈",
    "고수",
    "찬밥",
    "국멸치",
    "건다시마",
    "간 홍고추",
    "간 양파",
    "맛술",
    "굵은 고춧가루",
    "고운 고춧가루",
    "닭다리살",
    "아몬드밀가루",
    "마늘육수 닭뼈",
    "양송이버섯 밑동",
    "현미",
    "멥쌀",
    "새우가루",
    "양배추얇게 썬 쇠고기",
    "송송 썬 붉은 고추달래무침 달래",
    "저염베이컨동태포",
    "저염버터",
    "새싹채소",
    "콩고기",
    "아보카도",
    "가지연근",
    "만두피저염간장양념 저염간장",
    "설탕허브오일드레싱 저염소금",
    "통후추올리브유",
    "수박껍질",
    "가지양파",
    "아스파라거스",
    "퀴노아",
    "리코타치즈양상추",
    "플레인 요구르트",
    "어린잎채소복분자소스 복분자",
    "바나나",
    "사과과",
    "김김",
    "김",
    "고기"
  ];

  final _ingredientNameController = TextEditingController();
  final _quantityController = TextEditingController();
  late TextEditingController homeTeamName = TextEditingController();

  final FocusNode _ingredientNameFocusNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();

  @override
  void dispose() {
    _ingredientNameController.dispose();
    _quantityController.dispose();
    _ingredientNameFocusNode.dispose();
    _quantityFocusNode.dispose();
    super.dispose();
  }

  void clearField() {
    _ingredientNameController.clear();
    _quantityController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
          '재료 추가',
          style: TextStyle(
          fontSize:20,
          fontWeight:FontWeight.w700,
          color:Color(0xFF192E51),
        ),

      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          Text('이름',
            style: TextStyle(
              fontSize:15,
              fontWeight:FontWeight.w500,
              color:Color(0xFF192E51),
            ),
          ),
          Autocomplete<String>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text == '') {
                return const Iterable<String>.empty();
              }
              return _ingredientNameOptions.where((String option) {
                return option.contains(textEditingValue.text.toLowerCase());
              });
            },
            onSelected: (String selection) {
              _ingredientName = selection;
              _ingredientNameController.text = selection;
            },
            fieldViewBuilder: (context, controller, focusNode, onSubmit) {
              homeTeamName = controller;
              return TextFormField(
                  controller: controller, focusNode: focusNode);
            },
          ),
          const SizedBox(height: 20),
          Text('수량',
            style: TextStyle(
              fontSize:15,
              fontWeight:FontWeight.w500,
              color:Color(0xFF192E51),
            ),
          ),
          TextField(
            controller: _quantityController,
            focusNode: _quantityFocusNode,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _quantity = int.parse(value);
              });
            },
            //decoration: InputDecoration(labelText: '수량'),
          ),
        ],
      ),
      actions: [

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width:100,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFEAEAEA)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  '닫기',
                    style:TextStyle(
                      fontSize:15,
                      fontWeight:FontWeight.w700,
                      color:Color(0xFF192E51),
                    )
                ),
              ),
            ),
            const SizedBox(width:10),
            Container(
              width:100,
              child: ElevatedButton(
                onPressed: () {
                  if (_ingredientName != null && _quantity > 0) {
                    Provider.of<IngredientProvider>(context, listen: false)
                        .addOrUpdateIngredient(_ingredientName!, _quantity);
                    homeTeamName.clear();
                    clearField();
                    FocusScope.of(context).requestFocus(_ingredientNameFocusNode);
                  }
                },
                child: Text(
                    '업로드',
                    style:TextStyle(
                      fontSize:15,
                      fontWeight:FontWeight.w700,
                      color:Color(0xffFDF8F8),
                    )

                ),
              ),
            ),
          ],

        ),

      ],
    );
  }
}
