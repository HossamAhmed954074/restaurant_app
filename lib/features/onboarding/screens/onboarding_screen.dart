import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resturant_app/core/router/app_router.dart';
import 'package:resturant_app/core/utils/styles/app_text_style.dart';
import 'package:resturant_app/features/onboarding/widgets/intro_component.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../generated/assets.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;
  List<Widget> pages = [
    const IntroComponent(imagePath: Assets.onboardingOnboarding1),
    const IntroComponent(imagePath: Assets.onboardingOnboarding2),
    const IntroComponent(imagePath: Assets.onboardingOnboarding3),
  ];

  List<String> titles = [
    'The Best Resturant in London',
    'With Their Top Menu Items \n Waiting For You',
    'They Cant\'t Wait To Serve You',
  ];

  void _skip() {
    _pageController.animateToPage(
      pages.length - 1,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onNext() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    setState(() {
      currentPage++;
    });
  }

  void _onGetStarted() async {
    GoRouter.of(context).pushReplacement(AppRouter.kGetStartedScreen);
    // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // sharedPreferences.setBool('onboarding', true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (value) {
                setState(() {
                  currentPage = value;
                });
              },

              //  physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => pages[index],
              itemCount: pages.length,
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 110,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Text(
                    titles[currentPage],
                    style: AppTextStyle.heading2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            currentPage != pages.length - 1
                ? Positioned(
                    bottom: 30,
                    left: 20,
                    child: TextButton(
                      onPressed: _skip,
                      child: Text(
                        'Skip',
                        style: AppTextStyle.buttonText.copyWith(
                          color: Colors.red,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            Positioned(
              bottom: 30,
              right: 20,
              child: TextButton(
                onPressed: currentPage == pages.length - 1
                    ? _onGetStarted
                    : _onNext,
                child: Text(
                  currentPage == pages.length - 1 ? 'Get Started' : 'Next',
                  style: currentPage == pages.length - 1
                      ? GoogleFonts.lora(
                          textStyle: AppTextStyle.buttonText.copyWith(
                            color: Colors.green,
                          ),
                        )
                      : AppTextStyle.buttonText.copyWith(color: Colors.blue),
                ),
              ),
            ),

            Positioned(
              left: 0,
              right: 0,
              bottom: 50,
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController,
                  count: pages.length,
                  effect: const WormEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.blue,
                    dotHeight: 12,
                    dotWidth: 12,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
