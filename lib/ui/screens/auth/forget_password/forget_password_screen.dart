import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/app_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordScreen extends StatelessWidget {
  static const routeName = "/forget password";
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: .stretch,
              children: [
                SizedBox(height: 16),
                AppHeader(
                  center: Text("Forget Password", style: AppStyles.mainText18medium,),
                  leading: ButtonWidget(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: SvgPicture.asset(AppIcons.arrowBack),
                  ),
                ),
                SizedBox(height: 43.5),
                Image.asset(AppImages.changeSetting,fit: .fitWidth,),
                SizedBox(height: 40),
                EventlyButton(text: "Reset Password", onPresses: () {})
              ]
            )
          )
        )
      )
    );
  }
}
