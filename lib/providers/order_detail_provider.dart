import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:omniedeliveryapp/apiservice/user_services.dart';
import 'package:omniedeliveryapp/models/order_detail_model.dart';
import 'package:omniedeliveryapp/pages/order_detail.dart';
import 'package:omniedeliveryapp/providers/user_provider.dart';

final orderDetailProvider = FutureProvider.autoDispose
    .family<OrderDetailModel?, String>((ref, orderNo) async {
  ref.watch(toggleOrderDetailProvider);
  return UserServices.fetchOrderDeatil(
      ref.read(userprovider).deliveryUserId!, orderNo);
});
final toggleOrderDetailProvider = StateProvider.autoDispose((ref) => false);
