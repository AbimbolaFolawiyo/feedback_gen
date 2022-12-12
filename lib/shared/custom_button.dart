import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import '../constants/constants.dart' show AppColors;
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.icon,
    this.absorbing = false,
    this.isOutline = false,
    this.color,
  }) : super(key: key);
  final Function() onTap;
  final String text;
  final String? icon;
  final bool absorbing;
  final bool isOutline;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: absorbing,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          height: 53.h,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(vertical: 16.h),
          decoration: BoxDecoration(
            color: isOutline
                ? Colors.transparent
                : absorbing
                    ? color != null
                        ? color!.withOpacity(.5)
                        : AppColors.kBrown.withOpacity(.5)
                    : color ?? AppColors.kBrown,
            borderRadius: BorderRadius.circular(8.r),
            border: isOutline ? Border.all(color: AppColors.kBorder) : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isOutline)
                SizedBox(
                  height: 30.h,
                  width: 30.w,
                  child: SvgPicture.asset(icon!),
                ),
              if (isOutline) Gap(10.w),
              CustomText(
                text: text,
                color: absorbing
                    ? AppColors.kPrimary.withOpacity(.5)
                    : color != null
                        ? Colors.white
                        : AppColors.kPrimary,
                size: 14.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
