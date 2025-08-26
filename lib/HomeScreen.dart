import 'package:flutter/material.dart';
import 'package:shaghaf_store/product_detail_screen.dart';
import 'package:shaghaf_store/products_screen.dart';
import 'package:shaghaf_store/profileScreen.dart';

import 'cart_screen.dart';
import 'models.dart';

class AppScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;

  const AppScreen({
    Key? key,
    required this.isDark,
    required this.toggleTheme,
  }) : super(key: key);

  @override
  State<AppScreen> createState() => _AppScreen();
}

class _AppScreen extends State<AppScreen> {
  final List<Product> products = [
    Product(
        name: 'بصيرا',
        price: 3.5,
        oldPrice: 7.58,
        rating: 4.9,
        reviewCount: 256,
        discount: '45% OFF',
        image: 'assets/broduct1.png',
        description: ''),
    Product(
        name: '005',
        price: 6.05,
        oldPrice: 20.0,
        rating: 4.5,
        reviewCount: 120,
        discount: '25% OFF',
        image: 'assets/broduct2.png',
        description: ''),
    Product(
        name: 'ستوكهولم',
        price: 5.0,
        oldPrice: 45.0,
        rating: 4.7,
        reviewCount: 180,
        discount: '30% OFF',
        image: 'assets/broduct3.png',
        description: ''),
    Product(
        name: 'أكتب حتى لا يأكلني الشيطان',
        price: 4.5,
        oldPrice: 20.0,
        rating: 4.3,
        reviewCount: 90,
        discount: '20% OFF',
        image: 'assets/broduct4.png',
        description: ''),
  ];

