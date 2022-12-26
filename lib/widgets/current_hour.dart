import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowCurrentTime extends StatelessWidget {
  final bool isActive;
  final String? title;
  final String? image;
  final num? temp;
  const ShowCurrentTime(
      {super.key, required this.isActive, this.title, this.image, this.temp});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146.h,
      width: 60.w,
      margin: EdgeInsets.only(left: 12),
      decoration: BoxDecoration(
        color: isActive ? Color(0xff48319D) : Color(0x5048319D),
        borderRadius: BorderRadius.all(Radius.circular(30)),
      ),
      child: Column(
        children: [
          Text((title ?? "").substring((title ?? "").indexOf(" ") + 1)),
          Image.network('https:${image ?? ''}'),
          Text((temp ?? 0)
              .toString()
              .substring(0, (temp ?? 0).toString().indexOf('.')))
        ],
      ),
    );
  }
}
