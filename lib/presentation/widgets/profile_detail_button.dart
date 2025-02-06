import 'package:flutter/material.dart';
import 'package:raho_mobile/core/styles/app_color.dart';
import 'package:raho_mobile/core/styles/app_text_style.dart';

class ProfileDetailButton extends StatelessWidget {
  const ProfileDetailButton(
      {super.key,
      required this.nameButton,
      required this.iconData,
      required this.onClick});

  final String nameButton;
  final IconData iconData;
  final void Function()? onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Row(
        children: [
          Container(
            height: 42,
            width: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColor.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              color: AppColor.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24),
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColor.grey))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameButton,
                  style: AppFontStyle.s14.regular.black,
                ),
                Icon(
                  Icons.keyboard_arrow_right,
                  color: AppColor.grey,
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
