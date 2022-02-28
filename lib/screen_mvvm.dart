import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/data/count_data.dart';
import 'models/provider_model.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
                ref.watch(countDataProvider).count.toString(), //文字列に変換
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      CountData countData = ref.read(countDataProvider);
                      ref.read(countDataProvider.state).state = ref
                          .read(countDataProvider)
                          .copyWith(
                              count: countData.count + 1,
                              countUp: countData.countUp + 1);
                    },
                    child: const Icon(CupertinoIcons.plus),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      CountData countData = ref.read(countDataProvider);
                      ref.read(countDataProvider.state).state = ref
                          .read(countDataProvider)
                          .copyWith(
                              count: countData.count - 1,
                              countDown: countData.countDown + 1);
                    },
                    child: const Icon(CupertinoIcons.minus),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(ref
                      .watch(countDataProvider.select((value) => value.countUp))
                      .toString()),
                  Text(ref
                      .watch(
                          countDataProvider.select((value) => value.countDown))
                      .toString()),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return FloatingActionButton(
          onPressed: () {
            ref.read(countDataProvider.state).state =
                const CountData(count: 0, countUp: 0, countDown: 0);
          },
          child: const Icon(Icons.refresh),
        );
      }),
      //Consumerにすることによって無駄なrebuildをなくしてくれる
    );
  }
}
