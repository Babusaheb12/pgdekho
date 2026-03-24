import 'package:flutter/material.dart';

class MyOnboardingScreen extends StatefulWidget {
   MyOnboardingScreen({super.key});

  @override
  State<MyOnboardingScreen> createState() => _MyOnboardingScreenState();
}

class _MyOnboardingScreenState extends State<MyOnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> _images = [
    'https://images.unsplash.com/photo-1505881502353-a1986add3762?w=1200',
    'https://images.unsplash.com/photo-1500835595353-b0ad2e58b2ad?w=1200',
    'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=1200',
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _images.length - 1) {
      _pageController.nextPage(
        duration:  Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// ✅ 1. Image Slider
          PageView.builder(
            controller: _pageController,
            physics:  BouncingScrollPhysics(),
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Image.network(
                _images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,

                /// ✅ Loader
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return  Center(
                    child: CircularProgressIndicator(),
                  );
                },

                /// ✅ Error fallback
                errorBuilder: (context, error, stackTrace) {
                  return  Center(
                    child: Icon(Icons.broken_image, color: Colors.white, size: 40),
                  );
                },
              );
            },
          ),

          /// ✅ 2. Gradient Overlay (does NOT block swipe)
          Positioned.fill(
            child: IgnorePointer(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.2),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// ✅ 3. Content UI
          SafeArea(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    "Discover the\nBeauty of the\nWorld with Us",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      height: 1.1,
                    ),
                  ),
                   SizedBox(height: 16),
                   Text(
                    "If you like to travel, this is the place for you! Your adventure starts here and enjoy it",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                    ),
                  ),
                   SizedBox(height: 40),

                  /// ✅ Bottom Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      /// 🔵 Indicator Dots
                      Row(
                        children: List.generate(
                          _images.length,
                              (index) => AnimatedContainer(
                            duration:  Duration(milliseconds: 300),
                            margin:  EdgeInsets.only(right: 8),
                            height: 4,
                            width: index == _currentPage ? 28 : 12,
                            decoration: BoxDecoration(
                              color: index == _currentPage
                                  ? Colors.white
                                  : Colors.white38,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                      ),

                      /// 🔶 Button
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF14B8A6),
                          padding:  EdgeInsets.symmetric(
                              horizontal: 32, vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentPage == _images.length - 1
                              ? "Get Started"
                              : "Next",
                          style:  TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}