import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/models/onboarding_dm.dart';
import 'package:evently/providers/language_provider.dart';
import 'package:evently/providers/theme_provider.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:evently/ui/widgets/theme_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/evently_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../widgets/evently_scaffold.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  AppLocalizations get _appLocalizations => AppLocalizations.of(context)!;
  ThemeData get _theme => Theme.of(context);
  ThemeProvider get _themeProvider => context.read<ThemeProvider>();
  List<OnboardingDm> get _onboardingList => [
    OnboardingDm(
      imagePath: AppImages.onboardingPage1,
      title: _appLocalizations.personalizeYourExperience,
      description: _appLocalizations.personalizeYourExperienceDescription,
      buttonText: _appLocalizations.letsStart,
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage2,
      title: _appLocalizations.findEventsThatInspireYou,
      description: _appLocalizations.findEventsThatInspireYouDescription,
      buttonText: _appLocalizations.next,
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage3,
      title: _appLocalizations.effortlessEventPlanning,
      description: _appLocalizations.effortlessEventPlanningDescription,
      buttonText: _appLocalizations.next,
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage4,
      title: _appLocalizations.connectWithFriendsAndShareMoments,
      description:
          _appLocalizations.connectWithFriendsAndShareMomentsDescription,
      buttonText: _appLocalizations.getStarted,
    ),
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<LanguageProvider>();

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
                return ImageIcon(
                  AssetImage(_onboardingList[index].imagePath),
                  color: _theme.colorScheme.onSurface,
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
              effect: ExpandingDotsEffect(
                dotWidth: 8,
                dotHeight: 8,
                activeDotColor: _theme.primaryColor,
                dotColor: _themeProvider.isDarkMode(context)
                    ? AppColors.white
                    : AppColors.disable,
              ),
            ),
          SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  Text(
                    _onboardingList[_current].title,
                    style: AppStyles.semiBoldTextStyle20.copyWith(
                      color: _theme.colorScheme.onSecondary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    _onboardingList[_current].description,
                    style: AppStyles.regularTextStyle16H.copyWith(
                      color: _theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  if (_current == 0)
                    Column(
                      crossAxisAlignment: .stretch,
                      children: [
                        SizedBox(height: 16),
                        settingsRow(
                          text: _appLocalizations.language,
                          children: [
                            settingsButton(
                              onTap: () {
                                languageProvider.setLocale("en");
                              },
                              isSelected: languageProvider.isEnglish,
                              child: Text(
                                _appLocalizations.english,
                                style: languageProvider.isEnglish
                                    ? AppStyles.semiBoldTextStyle14.copyWith(
                                        color: AppColors.white,
                                      )
                                    : AppStyles.regularTextStyle14,
                              ),
                            ),
                            settingsButton(
                              onTap: () {
                                languageProvider.setLocale("ar");
                              },
                              isSelected: !languageProvider.isEnglish,
                              child: Text(
                                _appLocalizations.arabic,
                                style: !languageProvider.isEnglish
                                    ? AppStyles.semiBoldTextStyle14.copyWith(
                                        color: AppColors.white,
                                      )
                                    : AppStyles.regularTextStyle14,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        settingsRow(
                          text: _appLocalizations.theme,
                          children: [
                            ThemeDropdown(
                              appLocalizations: _appLocalizations,
                              themeProvider: _themeProvider,
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          EventlyButton(
            onPresses: () {
              if (_current == _onboardingList.length - 1) {
                Navigator.pushReplacement(context, AppRoutes.loginRoute());
                return;
              }
              _controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: Text(
              _onboardingList[_current].buttonText,
              style: AppStyles.mediumTextStyle20.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(height: 28),
        ],
      ),
    );
  }

  Widget header() => EventlyHeader(
    center: ImageIcon(
      AssetImage(AppImages.logo),
      color: _theme.primaryColor,
      size: double.infinity,
    ),
    leading: _current > 1
        ? ButtonWidget(
            onTap: () {
              _controller.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            },
            child: SvgAsset(
              asset: Localizations.localeOf(context).languageCode == "en"
                  ? AppIcons.arrowLeft
                  : AppIcons.arrowRight,
              color: _theme.colorScheme.onSurface,
            ),
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
                _appLocalizations.skip,
                style: AppStyles.semiBoldTextStyle14.copyWith(
                  color: _theme.colorScheme.onSurface,
                ),
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

  Row settingsRow({required String text, required List<Widget> children}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.mediumTextStyle18),
        Row(spacing: 8, children: children),
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
          color: isSelected ? _theme.primaryColor : _theme.colorScheme.surface,
          border: Border.all(
            color: isSelected ? Colors.transparent : _theme.colorScheme.outline,
          ),
        ),
        child: child,
      ),
    );
  }
}
