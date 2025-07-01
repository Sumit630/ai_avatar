import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../model/user_model.dart';
import '../utils/color.dart';
import '../utils/cons.dart';
import '../utils/text_style.dart';

class AiAvatarDetailsPage extends StatelessWidget {
  final UserModel user;

  const AiAvatarDetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.colorBackGraund,
        body: Padding(
          padding: const EdgeInsets.all(defaultPadding * 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(Icons.arrow_back),
                ),
              ),
              2.ph,
              Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  radius: 45.r,
                  backgroundImage: NetworkImage(user.imageLarge),
                ),
              ),
              2.ph,
              Align(alignment: Alignment.center,child: Text(user.fullName, style: inter.bold.get18.black)),
              1.ph,
              Align(alignment: Alignment.center,child: Text('${user.age} • ${user.gender}', style: inter.regular.get14)),
              Divider(height: 30.h,color: AppColors.colorTextFilBorder,),
              _infoTile("Location", '${user.city},${user.state},${user.country}'),
              _infoTile("Email", user.email),
              _infoTile("Phone", user.phone),
              _infoTile("Cell", user.cell),
              _infoTile("Date of Birth", formatDob(user.dob)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: inter.bold.get14.black),
          Text(value, style: inter.regular.get14),
        ],
      ),
    );
  }
  String formatDob(String isoDate) {
    try {
      final dateTime = DateTime.parse(isoDate);
      return DateFormat('dd-MM-yyyy').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }
}
