import 'package:evalutation_zens/gen/assets.gen.dart';
import 'package:evalutation_zens/model/drink_model.dart';
import 'package:evalutation_zens/utils/style/app_textstyle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BannerOrder extends StatelessWidget {
  const BannerOrder({
    super.key,
    required this.drink,
    required this.count,
  });

  final DrinkModel drink;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Hero(
          tag: drink.id,
          child: SizedBox(
            height: 250,
            width: MediaQuery.sizeOf(context).width,
            child: Image.asset(
              drink.img,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      padding: const EdgeInsets.all(9),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: SvgPicture.asset(Assets.icons.iconCart),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
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
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
