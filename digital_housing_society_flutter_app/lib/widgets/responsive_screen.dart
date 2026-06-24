import 'package:flutter/material.dart';
import '../core/app_colors.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({
    super.key,
    required this.child,
    this.scrollable = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 22, vertical: 18),
    this.useGradientBackground = false,
  });

  final Widget child;
  final bool scrollable;
  final EdgeInsets padding;
  final bool useGradientBackground;

  @override
  Widget build(BuildContext context) {
    final content = SafeArea(
      child: Padding(
        padding: padding,
        child: scrollable
            ? SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: child,
              )
            : child,
      ),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.background,
          gradient: useGradientBackground
              ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFEAF2FF), AppColors.background, Color(0xFFF2ECFF)],
                )
              : null,
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: content,
          ),
        ),
      ),
    );
  }
}
