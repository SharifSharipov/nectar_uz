import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar_uz/utils/app_colors.dart';

class Account_listile extends StatelessWidget {
  const Account_listile({
    super.key,
    required this.text,
    required this.iconca,
  });

  final String text;
  final String iconca;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 18,right: 18),
      height: 55,
      child: ListTile(
        leading: SvgPicture.asset(iconca),
        title: Text(text,style: TextStyle(color: Colors.black),),
        subtitle: Text('Subtitle goes here'), // Provide a subtitle
        trailing: Icon(Icons.arrow_forward_ios_outlined, color: Colors.black),
        isThreeLine: true,
      ),
    );
  }
}
