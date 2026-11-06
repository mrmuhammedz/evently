import 'package:evently/l10n/app_localizations.dart';
import 'package:evently/ui/screens/main/taps/favorite/favorite_tap.dart';
import 'package:evently/ui/screens/main/taps/home/home_tap.dart';
import 'package:evently/ui/screens/main/taps/profile/profile_tap.dart';
import 'package:evently/ui/utils/app_assets.dart';
import 'package:evently/ui/utils/app_colors.dart';
import 'package:evently/ui/utils/app_routes.dart';
import 'package:evently/ui/widgets/evently_scaffold.dart';
import 'package:evently/ui/widgets/svg_asset.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _taps = const [HomeTap(), FavoriteTap(), ProfileTap()];
  ThemeData get _theme => Theme.of(context);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    return EventlyScaffold(
      bottomNavigationBar: buildNavigationBar(appLocalizations),
      floatingActionButton: buildFAB(appLocalizations),
      child: IndexedStack(index: _currentIndex, children: _taps),
    );
  }

  Widget buildNavigationBar(AppLocalizations appLocalizations) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(24),
        topRight: Radius.circular(24),
      ),
      child: BottomNavigationBar(
        items: [
          navigationBarItemBuilder(
            label: appLocalizations.home,
            icon: AppIcons.home,
            activeIcon: AppIcons.filledHome,
          ),
          navigationBarItemBuilder(
            label: appLocalizations.favorite,
            icon: AppIcons.heart,
            activeIcon: AppIcons.filledHeart,
          ),
          navigationBarItemBuilder(
            label: appLocalizations.profile,
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
      icon: SvgAsset(asset: icon, color: AppColors.disable),
      activeIcon: SvgAsset(asset: activeIcon, color: _theme.primaryColor),
      tooltip: label,
    );
  }

  Widget buildFAB(AppLocalizations appLocalizations) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 12,
            offset: const Offset(0, 4),
            color: _theme.primaryColor.withValues(alpha: 0.56),
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, AppRoutes.addEventRoute());
        },
        tooltip: appLocalizations.addEvent,
        child: Icon(Icons.add),
      ),
    );
  }
}
