import 'package:bloc_beginner/bloc/counter_bloc.dart';
import 'package:bloc_beginner/screen/news_screen.dart';
import 'package:bloc_beginner/widget/round_icon_%20button.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.blocDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('----- Widget Tree -------');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
              icon: Icon(Icons.arrow_forward),
              onPressed: () => {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => NewsScreen()))
                  })
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder(
              stream: counterBloc.counterStream,
              initialData: 0,
              builder: (context, snapshot) {
                if (snapshot.hasData)
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                if (snapshot.hasError) print(snapshot.error);
                return Text('Error');
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            RoundIconButton(
              icon: Icons.add,
              onPress: () {
                counterBloc.eventSink.add(CounterAction.Increment);
              },
            ),
            RoundIconButton(
              icon: Icons.remove,
              onPress: () {
                counterBloc.eventSink.add(CounterAction.Decrement);
              },
            ),
            RoundIconButton(
              icon: Icons.loop,
              onPress: () {
                counterBloc.eventSink.add(CounterAction.Reset);
              },
            ),
          ],
        ),
      ),
    );
  }
}
