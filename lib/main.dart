import 'package:flutter/material.dart';
import 'package:metrics_bubble_demo/model/body_weight.dart';
import 'package:metrics_bubble_demo/view/metric_bubble.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metrics Bubble Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BodyWeight> bodyWeights = [];

  @override
  void initState() {
    super.initState();
    // We can inject data from Provider or BLOC to this screen,
    // but the sake of implementation for this demo, I initialize some data right here to use.
    BodyWeight upperBodyWeight = BodyWeight(label: 'Upper Body');
    upperBodyWeight.weight = 45;
    bodyWeights.add(upperBodyWeight);

    BodyWeight coreWeight = BodyWeight(label: 'Core');
    coreWeight.weight = 123;
    bodyWeights.add(coreWeight);

    BodyWeight lowerWeight = BodyWeight(label: 'Lower Body');
    coreWeight.weight = 315;
    bodyWeights.add(coreWeight);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Metrics Bubble Demo'),
        ),
        body: Container(
          child: ListView.builder(
            itemCount: bodyWeights.length,
            itemBuilder: (context, index) => MetricBubble(bodyWeights[index]),
          ),
        ));
  }
}
