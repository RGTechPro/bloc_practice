
import 'package:bloc_practice/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
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
                      }
                     else if (state.isIncreased == false) {
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
            ),  MaterialButton(
              onPressed: () {
                Navigator.pushNamed(context, '/');
              },
              child: Text('First Screen'),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
