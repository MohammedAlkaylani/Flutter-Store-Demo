import 'package:flutter/material.dart';
import 'models.dart';

class CartScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback toggleTheme;
  final List<CartItem> cartItems;

  const CartScreen({
    Key? key,
    required this.isDark,
    required this.toggleTheme,
    required this.cartItems,
  }) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  double get totalPrice {
    return widget.cartItems.fold(
      0,
          (sum, item) => sum + (item.currentPrice * item.quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Cart',
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
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];
                return _buildCartItem(item, theme);
              },
            ),
          ),
          _buildTotalSection(theme),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item, ThemeData theme) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: theme.cardColor,
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(item.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 12),
            // Product Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${item.currentPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Quantity Controls
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove, size: 20),
                        onPressed: () {
                          setState(() {
                            if (item.quantity > 1) {
                              item.quantity--;
                            } else {
                              widget.cartItems.remove(item);
                            }
                          });
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.dividerColor),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add, size: 20),
                        onPressed: () {
                          setState(() {
                            item.quantity++;
                          });
                        },
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.delete_outline,
                            color: Colors.red),
                        onPressed: () {
                          setState(() {
                            widget.cartItems.remove(item);
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor,
        border: Border(top: BorderSide(color: theme.dividerColor)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Total'),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final String name;
  final double currentPrice;
  final double originalPrice;
  final String discount;
  final String color;
  final String image;
  int quantity;

  CartItem({
    required this.name,
    required this.currentPrice,
    required this.originalPrice,
    required this.discount,
    required this.color,
    required this.image,
    required this.quantity,
  });
}
