import 'package:evently/ui/screens/main/taps/favorite/favorite_tap.dart';
import 'package:evently/ui/screens/main/taps/home/home_tap.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  static const routeName = "/main";

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> taps = const [
    HomeTap(),
    FavoriteTap(),
    Center(child: Text("Profile")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: taps),
      ),
      floatingActionButton: buildFAB(),
      bottomNavigationBar: buildNavigationBar(),
    );
  }

  Widget buildNavigationBar() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomNavigationBar(
        items: [
          navigationBarItemBuilder(
            label: "Home",
            icon: AppIcons.home,
            activeIcon: AppIcons.filledHome,
          ),
          navigationBarItemBuilder(
            label: "Favorite",
            icon: AppIcons.heart,
            activeIcon: AppIcons.filledHeart,
          ),
          navigationBarItemBuilder(
            label: "Profile",
            icon: AppIcons.user,
            activeIcon: AppIcons.filledUser,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.disable,
        selectedLabelStyle: AppStyles.mainColor12regular,
        unselectedLabelStyle: AppStyles.disable12regular,
        backgroundColor: AppColors.white,
      ),
    );
  }

  BottomNavigationBarItem navigationBarItemBuilder({
    required String label,
    required String icon,
    required String activeIcon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: SvgPicture.asset(
        icon,
        colorFilter: ColorFilter.mode(AppColors.disable, BlendMode.srcIn),
      ),
      activeIcon: SvgPicture.asset(
        activeIcon,
        colorFilter: ColorFilter.mode(AppColors.mainColor, BlendMode.srcIn),
      ),
      tooltip: label,
    );
  }

  Widget buildFAB() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: AppColors.mainColor.withValues(alpha: 0.56),
          ),
        ],
      ),
      child: FloatingActionButton(
        elevation: 0,
        onPressed: () {},
        backgroundColor: AppColors.mainColor,
        shape: CircleBorder(),
        tooltip: "Add Event",
        child: Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}
