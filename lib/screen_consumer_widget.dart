import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/provider_model.dart';

class MyAppConsumerWdget extends StatelessWidget {
  const MyAppConsumerWdget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) => Text(
            ref.watch(titleProvider),
          ),
        ),
      ),
      body: Center(
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) =>
              Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(ref.watch(textProvider)),
              Text(
                ref.watch(countProvider).toString(), //文字列に変換
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
          //print("rebuild");
        return FloatingActionButton(
          onPressed: () => ref.read(countProvider.state).state++,
          //readにすることによって、無駄なrebuildを防ぐ
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        );
      }),
      //Consumerにすることによって無駄なrebuildをなくしてくれる
    );
  }
}