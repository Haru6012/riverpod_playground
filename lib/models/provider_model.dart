import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'data/count_data.dart';

final titleProvider = Provider<String>((ref) {
  return "CounterProviderApp";
});

final textProvider = Provider<String>((ref) {
  return "ボタンを押した回数:";
});

final countProvider = StateProvider<int>((ref) => 0); //StateProvider

final countDataProvider = StateProvider<CountData>((ref) => const CountData(
      count: 0,
      countUp: 0,
      countDown: 0,
    ));//StateProvider
