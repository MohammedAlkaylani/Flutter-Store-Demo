import 'package:flutter/material.dart';
import 'models.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product product;
  final bool isDark;
  final VoidCallback toggleTheme;

  const ProductDetailScreen({
    super.key,
    required this.product,
    required this.isDark,
    required this.toggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          product.name,
          style: TextStyle(color: theme.colorScheme.onBackground),
        ),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isDark ? Icons.wb_sunny_outlined : Icons.brightness_2_outlined,
              color: theme.iconTheme.color,
            ),
            onPressed: toggleTheme,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Name
                  Text(
                    product.name,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Only show old price if it exists
                      if (product.oldPrice != null)
                        Text(
                          '\$${product.oldPrice!.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 16,
                            decoration: TextDecoration.lineThrough,
                            color: theme.colorScheme.onBackground.withOpacity(0.6),
                          ),
                        ),
                      const SizedBox(width: 10),
                      // Only show discount if it exists
                      if (product.discount != null && product.discount!.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            product.discount!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Rating - Only show if it exists
                  if (product.rating != null)
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        const SizedBox(width: 4),
                        Text(
                          '${product.rating!.toStringAsFixed(1)} (${product.reviewCount ?? 0} reviews)',
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),

                  const SizedBox(height: 24),

                  // Description
                  Text(
                    'Product Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description.isNotEmpty
                        ? product.description
                        : 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add to cart functionality
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart'),
                            backgroundColor: theme.colorScheme.primary,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 18,
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
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
}