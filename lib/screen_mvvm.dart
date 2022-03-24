import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'models/data/count_data.dart';
import 'models/provider_model.dart';
import 'view_model.dart';

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

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  ViewModel _viewModel = ViewModel();
  @override
  void initState() {
    super.initState();

    _viewModel.setRef(ref);
  }

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
                _viewModel.count,
                //viewModelを作ることで簡単にアクセスすることができる
                style: Theme.of(context).textTheme.headline4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      _viewModel.onIncrease();
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
                  Text(_viewModel.coutUp),
                  Text(_viewModel.countDown),
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
            _viewModel.onReset();
          },
          child: const Icon(Icons.refresh),
        );
      }),
      //Consumerにすることによって無駄なrebuildをなくしてくれる
    );
  }
}
