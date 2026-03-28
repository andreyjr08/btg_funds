import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:btg_funds_app/domain/usecases/subscribe_to_fund.dart';

final subscribeUseCaseProvider = Provider<SubscribeToFund>((ref) {
  return SubscribeToFund();
});
