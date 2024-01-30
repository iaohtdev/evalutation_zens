import 'package:evalutation_zens/gen/assets.gen.dart';
import 'package:evalutation_zens/model/drink_model.dart';
import 'package:evalutation_zens/model/option_model.dart';
import 'package:evalutation_zens/repo/drink_repo.dart';
import 'package:evalutation_zens/screen/order/widgets/banner_order.dart';
import 'package:evalutation_zens/screen/order/widgets/item_option.dart';
import 'package:evalutation_zens/utils/convert/app_convert.dart';
import 'package:evalutation_zens/utils/enum/order_type.dart';
import 'package:evalutation_zens/utils/style/app_color.dart';
import 'package:evalutation_zens/utils/style/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.itemDrink, required this.count});

  final DrinkModel itemDrink;
  final int count;
  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  DrinkModel get drink => widget.itemDrink;
  int get count => widget.count;
  late Future<List<OptionModel>> sizesFuture;
  late Future<List<OptionModel>> optionsFuture;
  late Future<List<OptionModel>> toppingsFuture;
  ValueNotifier<OptionModel?> selectedSize = ValueNotifier<OptionModel?>(null);
  ValueNotifier<OptionModel?> selectedToping =
      ValueNotifier<OptionModel?>(null);

  ValueNotifier<int> selectedSizeIndex = ValueNotifier<int>(-1);
  ValueNotifier<int> selectedOptionIndex = ValueNotifier<int>(-1);
  ValueNotifier<int> selectedToppingIndex = ValueNotifier<int>(-1);
  ValueNotifier<int> quantity = ValueNotifier<int>(1);

  double currentPrice = 0;
  ValueNotifier<double> totalPrice = ValueNotifier<double>(0);

  final noteTxtController = TextEditingController();

  @override
  void initState() {
    sizesFuture = fetchData(DrinkRepository.fetchSize);
    optionsFuture = fetchData(DrinkRepository.fetchOption);
    toppingsFuture = fetchData(DrinkRepository.fetchTopping);
    totalPrice.value = drink.salePrice;
    super.initState();
  }

  Future<List<T>> fetchData<T>(
      Future<List<T>> Function(BuildContext) fetchFunction) async {
    return fetchFunction(context);
  }

  void updatePrice(int quantity) {
    if (currentPrice == 0) {
      currentPrice = drink.salePrice;
    }
    totalPrice.value = currentPrice * quantity;
  }

  void onAddNewItem({double? price, OptionModel? model, OrderType? type}) {
    double currPrice = totalPrice.value;

    if (quantity.value != 1) {
      price = price! * quantity.value;
    }
    switch (type) {
      case OrderType.size:
        if (selectedSize.value?.price != null) {
          if (quantity.value != 1) {
            currPrice -= (selectedSize.value!.price) * quantity.value;
          } else {
            currPrice -= (selectedSize.value!.price) * quantity.value;
          }
        }
        selectedSize.value = model;
        break;
      case OrderType.topping:
        if (selectedToping.value?.price != null) {
          if (quantity.value != 1) {
            currPrice -= (selectedToping.value!.price) * quantity.value;
          } else {
            currPrice -= (selectedToping.value!.price) * quantity.value;
          }
        }
        selectedToping.value = model;

        break;
      default:
    }
    currPrice = currPrice + price!;
    totalPrice.value = currPrice;
    currentPrice = totalPrice.value;
  }

  void onRemove({
    double? price,
  }) {
    if (quantity.value != 1) {
      price = price! * quantity.value;
    }

    totalPrice.value = totalPrice.value - price!;
    currentPrice = totalPrice.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _btn(),
        body: Column(
          children: [
            BannerOrder(
              drink: drink,
              count: count,
            ),
            Expanded(
              flex: 7,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    top: -20,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 32,
                          ),
                          Text(
                            drink.name,
                            style: AppTextStyles.textStyle(
                                fontSize: 24, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            drink.description,
                            style: AppTextStyles.textStyle(
                                color: AppColor.gray,
                                fontWeight: FontWeight.w400),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rate_rounded,
                                    color: AppColor.yellow,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    drink.rating.toString(),
                                    style: AppTextStyles.textStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 3),
                                    child: Text(
                                      AppConvert.formatMoney(drink.price),
                                      style: AppTextStyles.textStyle(
                                        fontSize: 14,
                                        color: AppColor.gray,
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Text(
                                    AppConvert.formatMoney(drink.salePrice),
                                    style: AppTextStyles.textStyle(
                                        fontSize: 24,
                                        color: AppColor.orange,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height / 2.5,
                            child: FutureBuilder(
                              future: Future.wait(
                                  [sizesFuture, optionsFuture, toppingsFuture]),
                              builder: (context,
                                  AsyncSnapshot<List<dynamic>> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                } else {
                                  final List<OptionModel> sizes =
                                      snapshot.data?[0] as List<OptionModel>;
                                  final List<OptionModel> options =
                                      snapshot.data?[1] as List<OptionModel>;
                                  final List<OptionModel> toppings =
                                      snapshot.data?[2] as List<OptionModel>;

                                  return ListView(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    children: [
                                      ItemOption(
                                          title: 'Chọn size',
                                          lst: sizes,
                                          selectedIndex: selectedSizeIndex,
                                          onTap: (e) {
                                            onAddNewItem(
                                                type: OrderType.size,
                                                model: e,
                                                price: e.price);
                                          },
                                          onTapCancel: (e) {
                                            onRemove(price: e.price);
                                          }),
                                      ItemOption(
                                          title: 'Món ăn kèm',
                                          lst: toppings,
                                          selectedIndex: selectedToppingIndex,
                                          onTap: (e) {
                                            onAddNewItem(
                                                type: OrderType.topping,
                                                model: e,
                                                price: e.price);
                                          },
                                          onTapCancel: (e) {
                                            onRemove(price: e.price);
                                          }),
                                      ItemOption(
                                          title: 'Yêu cầu thành phần',
                                          lst: options,
                                          selectedIndex: selectedOptionIndex,
                                          onTap: (e) {},
                                          onTapCancel: (e) {}),
                                      RichText(
                                          text: TextSpan(
                                              text: 'Thêm lưu ý cho quán',
                                              style: AppTextStyles.textStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              children: [
                                            TextSpan(
                                              text: ' ( Không bắt buộc )',
                                              style: AppTextStyles.textStyle(
                                                  fontSize: 14,
                                                  color: AppColor.gray),
                                            )
                                          ])),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                        ),
                                        decoration: BoxDecoration(
                                            color: const Color(0xffF7F7F7),
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: TextField(
                                          controller: noteTxtController,
                                          style: AppTextStyles.textStyle(),
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: 'Ghi chú ở đây',
                                              hintStyle:
                                                  AppTextStyles.textStyle(
                                                      color: AppColor.gray)),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Text(
                                        'Việc thực hiện yêu cầu còn tùy thuộc vào khả năng của quán',
                                        style: AppTextStyles.textStyle(
                                            fontSize: 14, color: AppColor.gray),
                                      ),
                                      const SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }

  Widget _btn() {
    return ValueListenableBuilder<double>(
      valueListenable: totalPrice,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                offset: const Offset(-4, -4),
                blurRadius: 16,
                color: Colors.black.withOpacity(0.05))
          ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      quantity.value--;
                      if (quantity.value < 1) {
                        quantity.value = 1;
                      }
                      updatePrice(quantity.value);
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.orange,
                      ),
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  ValueListenableBuilder<int>(
                    valueListenable: quantity,
                    builder: (context, value, child) {
                      return Text(
                        value.toString(),
                        style: AppTextStyles.textStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      quantity.value++;
                      updatePrice(quantity.value);
                    },
                    child: Container(
                      height: 28,
                      width: 28,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.orange,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                    color: AppColor.orange,
                    borderRadius: BorderRadius.circular(24)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(Assets.icons.iconAddCart),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      'Thêm vào đơn - ${AppConvert.formatMoney(value)}',
                      style: AppTextStyles.textStyle(
                          fontWeight: FontWeight.w600, color: Colors.white),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
