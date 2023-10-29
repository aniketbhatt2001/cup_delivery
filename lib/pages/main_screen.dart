import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:omniedeliveryapp/apiservice/notification_services.dart';
import 'package:omniedeliveryapp/pages/current_orders.dart';
import 'package:omniedeliveryapp/pages/notification.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';
import 'package:omniedeliveryapp/widgets/loading_waves.dart';

import '../providers/order_provider.dart';
import '../utilities/constanst.dart';

final homeScreenProvider = FutureProvider.autoDispose((ref) {
  Future.delayed(const Duration(seconds: 0));
});

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  @override
  void initState() {
    // TODO: implement initState
    NotificationService.inItLocalNotification(
        context, ref.read(userprovider).deliveryUserId!, ref);
    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    return WillPopScope(
      onWillPop: () async {
        return F;
      },
      child: Consumer(builder: (context, ref, _) {
        final result = ref.watch(homeScreenProvider);
        return Scaffold(
          body: result.when(
            data: (data) {
              return const CurrentOrders();
            },
            error: (error, stackTrace) {
              return Center(
                child: Text(error.toString()),
              );
            },
            loading: () => const Center(
              child: LoadingWaves(),
            ),
          ),
        );
      }),
    );
  }
}
