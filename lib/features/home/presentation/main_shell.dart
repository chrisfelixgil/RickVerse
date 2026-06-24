import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../about/presentation/about_screen.dart';
import '../../characters/presentation/characters_screen.dart';
import '../../game/presentation/game_screen.dart';
import '../../hire_me/presentation/hire_me_screen.dart';
import '../../moments/presentation/moments_screen.dart';
import 'home_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();

  int _selectedIndex = 0;

  void _selectTab(int index) {
    if (index == 0) {
      _homeNavigatorKey.currentState?.popUntil((route) => route.isFirst);
    }
    setState(() => _selectedIndex = index);
  }

  bool get _showBottomBar => _selectedIndex != 1;

  Route<dynamic> _onGenerateHomeRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.characters:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const CharactersScreen(),
        );
      case AppRoutes.moments:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => const MomentsScreen(),
        );
      case AppRoutes.home:
      default:
        return MaterialPageRoute<void>(
          settings: settings,
          builder: (_) => HomeScreen(onSelectTab: _selectTab),
        );
    }
  }

  Widget _buildHomeTab() {
    return Navigator(
      key: _homeNavigatorKey,
      initialRoute: AppRoutes.home,
      onGenerateRoute: _onGenerateHomeRoute,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          _buildHomeTab(),
          GameScreen(onBack: () => _selectTab(0)),
          const AboutScreen(),
          const HireMeScreen(),
        ],
      ),
      bottomNavigationBar: _showBottomBar
          ? Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFF1E2A36), width: 1),
                ),
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex == 1 ? 0 : _selectedIndex,
                onTap: _selectTab,
                type: BottomNavigationBarType.fixed,
                backgroundColor: AppColors.navBar,
                selectedItemColor: AppColors.portalGreen,
                unselectedItemColor: AppColors.textSecondary,
                selectedFontSize: 11,
                unselectedFontSize: 11,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(Icons.home),
                    label: 'Inicio',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.videogame_asset_outlined),
                    activeIcon: Icon(Icons.videogame_asset),
                    label: 'Juega conmigo',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.tv_outlined),
                    activeIcon: Icon(Icons.tv),
                    label: 'Acerca de',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person_outline),
                    activeIcon: Icon(Icons.person),
                    label: 'Perfil',
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
