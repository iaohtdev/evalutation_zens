import 'package:evalutation_zens/gen/assets.gen.dart';
import 'package:evalutation_zens/utils/style/app_color.dart';
import 'package:evalutation_zens/utils/style/app_textstyle.dart';
import 'package:flutter/material.dart';

class HeaderHome extends StatelessWidget {
  const HeaderHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
              right: 0,
              child: Image.asset(
                Assets.images.bannerHover.path,
                scale: 1.3,
              )),
          Padding(
            padding: const EdgeInsets.only(left: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Image.asset(
                  Assets.images.textBanner.path,
                  height: 80,
                ),
                const SizedBox(height: 8),
                Text(
                  '40 sự lựa chọn cho bạn',
                  style: AppTextStyles.textStyle(
                      fontSize: 16, color: AppColor.gray),
                )
              ],
            ),
          ),
          Positioned(
              right: 0,
              child: Image.asset(
                Assets.images.banner.path,
                height: 260,
              ))
        ],
      ),
    );
  }
}
