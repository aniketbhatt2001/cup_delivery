import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omniedeliveryapp/models/delivery_model_res_model.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';

import '../apiservice/user_services.dart';

final ordersToggler = StateProvider.autoDispose((ref) => false);
final ordersProvider =
    FutureProvider.autoDispose<DeliveryOrdersModelRes?>((ref) {
  ref.watch(ordersToggler);
  return UserServices.fetchCurrentOrders(
      ref.read(userprovider).deliveryUserId!);
});
