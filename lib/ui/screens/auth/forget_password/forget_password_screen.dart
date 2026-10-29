import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return EventlyScaffold(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            SizedBox(height: 16),
            EventlyHeader(
              center: Text(
                appLocalizations.forgetPassword2,
                style: AppStyles.mainText18medium,
              ),
              leading: ButtonWidget(
                onTap: () {
                  Navigator.pop(context);
                },
                child: SvgPicture.asset(Localizations.localeOf(context).languageCode == "en" ? AppIcons.arrowLeft : AppIcons.arrowRight),
              ),
            ),
            SizedBox(height: 43.5),
            Image.asset(AppImages.changeSetting, fit: .fitWidth),
            SizedBox(height: 40),
            EventlyButton(child: Text(appLocalizations.resetPassword, style: AppStyles.white20medium), onPresses: () {}),
          ],
        ),
      ),
    );
  }
}
