import 'package:evalutation_zens/model/option_model.dart';
import 'package:evalutation_zens/utils/convert/app_convert.dart';
import 'package:evalutation_zens/utils/style/app_color.dart';
import 'package:evalutation_zens/utils/style/app_textstyle.dart';
import 'package:flutter/material.dart';

class ItemOption extends StatelessWidget {
  const ItemOption(
      {super.key,
      this.lst,
      required this.selectedIndex,
      required this.title,
      this.isRequired,
      this.onTap,
      this.onTapCancel});
  final dynamic lst;
  final ValueNotifier<int> selectedIndex;
  final String title;
  final bool? isRequired;
  final Function(OptionModel)? onTap;
  final Function(OptionModel)? onTapCancel;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: selectedIndex,
      builder: (context, selected, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    text: title,
                    style: AppTextStyles.textStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                    children: [
                  TextSpan(
                    text: isRequired == true
                        ? ' ( Bắt buộc )'
                        : ' ( Không bắt buộc )',
                    style: AppTextStyles.textStyle(
                        fontSize: 14, color: AppColor.gray),
                  )
                ])),
            const SizedBox(
              height: 16,
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: lst.length,
              itemBuilder: (context, index) {
                final bool isSelected = selectedIndex.value == index;
                final item = lst[index];
                return Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (isSelected) {
                          selectedIndex.value = -1;
                          onTapCancel!(item);
                        } else {
                          selectedIndex.value = index;
                          onTap!(item);
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                height: 24,
                                width: 24,
                                padding: const EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColor.orange
                                        : const Color(0xff989898),
                                    width: 2,
                                  ),
                                ),
                                child: Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: isSelected
                                        ? AppColor.orange
                                        : Colors.transparent,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Text(item.name, style: AppTextStyles.textStyle()),
                            ],
                          ),
                          Text(AppConvert.formatMoney(item.price))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 1,
                      color: const Color(0xffDCDCDC),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                );
              },
            ),
          ],
        );
      },
    );
  }
}
