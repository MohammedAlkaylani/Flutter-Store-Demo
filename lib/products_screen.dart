import 'package:flutter/material.dart';
import 'cart_screen.dart';
import 'product_detail_screen.dart';
import 'models.dart' hide CartItem; // Import the unified models

class ProductsScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;
  final List<CartItem> cartItems;

  const ProductsScreen({
    Key? key,
    required this.isDark,
    required this.toggleTheme,
    required this.cartItems,
  }) : super(key: key);

  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final List<Product> products = [
    Product(
      name: 'كل أزرق سماء',
      price: 2,
      image: 'assets/p1.jpg',
      description: 'رواية عاطفية شاعرية تبحث في تفاصيل الحب والحنين.',
    ),
    Product(
      name: 'يأجوج ومأجوج',
      price: 4,
      oldPrice: 5,
      discount: '20%',
      rating: 4.2,
      reviewCount: 85,
      image: 'assets/p2.jpg',
      description: 'كتاب ديني يتناول قصة يأجوج ومأجوج في الموروث الإسلامي.',
    ),
    Product(
      name: 'حالات حرجة',
      price: 0.5,
      image: 'assets/p3.jpg',
      description: 'مجموعة قصص قصيرة مستوحاة من تجارب إنسانية وأحداث واقعية.',
    ),
    Product(
      name: 'كيف سأكون من دونك',
      price: 4.7,
      oldPrice: 6,
      discount: '22%',
      rating: 4.7,
      reviewCount: 150,
      image: 'assets/p4.jpg',
      description: 'رواية رومانسية مؤثرة تروي حكاية الفقد والحب المستحيل.',
    ),
    Product(
      name: 'العادات الذرية',
      price: 2.9,
      image: 'assets/p5.jpg',
      description: 'كتاب تطوير الذات الأشهر لتغيير العادات وبناء روتين ناجح.',
    ),
    Product(
      name: 'لأنها كيارا',
      price: 9,
      oldPrice: 12,
      discount: '25%',
      image: 'assets/p6.jpg',
      description: 'قصة مشوقة عن الصداقة والحب المليء بالتحديات.',
    ),
    Product(
      name: '005',
      price: 6.05,
      rating: 4.0,
      reviewCount: 60,
      image: 'assets/p7.jpg',
      description: 'رواية غامضة تحمل في طياتها أسراراً وأحداثاً غير متوقعة.',
    ),
    Product(
      name: 'من الذي حرك قطعة الجبن',
      price: 3.50,
      oldPrice: 5,
      discount: '30%',
      rating: 4.6,
      reviewCount: 180,
      image: 'assets/p8.jpg',
      description: 'كتاب تحفيزي يساعدك على مواجهة التغيير والتكيف مع الحياة.',
    ),
    Product(
      name: 'بصيرا',
      price: 3.5,
      image: 'assets/broduct1.png',
      description: 'كتاب ملهم يقدم رؤى عميقة في الحياة والتنمية الذاتية.',
    ),
    Product(
      name: 'ستوكهولم',
      price: 5.0,
      rating: 4.4,
      image: 'assets/broduct3.png',
      description: 'رواية مشوقة تكشف الأسرار النفسية والصراعات الداخلية لشخصياتها.',
    ),
    Product(
      name: 'أكتب حتى لا يأكلني الشيطان',
      price: 4.5,
      oldPrice: 6,
      discount: '25%',
      rating: 4.9,
      reviewCount: 220,
      image: 'assets/broduct4.png',
      description: 'كتاب تحفيزي يسلط الضوء على قوة الكتابة في مواجهة التحديات والأفكار السلبية.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'All Products',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onBackground,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              widget.isDark
                  ? Icons.wb_sunny_outlined
                  : Icons.brightness_2_outlined,
              color: theme.iconTheme.color,
            ),
            onPressed: widget.toggleTheme,
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CartScreen(
                    isDark: widget.isDark,
                    toggleTheme: widget.toggleTheme,
                    cartItems: widget.cartItems,
                  ),
                ),
              ).then((_) => setState(() {}));
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.70,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return _buildProductCard(product, theme);
        },
      ),
    );
  }

  Widget _buildProductCard(Product product, ThemeData theme) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailScreen(
                product: product,
                isDark: widget.isDark,
                toggleTheme: widget.toggleTheme,
              ),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: theme.cardColor,
                  image: DecorationImage(
                    image: AssetImage(product.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Product Name
              Text(
                product.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onBackground,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              // Product Description
              Expanded(
                child: Text(
                  product.description,
                  style: TextStyle(
                    fontSize: 12,
                    color: theme.colorScheme.onBackground.withOpacity(0.7),
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              // Price and Add button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        widget.cartItems.add(
                          CartItem(
                            name: product.name,
                            currentPrice: product.price,
                            originalPrice: product.oldPrice ?? product.price,
                            discount: product.discount ?? '',
                            color: 'Default',
                            image: product.image,
                            quantity: 1,
                          ),
                        );
                      });

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${product.name} added to cart"),
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'Add',
                      style: TextStyle(
                        fontSize: 12,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}