  // Categories data
  final List<Category> categories = [
    Category(name: 'novel', image: "assets/novel.png", color: Colors.blue),
    Category(
        name: 'stationery',
        image: "assets/stationery.png",
        color: Colors.green),
    Category(
        name: 'Equipment', image: "assets/Equipment.png", color: Colors.orange),
    Category(
        name: 'school books',
        image: "assets/education.png",
        color: Colors.purple),
    Category(name: 'more', image: "assets/more.png", color: Colors.yellow),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        title: SizedBox(
          height: 45,
          child: SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
              return SearchBar(
                controller: controller,
                hintText: "Search products...",
                padding: const WidgetStatePropertyAll<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 16.0),
                ),
                leading: const Icon(Icons.search),
                elevation: const WidgetStatePropertyAll<double>(0),
                onTap: () {
                  controller.openView();
                },
                onChanged: (_) {
                  controller.openView();
                },
                trailing: <Widget>[
                  Tooltip(
                    message: 'Change brightness mode',
                    child: IconButton(
                      isSelected: widget.isDark,
                      onPressed: widget.toggleTheme,
                      icon: const Icon(Icons.wb_sunny_outlined),
                      selectedIcon: const Icon(Icons.brightness_2_outlined),
                    ),
                  ),
                ],
              );
            },
            suggestionsBuilder:
                (BuildContext context, SearchController controller) {
              return List<ListTile>.generate(5, (int index) {
                final String item = 'item $index';
                return ListTile(
                  title: Text(item),
                  onTap: () {
                    setState(() {
                      controller.closeView(item);
                    });
                  },
                );
              });
            },
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(height: 200),
            ListTile(
              leading: Icon(Icons.border_inner_rounded),
              title: Text("P R O D U C T"),
              onTap: () {
                // Close the drawer first
                Navigator.pop(context);

                // Navigate to ProductsScreen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsScreen(
                      isDark: widget.isDark,
                      toggleTheme: widget.toggleTheme,
                      cartItems: [],
                    ),
                  ),
                );
              },
            ),
            // You can add more menu items here
            ListTile(
              leading: Icon(Icons.home),
              title: Text("H O M E"),
              onTap: () {
                Navigator.pop(context); // Close drawer
                // Already on home, no need to navigate
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text("C A R T"),
              onTap: () {
                Navigator.pop(context); // Close drawer
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(
                      isDark: widget.isDark,
                      toggleTheme: widget.toggleTheme,
                      cartItems: [],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.01),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Featured Content',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            const InnerBannerSlide(),
            SizedBox(height: size.height * 0.06),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Special Offers',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onBackground),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'See More',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.primary,
                        decoration: TextDecoration.underline),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.02),
            SizedBox(
              height: 280,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Material(
                      borderRadius: BorderRadius.circular(16),
                      elevation: 4,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProductDetailScreen(
                                product: product,
                                isDark: widget.isDark,
                                toggleTheme: widget.toggleTheme,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: theme.cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Only show discount if it exists
                              if (product.discount != null && product.discount!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        product.discount!,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              Expanded(
                                flex: 8,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Image.asset(
                                      product.image,
                                      height: size.height * 0.234,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 4,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      // Product name
                                      Text(
                                        product.name,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: theme.colorScheme.onBackground,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              color: theme.colorScheme.primary,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          // Only show old price if it exists
                                          if (product.oldPrice != null)
                                            Text(
                                              '\$${product.oldPrice!.toStringAsFixed(2)}',
                                              style: TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                color: Colors.grey,
                                                fontSize: 14,
                                              ),
                                            ),
                                        ],
                                      ),
                                      // Only show rating if it exists
                                      if (product.rating != null)
                                        Row(
                                          children: [
                                            const Icon(Icons.star, color: Colors.amber, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              '${product.rating!.toStringAsFixed(1)} (${product.reviewCount ?? 0})',
                                              style: const TextStyle(fontSize: 12),
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: size.height * 0.04),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Shop by Categories',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onBackground),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 2,
              ),
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {
                    print('Tapped on ${category.name}');
                  },
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      color: category.color.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    child: Row(
                      children: [
                        Image.asset(
                          category.image,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            category.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        // currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          // Handle navigation
          if (index == 0) {
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartScreen(
                  isDark: widget.isDark,
                  toggleTheme: widget.toggleTheme,
                  cartItems: [],
                ),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(
                    isDark: widget.isDark,
                    toggleTheme: widget.toggleTheme,),
              ),
            );
          }

        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'My Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline_outlined),
            label: 'My Account',
          ),
        ],
      ),
    );
  }
}

class Category {
  final String name;
  final String image;
  final Color color;

  Category({required this.name, required this.image, required this.color});
}


class InnerBannerSlide extends StatefulWidget {
  const InnerBannerSlide({super.key});

  @override
  State<InnerBannerSlide> createState() => _InnerBannerSlideState();
}

class _InnerBannerSlideState extends State<InnerBannerSlide> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<BannerItem> _bannerItems = [
    BannerItem(
      title: 'Bestsellers',
      subtitle: 'Top Reads This Month',
      imageAsset: 'assets/ads1.png',
      action: 'bestsellers',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff156651),
          Color(0x80156651),
          Colors.transparent,
        ],
      ),
    ),
    BannerItem(
      title: 'New Arrivals',
      subtitle: 'Discover Fresh Stories',
      imageAsset: 'assets/ads2.png',
      action: 'new_arrivals',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff156651),
          Color(0x80156651),
          Colors.transparent,
        ],
      ),
    ),
    BannerItem(
      title: 'Mystery & Thriller',
      subtitle: 'Edge-of-Your-Seat Reads',
      imageAsset: 'assets/ads3.png',
      action: 'mystery_thriller',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff156651),
          Color(0x80156651),
          Colors.transparent,
        ],
      ),
    ),
    BannerItem(
      title: 'Accessories',
      subtitle: 'Complete Your Setup',
      imageAsset: 'assets/ads4.png',
      action: 'accessories',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xff156651),
          Color(0x80156651),
          Colors.transparent,
        ],
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients && mounted) {
        int nextPage = _currentPage + 1;
        if (nextPage >= _bannerItems.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoScroll();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _bannerItems.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              return _buildBannerItem(_bannerItems[index]);
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildPageIndicator(theme),
      ],
    );
  }

  Widget _buildBannerItem(BannerItem item) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background image
            Image.asset(
              item.imageAsset,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: item.gradient,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black54,
                          blurRadius: 4,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(ThemeData theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_bannerItems.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _currentPage == index ? 20 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: _currentPage == index
                ? theme.colorScheme.primary
                : Colors.grey[400],
          ),
        );
      }),
    );
  }
}

class BannerItem {
  final String title;
  final String subtitle;
  final String imageAsset;
  final String action;
  final Gradient gradient;

  BannerItem({
    required this.title,
    required this.subtitle,
    required this.imageAsset,
    required this.action,
    required this.gradient,
  });
}
