import 'package:flutter/material.dart';

class Responsive {
  Responsive(this.context);

  final BuildContext context;

  static Responsive of(BuildContext context) => Responsive(context);

  Size get size => MediaQuery.sizeOf(context);
  double get width => size.width;
  double get height => size.height;

  bool get isCompact => width < 360;
  bool get isMobile => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  double get contentMaxWidth {
    if (isDesktop) return 960;
    if (isTablet) return 720;
    return width;
  }

  double get cardMaxWidth {
    if (isDesktop) return 520;
    if (isTablet) return 480;
    return width;
  }

  double get horizontalPadding {
    if (isDesktop) return 32;
    if (isTablet) return 24;
    return 16;
  }

  double heroHeight({double fraction = 0.38}) {
    return (height * fraction).clamp(180, 360);
  }

  double get logoHeight => isCompact ? 80 : (isMobile ? 100 : 120);

  int get menuGridColumns => width >= 520 ? 2 : 1;

  int get listGridColumns {
    if (width >= 900) return 3;
    if (width >= 600) return 2;
    return 1;
  }

  double letterKeySize(int letterCount, {double spacing = 8}) {
    final available = contentMaxWidth - (horizontalPadding * 2) - 28;
    final perRow = isMobile ? 7.0 : 9.0;
    final size = (available - (spacing * (perRow - 1))) / perRow;
    return size.clamp(34, 48);
  }

  double imageHeight({double fraction = 0.22}) {
    return (height * fraction).clamp(140, 260);
  }
}

class ResponsiveContent extends StatelessWidget {
  const ResponsiveContent({
    super.key,
    required this.child,
    this.maxWidth,
    this.padding,
    this.alignment = Alignment.topCenter,
  });

  final Widget child;
  final double? maxWidth;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: maxWidth ?? responsive.contentMaxWidth,
        ),
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: responsive.horizontalPadding),
          child: child,
        ),
      ),
    );
  }
}
