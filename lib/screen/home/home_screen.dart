import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:evalutation_zens/gen/assets.gen.dart';
import 'package:evalutation_zens/model/drink_model.dart';
import 'package:evalutation_zens/repo/drink_repo.dart';
import 'package:evalutation_zens/routers/app_routes.dart';
import 'package:evalutation_zens/screen/home/widgets/header_home.dart';
import 'package:evalutation_zens/utils/convert/app_convert.dart';
import 'package:evalutation_zens/utils/style/app_color.dart';
import 'package:evalutation_zens/utils/style/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> items = [
    'Phổ biến',
    'Mua nhiều',
    'Giá rẻ',
  ];

  ValueNotifier<String?> selectedValue = ValueNotifier<String?>(null);
  ValueNotifier<List<DrinkModel>> drinksNotifier =
      ValueNotifier<List<DrinkModel>>([]);
  List<DrinkModel> lstDrinks = [];
  ValueNotifier<int> countCurrentCart = ValueNotifier<int>(0);
  @override
  void initState() {
    fetchData(context).then((data) {
      lstDrinks = data;
      drinksNotifier.value = lstDrinks;
    });
    super.initState();
  }

  Future<List<DrinkModel>> fetchData(BuildContext context) async {
    return await DrinkRepository.fetchDrinks(context);
  }

  void sortListBy(String? value) {
    switch (value) {
      case 'Phổ biến':
        lstDrinks.sort((a, b) => b.favorite.compareTo(a.favorite));
        break;
      case 'Mua nhiều':
        lstDrinks.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case 'Giá rẻ':
        lstDrinks.sort((a, b) => a.salePrice.compareTo(b.salePrice));
        break;
      default:
        lstDrinks.sort((a, b) => b.favorite.compareTo(a.favorite));

        break;
    }
    drinksNotifier.value = List.from(lstDrinks);
  }

  void onAddToCart() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Đã thêm đơn hàng'),
      duration: Duration(seconds: 1),
    ));

    countCurrentCart.value++;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HeaderHome(),
            const SizedBox(
              height: 70,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _sort(),
                    const SizedBox(
                      height: 10,
                    ),
                    _lstDrink(context)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _sort() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              'Tìm kiếm theo:',
              style: AppTextStyles.textStyle(),
            ),
            const SizedBox(
              width: 10,
            ),
            ValueListenableBuilder<String?>(
              valueListenable: selectedValue,
              builder: (context, value, child) {
                return DropdownButtonHideUnderline(
                  child: DropdownButton2<String>(
                    isExpanded: true,
                    dropdownStyleData: const DropdownStyleData(width: 120),
                    customButton: SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            value ?? items[0],
                            style: AppTextStyles.textStyle(
                              fontSize: 14,
                              color: AppColor.orange,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.expand_more_rounded,
                            color: AppColor.gray,
                          ),
                        ],
                      ),
                    ),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item,
                            style: AppTextStyles.textStyle(fontSize: 16)),
                      );
                    }).toList(),
                    value: value,
                    onChanged: (String? newValue) {
                      selectedValue.value = newValue;
                      sortListBy(newValue);
                    },
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  color: const Color(0xffD3D1D8).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(5, 10),
                )
              ], color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: SvgPicture.asset(Assets.icons.iconCart),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: ValueListenableBuilder<int>(
                valueListenable: countCurrentCart,
                builder: (context, count, child) {
                  return Container(
                    height: 14,
                    width: 14,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Center(
                      child: Text(
                        count.toString(),
                        style: AppTextStyles.textStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                            color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Widget _lstDrink(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<DrinkModel>>(
        valueListenable: drinksNotifier,
        builder: (context, value, child) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: value.length,
            itemBuilder: (context, index) {
              final item = value[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, Routes.order, arguments: {
                    'item': item,
                    'count': countCurrentCart.value
                  });
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xffD3D1D8).withOpacity(0.25),
                        blurRadius: 36,
                        offset: const Offset(18, 18),
                      )
                    ],
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Stack(
                            children: [
                              SizedBox(
                                height: 200,
                                width: MediaQuery.sizeOf(context).width,
                                child: Image.asset(
                                  item.img,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                left: 16,
                                top: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(24)),
                                  child: Text(
                                    AppConvert.formatMoney(item.salePrice),
                                    style: AppTextStyles.textStyle(
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 16,
                                top: 16,
                                child: GestureDetector(
                                  onTap: () {
                                    item.isFavorite.value =
                                        !item.isFavorite.value;
                                  },
                                  child: ValueListenableBuilder<bool>(
                                    valueListenable: item.isFavorite,
                                    builder: (context, isFavorite, child) {
                                      return Container(
                                        width: 32,
                                        height: 32,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isFavorite
                                              ? Icons.favorite
                                              : Icons.favorite_border_outlined,
                                          size: 22,
                                          color: AppColor.orange,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.name,
                              style: AppTextStyles.textStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                            Text(
                              item.description,
                              style: AppTextStyles.textStyle(
                                  fontSize: 14, color: AppColor.gray),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star_rate_rounded,
                                          color: AppColor.yellow,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          item.rating.toString(),
                                          style: AppTextStyles.textStyle(
                                              fontSize: 14,
                                              color: AppColor.gray),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 32,
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                        const SizedBox(width: 2),
                                        Text(
                                          AppConvert.formatLikes(item.favorite),
                                          style: AppTextStyles.textStyle(
                                              fontSize: 14,
                                              color: AppColor.gray),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    onAddToCart();
                                  },
                                  child: Container(
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(
                                              0,
                                              8.5,
                                            ),
                                            blurRadius: 18,
                                            color: AppColor.orange
                                                .withOpacity(0.4))
                                      ],
                                      color: AppColor.orange,
                                      borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
