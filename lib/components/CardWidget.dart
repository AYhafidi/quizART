import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String answer, fontFamily;
  final double size, borderRadius, fontSize;
  final bool choosed;

  const CardWidget({
    super.key,
    required this.answer,
    required this.size,
    this.borderRadius =10,
    this.fontSize = 20,
    this.fontFamily = "lato",
    this.choosed = false,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(size *0.08, 0, 0, 0),
      transform: choosed ? Matrix4.diagonal3Values(1.04, 1.04, 1) : Matrix4.identity(),
      padding: EdgeInsets.zero,
      width: size / 1.618,
      height: size ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: Colors.white, // You can set a background color if needed
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: choosed ? 1:0.5,
            child: SizedBox(
                width: size/ 1.618 ,
                height: size * 0.8 ,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(borderRadius),
                    topRight: Radius.circular(borderRadius),
                  ),
                  child: Image(
                    image: AssetImage("images/$answer.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
          ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(borderRadius),
                  bottomRight: Radius.circular(borderRadius),
                ),
              ),
              height: size * 0.145 ,
              width: size/ 1.618,
              child: Center(
                child: Text(
                  answer,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: fontFamily,
                    fontWeight : choosed? FontWeight.bold:FontWeight.normal,
                  ),
                ),
              ),
            ),
          ],
        ),

    );
  }
}
