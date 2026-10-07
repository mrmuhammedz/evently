import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/onboarding_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/evently_scaffold.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late AppLocalizations appLocalizations;
  final PageController _controller = PageController();
  late final List<OnboardingDm> _onboardingList = [
    OnboardingDm(
      imagePath: AppImages.onboardingPage1,
      title: appLocalizations.personalizeYourExperience,
      description: appLocalizations.personalizeYourExperienceDescription,
      buttonText: appLocalizations.letsStart,
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage2,
      title: appLocalizations.findEventsThatInspireYou,
      description: appLocalizations.findEventsThatInspireYouDescription,
      buttonText: appLocalizations.next,
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage3,
      title: appLocalizations.effortlessEventPlanning,
      description: appLocalizations.effortlessEventPlanningDescription,
      buttonText: appLocalizations.next,
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage4,
      title: appLocalizations.connectWithFriendsAndShareMoments,
      description:
          appLocalizations.connectWithFriendsAndShareMomentsDescription,
      buttonText: appLocalizations.getStarted,
    ),
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
     appLocalizations = AppLocalizations.of(context)!;
    return EventlyScaffold(
      child: Column(
        children: [
          SizedBox(height: 16),
          header(),
          SizedBox(height: 24),
          Expanded(
            flex: 2,
            child: pageViewBuilder(
              controller: _controller,
              itemBuilder: (_, index) {
                return Image.asset(
                  _onboardingList[index].imagePath,
                  fit: BoxFit.fitWidth,
                );
              },
            ),
          ),
          SizedBox(height: 8),
          if (_current > 0)
            AnimatedSmoothIndicator(
              activeIndex: _current - 1,
              count: _onboardingList.length - 1,
              onDotClicked: (index) {
                _controller.animateToPage(
                  index + 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              effect: ExpandingDotsEffect(dotWidth: 8, dotHeight: 8),
            ),
          SizedBox(height: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              children: [
                Text(
                  _onboardingList[_current].title,
                  style: AppStyles.mainText20semiBold,
                ),
                SizedBox(height: 8),
                Text(
                  _onboardingList[_current].description,
                  style: AppStyles.secText16regularH,
                ),
                if (_current == 0)
                  Column(
                    crossAxisAlignment: .stretch,
                    children: [
                      SizedBox(height: 16),
                      settingsRow(
                        text: appLocalizations.language,
                        firstButtonChild: Text(
                          appLocalizations.english,
                          style: AppStyles.white14semiBold,
                        ),
                        onTapFirstButton: () {},
                        secondButtonChild: Text(
                          appLocalizations.arabic,
                          style: AppStyles.mainColor14regular,
                        ),
                        onTapSecondButton: () {},
                      ),
                      SizedBox(height: 16),
                      settingsRow(
                        text: appLocalizations.theme,
                        firstButtonChild: SvgPicture.asset(AppIcons.filledSun),
                        onTapFirstButton: () {},
                        secondButtonChild: SvgPicture.asset(AppIcons.moon),
                        onTapSecondButton: () {},
                      ),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(height: 16),
          EventlyButton(
            onPresses: () {
              if (_current == _onboardingList.length - 1) {
                Navigator.pushReplacement(context, AppRoutes.mainRoute());
                return;
              }
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            text: _onboardingList[_current].buttonText,
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget header() => EventlyHeader(
    center: Image.asset(AppImages.logo),
    leading: _current > 1
        ? ButtonWidget(
            onTap: () {
              _controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: SvgPicture.asset(Localizations.localeOf(context).languageCode == "en" ? AppIcons.arrowLeft : AppIcons.arrowRight),
          )
        : null,
    actions: _current > 0 && _current < _onboardingList.length - 1
        ? [
            ButtonWidget(
              horizontalPadding: 16,
              verticalPadding: 6,
              onTap: () {
                _controller.animateToPage(
                  _onboardingList.length - 1,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                appLocalizations.skip,
                style: AppStyles.mainColor14semiBold,
              ),
            ),
          ]
        : null,
  );

  Widget pageViewBuilder({
    required Widget Function(BuildContext, int) itemBuilder,
    required PageController controller,
  }) {
    return PageView.builder(
      physics: _current == 0
          ? const NeverScrollableScrollPhysics()
          : const PageScrollPhysics(),
      clipBehavior: .none,
      controller: controller,
      onPageChanged: (index) {
        setState(() {
          _current = index;
        });
      },
      itemCount: _onboardingList.length,
      itemBuilder: itemBuilder,
    );
  }

  Row settingsRow({
    required String text,
    required Widget firstButtonChild,
    required Function onTapFirstButton,
    required Widget secondButtonChild,
    required Function onTapSecondButton,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.mainColor18medium),
        Row(
          children: [
            settingsButton(
              child: firstButtonChild,
              onTap: () {
                onTapFirstButton();
              },
              isSelected: true,
            ),
            SizedBox(width: 8),
            settingsButton(
              child: secondButtonChild,
              onTap: () {
                onTapSecondButton();
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget settingsButton({
    required Widget child,
    required Function() onTap,
    bool isSelected = false,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(8),
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16, vertical: 5.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? AppColors.mainColor : AppColors.white,
          border: Border.all(
            color: isSelected ? Colors.transparent : AppColors.stroke,
          ),
        ),
        child: child,
      ),
    );
  }
}
