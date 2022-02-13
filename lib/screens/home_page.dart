import 'package:bloc_practice/constants/enums.dart';
import 'package:bloc_practice/cubit/counter_cubit.dart';
import 'package:bloc_practice/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: BlocListener<InternetCubit, InternetState>(
          listener: (context, state) {
            if (state is InternetConnected &&
                state.connectivityType == ConnectivityType.Mobile)
              BlocProvider.of<CounterCubit>(context).increment();
            else if (state is InternetConnected &&
                state.connectivityType == ConnectivityType.Wifi)
              BlocProvider.of<CounterCubit>(context).decrrement();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              BlocBuilder<InternetCubit, InternetState>(
                builder: (context, state) {
                  if (state is InternetConnected &&
                      state.connectivityType == ConnectivityType.Mobile) {
                    return Text(
                      'Mobile data',
                    );
                  } else if (state is InternetConnected &&
                      state.connectivityType == ConnectivityType.Wifi) {
                    return Text(
                      'Wifi',
                    );
                  } else if (state is InternetDisconnected) {
                    return Text(
                      'Disconnected',
                    );
                  }
                  return Text(
                    'Disconnected',
                  );
                  ;
                },
              ),
              Builder(builder: (context) {
                final counterC = context.watch<CounterCubit>().state;
                final internetC = context.watch<InternetCubit>().state;
                // final counterC = BlocProvider.of<CounterCubit>(context,listen: true).state;
                //      final internetC = BlocProvider.of<InternetCubit>(context,listen: true).state;
                if (internetC is InternetConnected &&
                    internetC.connectivityType == ConnectivityType.Wifi) {
                  return Text(internetC.connectivityType.toString() +
                      counterC.counterValue.toString());
                } else if (internetC is InternetConnected &&
                    internetC.connectivityType == ConnectivityType.Mobile) {
                  return Text(internetC.connectivityType.toString() +
                      counterC.counterValue.toString());
                } else {
                  return Text(
                      'Disconnected' + counterC.counterValue.toString());
                }
              }),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).decrrement();
                        }),
                    BlocConsumer<CounterCubit, CounterState>(
                      listener: (context, state) {
                        if (state.isIncreased == true) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Increased!')));
                        } else if (state.isIncreased == false) {
                          Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text('Decreased!')));
                        }
                      },
                      builder: (context, state) {
                        if (state.counterValue >= 0) {
                          return Text(
                            '${state.counterValue}',
                            style: Theme.of(context).textTheme.headline4,
                          );
                        } else {
                          return Text(
                            'Err! Negative value',
                            style: Theme.of(context).textTheme.headline4,
                          );
                        }
                      },
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          BlocProvider.of<CounterCubit>(context).increment();
                        })
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text('Second Screen'),
              )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
