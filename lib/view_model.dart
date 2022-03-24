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
  get coutUp =>
      _ref.watch(countDataProvider.select((value) => value.countUp)).toString();
  get countDown => _ref
      .watch(countDataProvider.select((value) => value.countDown))
      .toString();

  void onIncrease() {
    _logic.increase();
    _ref.watch(countDataProvider.state).state = _logic.countData;
  }

  void onReset() {
    _logic.reset();
    _ref.watch(countDataProvider.state).state = _logic.countData;
  }
}
