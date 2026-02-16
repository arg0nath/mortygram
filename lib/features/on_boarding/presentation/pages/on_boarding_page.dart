import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mortygram/core/common/extensions/context_ext.dart';
import 'package:mortygram/core/routes/route_names.dart';
import 'package:mortygram/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:mortygram/features/on_boarding/presentation/widgets/on_boarding_button_bar.dart';
import 'package:mortygram/features/on_boarding/presentation/widgets/on_boarding_pages.dart';
import 'package:mortygram/features/on_boarding/presentation/widgets/on_boarding_slide.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    context.read<OnBoardingCubit>().checkIfUserFirstTimer();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _nextPage() {
    if (_currentPage < onBoardingPages.length - 1) {
      _pageController.animateToPage(_currentPage + 1, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      context.read<OnBoardingCubit>().cacheFirstTimer();
    }
  }

  void _skipToEnd() {
    context.read<OnBoardingCubit>().cacheFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnBoardingCubit, OnBoardingState>(
      listener: (BuildContext context, OnBoardingState state) {
        if ((state is OnBoardingStatus && !state.isFirstTimer) || (state is UserCached)) {
          context.goNamed(RouteName.charactersPageName);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: <Widget>[
            TextButton(
              onPressed: _skipToEnd,
              child: Text('Skip', style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              // pages
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: onBoardingPages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return OnBoardingSlide(data: onBoardingPages[index], index: index);
                  },
                ),
              ),

              // page indicators
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: AnimatedSmoothIndicator(
                  activeIndex: _currentPage,
                  count: onBoardingPages.length,
                  effect: ExpandingDotsEffect(activeDotColor: context.colorScheme.primary, dotHeight: 10, dotWidth: 10, expansionFactor: 3),
                ),
              ),

              // bottom button
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: OnBoardingButtonBar(currentPage: _currentPage, totalPages: onBoardingPages.length, onNext: _nextPage),
                ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.3, end: 0, curve: Curves.easeOut),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
