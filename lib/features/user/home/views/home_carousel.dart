import 'dart:async';

import 'package:beclean/routes/app_routes.dart';
import 'package:flutter/material.dart';

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({super.key});

  @override
  State<HomeCarousel> createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  final PageController _pageController = PageController(
    viewportFraction: 0.85,
    initialPage: 1,
  );
  Timer? _timer;
  int _currentPage = 0;

  final List<Map<String, dynamic>> _carouselItems = [
    {"image": "assets/images/carousel.png", "color": Colors.white},
    {"image": "assets/images/carousel_1.png", "color": Colors.white},
    {"image": "assets/images/carousel_2.png", "color": Colors.white},
  ];

  void _onPageChanged(int index) {
    if (index == 0) {
      setState(() {
        _currentPage = _carouselItems.length - 1;
      });
    } else if (index == _carouselItems.length + 1) {
      setState(() {
        _currentPage = 0;
      });
    } else {
      setState(() {
        _currentPage = index - 1;
      });
    }
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> loopItems = [
      _carouselItems.last,
      ..._carouselItems,
      _carouselItems.first,
    ];

    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _pageController,
            itemCount: loopItems.length,
            onPageChanged: (index) {
              if (index == 0) {
                Future.delayed(Duration.zero, () {
                  _pageController.jumpToPage(_carouselItems.length);
                });
              } else if (index == loopItems.length - 1) {
                Future.delayed(Duration.zero, () {
                  _pageController.jumpToPage(1);
                });
              }
              _onPageChanged(index);
            },
            itemBuilder: (context, index) {
              final item = loopItems[index];
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.productUser);
                },
                child: _buildCarouselCard(
                  imagePath: item["image"],
                  bgColor: item["color"],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildDotIndicator(),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildCarouselCard({
    required String imagePath,
    required Color bgColor,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color.fromARGB(255, 47, 124, 40),
          width: 1,
        ),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
          opacity: 0.85,
        ),
      ),
    );
  }

  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_carouselItems.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: _currentPage == index ? 24 : 8,
          decoration: BoxDecoration(
            color: _currentPage == index
                ? const Color.fromARGB(255, 23, 87, 14)
                : Colors.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
