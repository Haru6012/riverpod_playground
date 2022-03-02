import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/logic.dart';
import 'models/provider_model.dart';

class ViewModel {
  Logic _logic = Logic();
  late WidgetRef _ref;

  void setRef(WidgetRef ref) {
    this._ref = ref;
  }

  get count => _ref.watch(countDataProvider).count.toString();
}

