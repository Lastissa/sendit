import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends ConsumerStatefulWidget {
  const IntroPage({
    super.key,
    this.onCreateAround,
    this.onLogin,
  });

  final VoidCallback? onCreateAround;
  final VoidCallback? onLogin;

  @override
  ConsumerState<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends ConsumerState<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_IntroSlide> _slides = const [
    _IntroSlide(
      title: 'Instant Currency Flow',
      description:
          'Convert, compare, and send currency with a smart wallet feel — all in milliseconds.',
      assetName: 'assets/intro_images/currency_wave.svg',
      accent: Color(0xFF56CCF2),
    ),
    _IntroSlide(
      title: 'Global Rate Vision',
      description:
          'See live exchange insights and trade confidently across borders without second-guessing.',
      assetName: 'assets/intro_images/global_trade.svg',
      accent: Color(0xFF9B51E0),
    ),
    _IntroSlide(
      title: 'Secure Conversion Bridge',
      description:
          'A polished experience engineered for safety, speed, and flawless cross-device interaction.',
      assetName: 'assets/intro_images/secure_convert.svg',
      accent: Color(0xFFF2994A),
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final bool isDesktop = size.width >= 1000;
    final bool isTablet = size.width >= 700 && size.width < 1000;
    final double horizontalPadding = isDesktop ? 64 : 24;
    final double contentMaxWidth = isDesktop ? 1100 : 760;
    final double imageWidth = isDesktop ? size.width * 0.38 : size.width * 0.82;
    final double imageHeight = isDesktop ? size.height * 0.62 : size.height * 0.42;

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      body: Stack(
        children: [
          _IntroBackground(
            size: size,
            accentColor: _slides[_currentPage].accent,
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: contentMaxWidth),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 18),
                      Text(
                        'Welcome to SendIt Currency',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: isDesktop ? 42 : 32,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'A unified currency exchange experience designed for website and mobile, with a premium responsive layout and intuitive gestures.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onBackground.withOpacity(0.72),
                          fontSize: isTablet ? 18 : 16,
                        ),
                      ),
                      const SizedBox(height: 28),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            return Card(
                              elevation: 18,
                              shadowColor: Colors.black.withOpacity(0.18),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(34),
                              ),
                              color: theme.colorScheme.surface.withOpacity(0.94),
                              child: Padding(
                                padding: EdgeInsets.all(isDesktop ? 32 : 20),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: isDesktop
                                          ? Row(
                                              children: [
                                                Expanded(child: _buildIntroContent(theme, isDesktop)),
                                                const SizedBox(width: 26),
                                                _buildSlideVisual(imageWidth, imageHeight),
                                              ],
                                            )
                                          : Column(
                                              children: [
                                                _buildSlideVisual(imageWidth, imageHeight),
                                                const SizedBox(height: 24),
                                                _buildIntroContent(theme, isDesktop),
                                              ],
                                            ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildFooter(theme, isDesktop),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIntroContent(ThemeData theme, bool isDesktop) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 450),
          child: Text(
            _slides[_currentPage].title,
            key: ValueKey<String>(_slides[_currentPage].title),
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: isDesktop ? 40 : 30,
              fontWeight: FontWeight.w800,
              height: 1.05,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          _slides[_currentPage].description,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontSize: isDesktop ? 18 : 16,
            color: theme.colorScheme.onSurface.withOpacity(0.78),
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
          decoration: BoxDecoration(
            color: theme.colorScheme.primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: theme.colorScheme.primary.withOpacity(0.18)),
          ),
          child: Row(
            children: [
              Icon(Icons.flash_on_rounded, color: _slides[_currentPage].accent, size: 26),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Responsive across mobile, tablet, and desktop with subtle hover polish for web.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontSize: 15,
                    color: theme.colorScheme.onSurface.withOpacity(0.88),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSlideVisual(double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _slides.length,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemBuilder: (context, index) {
          final slide = _slides[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 16,
                      left: 20,
                      right: 20,
                      bottom: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [slide.accent.withOpacity(0.16), Colors.transparent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          slide.assetName,
                          fit: BoxFit.contain,
                          width: width * 0.92,
                          height: height * 0.92,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFooter(ThemeData theme, bool isDesktop) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SmoothPageIndicator(
          controller: _pageController,
          count: _slides.length,
          effect: ScrollingDotsEffect(
            activeDotColor: _slides[_currentPage].accent,
            dotColor: theme.colorScheme.onSurface.withOpacity(0.18),
            dotWidth: 12,
            dotHeight: 12,
            spacing: 12,
          ),
        ),
        const SizedBox(height: 18),
        if (_currentPage < _slides.length - 1)
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: _goNext,
              style: ButtonStyle(
                padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30, vertical: 16)),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.hovered)) {
                    return theme.colorScheme.primary.withOpacity(0.94);
                  }
                  return theme.colorScheme.primary;
                }),
                elevation: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.hovered) ? 16 : 10),
              ),
              child: Text(
                'Next',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        else
          Padding(
            padding: EdgeInsets.symmetric(vertical: isDesktop ? 10 : 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: widget.onCreateAround,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                      side: MaterialStateProperty.all(BorderSide(color: _slides[_currentPage].accent, width: 2.2)),
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
                          return _slides[_currentPage].accent.withOpacity(0.96);
                        }
                        return _slides[_currentPage].accent;
                      }),
                    ),
                    child: Text(
                      'Create around',
                      style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.onLogin,
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 16)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(28))),
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.hovered)) {
                          return _slides[_currentPage].accent.withOpacity(0.96);
                        }
                        return _slides[_currentPage].accent;
                      }),
                    ),
                    child: Text(
                      'Login',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _IntroSlide {
  const _IntroSlide({
    required this.title,
    required this.description,
    required this.assetName,
    required this.accent,
  });

  final String title;
  final String description;
  final String assetName;
  final Color accent;
}

class _IntroBackground extends StatelessWidget {
  const _IntroBackground({
    required this.size,
    required this.accentColor,
  });

  final Size size;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                const Color(0xFF090D1F),
                const Color(0xFF111B2C),
                const Color(0xFF0B1730),
              ],
            ),
          ),
        ),
        Positioned(
          top: -size.height * 0.12,
          left: -size.width * 0.18,
          child: _GlowCircle(
            diameter: size.width * 0.46,
            color: accentColor.withOpacity(0.22),
          ),
        ),
        Positioned(
          top: size.height * 0.14,
          right: -size.width * 0.15,
          child: _GlowCircle(
            diameter: size.width * 0.32,
            color: Colors.white.withOpacity(0.14),
          ),
        ),
        Positioned(
          bottom: -size.height * 0.08,
          right: -size.width * 0.12,
          child: _GlowCircle(
            diameter: size.width * 0.36,
            color: accentColor.withOpacity(0.18),
          ),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(color: Colors.transparent),
          ),
        ),
      ],
    );
  }
}

class _GlowCircle extends StatelessWidget {
  const _GlowCircle({required this.diameter, required this.color});

  final double diameter;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, color.withOpacity(0.0)],
          stops: const [0.0, 0.82],
        ),
      ),
    );
  }
}
