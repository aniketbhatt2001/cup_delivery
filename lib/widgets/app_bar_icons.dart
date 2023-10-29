import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';

import '../pages/notification.dart';
import '../utilities/constanst.dart';

class CartIcon extends ConsumerWidget {
  const CartIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () {
        //  Get.to(const CartPage());
      },
      child: const Icon(Icons.shopping_cart),
    );
  }
}

class NotificationBell extends ConsumerStatefulWidget {
  const NotificationBell({
    super.key,
  });

  @override
  ConsumerState<NotificationBell> createState() => _NotificationBellState();
}

class _NotificationBellState extends ConsumerState<NotificationBell> {
  @override
  Widget build(BuildContext context) {
    final notification = ref.watch(notificationStateProvider);
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.to(NotificationScreen(
              userId: ref.read(userprovider).deliveryUserId!));
        },
        child: Stack(
          children: [
            const Icon(
              Icons.notifications,
              color: Colors.white,
              size: 25,
            ),
            Positioned(
              right: -2,
              top: -4,
              child: Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(
                  color: primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    notification.count != null
                        ? notification.count.toString()
                        : '0',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
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

class ProductSearch extends StatelessWidget {
  const ProductSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //  Get.to(const ProductSearchPage());
      },
      child: const Icon(
        Icons.search,
      ),
    );
  }
}
