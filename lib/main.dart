import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:test_app/screen_mvvm.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}
