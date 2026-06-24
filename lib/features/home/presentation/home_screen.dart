import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.onSelectTab});

  final void Function(int index)? onSelectTab;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(String route) {
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final heroHeight = responsive.heroHeight();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: heroHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ScrollConfiguration(
                    behavior: const _HeroScrollBehavior(),
                    child: PageView.builder(
                      controller: _pageController,
                      physics: const PageScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: AppAssets.heroCarousel.length,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemBuilder: (context, index) {
                        return Image.asset(
                          AppAssets.heroCarousel[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        );
                      },
                    ),
                  ),
                  IgnorePointer(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.background.withValues(alpha: 0.2),
                            AppColors.background.withValues(alpha: 0.85),
                            AppColors.background,
                          ],
                          stops: const [0.0, 0.45, 0.78, 1.0],
                        ),
                      ),
                    ),
                  ),
                  IgnorePointer(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 28),
                        child: Image.asset(
                          AppAssets.logo,
                          height: responsive.logoHeight,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(AppAssets.heroCarousel.length, (index) {
                final isActive = index == _currentPage;
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 10 : 8,
                    height: isActive ? 10 : 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppColors.portalGreen
                          : AppColors.textSecondary.withValues(alpha: 0.45),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: AppColors.portalGreen.withValues(
                                  alpha: 0.6,
                                ),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                  ),
                );
              }),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  responsive.horizontalPadding,
                  20,
                  responsive.horizontalPadding,
                  24,
                ),
                child: ResponsiveContent(
                  maxWidth: responsive.cardMaxWidth,
                  padding: EdgeInsets.zero,
                  child: _HomeMenuGrid(onSelectTab: widget.onSelectTab, goTo: _goTo),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeMenuGrid extends StatelessWidget {
  const _HomeMenuGrid({
    required this.onSelectTab,
    required this.goTo,
  });

  final void Function(int index)? onSelectTab;
  final void Function(String route) goTo;

  @override
  Widget build(BuildContext context) {
    final cards = [
      _MenuCard(
        title: 'Personajes',
        subtitle: 'Conoce al multiverso',
        iconAsset: AppAssets.iconCharacters,
        accentColor: AppColors.portalGreen,
        onTap: () => goTo(AppRoutes.characters),
      ),
      _MenuCard(
        title: 'Momentos',
        subtitle: 'Escenas favoritas',
        iconAsset: AppAssets.iconMoments,
        accentColor: AppColors.accentPurple,
        onTap: () => goTo(AppRoutes.moments),
      ),
      _MenuCard(
        title: 'Acerca de',
        subtitle: 'Historia de la serie',
        iconAsset: AppAssets.iconAbout,
        accentColor: AppColors.portalBlue,
        onTap: () => onSelectTab?.call(2),
      ),
      _MenuCard(
        title: 'Juega conmigo',
        subtitle: 'Mini quiz interdimensional',
        iconAsset: AppAssets.iconGame,
        accentColor: AppColors.accentOrange,
        onTap: () => onSelectTab?.call(1),
      ),
      _MenuCard(
        title: 'Contrátame',
        subtitle: '¿Necesitas un desarrollador?',
        iconAsset: AppAssets.iconHireMe,
        accentColor: AppColors.accentPink,
        onTap: () => onSelectTab?.call(3),
        fullWidth: true,
      ),
    ];

    if (Responsive.of(context).menuGridColumns == 1) {
      return Column(
        children: [
          for (var i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            cards[i],
          ],
        ],
      );
    }

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cards[0]),
            const SizedBox(width: 12),
            Expanded(child: cards[1]),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cards[2]),
            const SizedBox(width: 12),
            Expanded(child: cards[3]),
          ],
        ),
        const SizedBox(height: 12),
        cards[4],
      ],
    );
  }
}

class _HeroScrollBehavior extends MaterialScrollBehavior {
  const _HeroScrollBehavior();

  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      };
}

class _MenuCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconAsset;
  final Color accentColor;
  final VoidCallback onTap;
  final bool fullWidth;

  const _MenuCard({
    required this.title,
    required this.subtitle,
    required this.iconAsset,
    required this.accentColor,
    required this.onTap,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.card,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: fullWidth ? 16 : 12,
            vertical: fullWidth ? 14 : 16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: accentColor.withValues(alpha: 0.15),
            ),
          ),
          child: Row(
            children: [
              _IconBadge(iconAsset: iconAsset, accentColor: accentColor),
              SizedBox(width: fullWidth ? 14 : 10),
              Expanded(child: _TextContent(title: title, subtitle: subtitle)),
              Icon(
                Icons.chevron_right,
                size: fullWidth ? 22 : 18,
                color: AppColors.textSecondary.withValues(alpha: 0.7),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final String iconAsset;
  final Color accentColor;

  const _IconBadge({
    required this.iconAsset,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: accentColor.withValues(alpha: 0.18),
        border: Border.all(color: accentColor.withValues(alpha: 0.35)),
      ),
      child: Image.asset(iconAsset, fit: BoxFit.contain),
    );
  }
}

class _TextContent extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TextContent({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
