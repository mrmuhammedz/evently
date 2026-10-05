import 'package:evently/models/onboarding_dm.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:evently/ui/widgets/app_header.dart';
import 'package:evently/ui/widgets/button_widget.dart';
import 'package:evently/ui/widgets/evently_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = "/onboarding";

  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  final List<OnboardingDm> _onboardingList = [
    OnboardingDm(
      imagePath: AppImages.onboardingPage1,
      title: "Personalize Your Experience",
      description:
          "Choose your preferred theme and language to get started with a comfortable, tailored experience that suits your style.",
      buttonText: 'Let’s start',
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage2,
      title: "Find Events That Inspire You",
      description:
          "Dive into a world of events crafted to fit your unique interests. Whether you're into live music, art workshops, professional networking, or simply discovering new experiences, we have something for everyone. Our curated recommendations will help you explore, connect, and make the most of every opportunity around you.",
      buttonText: 'Next',
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage3,
      title: "Effortless Event Planning",
      description:
          "Take the hassle out of organizing events with our all-in-one planning tools. From setting up invites and managing RSVPs to scheduling reminders and coordinating details, we’ve got you covered. Plan with ease and focus on what matters – creating an unforgettable experience for you and your guests.",
      buttonText: 'Next',
    ),
    OnboardingDm(
      imagePath: AppImages.onboardingPage4,
      title: "Connect with Friends & Share Moments",
      description:
          "Make every event memorable by sharing the experience with others. Our platform lets you invite friends, keep everyone in the loop, and celebrate moments together. Capture and share the excitement with your network, so you can relive the highlights and cherish the memories.",
      buttonText: 'Get started',
    ),
  ];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
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
                            text: 'Language',
                            firstButtonChild: Text(
                              "English",
                              style: AppStyles.white14semiBold,
                            ),
                            secondButtonChild: Text(
                              "Arabic",
                              style: AppStyles.mainColor14regular,
                            ),
                          ),
                          SizedBox(height: 16),
                          settingsRow(
                            text: 'Theme',
                            firstButtonChild: SvgPicture.asset(
                              AppIcons.filledSun,
                            ),
                            secondButtonChild: SvgPicture.asset(AppIcons.moon),
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
        ),
      ),
    );
  }

  Widget header() => AppHeader(
    center: Image.asset(AppImages.logo),
    leading: _current > 1
        ? ButtonWidget(
      onTap: () {
        _controller.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: SvgPicture.asset(AppIcons.arrowBack),
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
          "Skip",
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
    required Widget secondButtonChild,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: AppStyles.mainColor18medium),
        Row(
          children: [
            settingsButton(
              child: firstButtonChild,
              onTap: () {},
              isSelected: true,
            ),
            SizedBox(width: 8),
            settingsButton(
              child: secondButtonChild,
              onTap: () {},
              isSelected: false,
            ),
          ],
        ),
      ],
    );
  }

  Widget settingsButton({
    required Widget child,
    required Function() onTap,
    bool isSelected = true,
  }) {
    // Use ButtonWidget
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
