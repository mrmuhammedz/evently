import 'package:evently/models/user_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:flutter/material.dart';

class UserImage extends StatelessWidget {
  final double radius;
  final UserDm? user;
  const UserImage({super.key, required this.radius, this.user});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.mainColor,
      child: CircleAvatar(
        radius: radius - 2,
        backgroundImage: user?.photoUrl != null
            ? NetworkImage(user!.photoUrl!)
            : AssetImage(AppImages.profile) as ImageProvider,
      ),
    );
  }
}
