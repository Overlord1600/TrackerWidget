import 'package:flutter/material.dart';
import 'package:tracker_project/custom_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.add))],
        title: const Text("Tracker widget demo"),
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        Container(
            padding: const EdgeInsets.all(20),
            child: Tracker(
              // lineWidth: 4.0,
              titleStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              contentStyle: const TextStyle(fontSize: 15, color: Colors.white),
              //iconBackgroundColor: const Color.fromRGBO(255, 124, 21, 1),
              // titleStyle: const TextStyle(fontSize: 30, color: Colors.black),
              // contentStyle: const TextStyle(fontSize: 60, color: Colors.black),
              verticalTextAlign: TrackerAlignment.top,
              shouldIconHaveBackground: true,
              shouldIconHaveBorder: false,
              iconBorderColor: const Color.fromARGB(255, 255, 255, 255),
              titleList: const ["Ordered", "Shipped", "On its way", ""],
              contentList: const [
                "NY,United States",
                "California, United States",
                "In progress. There might be delay expected due to weather conditions and unavailiblity of delivery agents please contact customer service in case of delivery time change",
                ""
              ],
              nodeCount: 4,
              // statusIcons: const [
              //   Icon(
              //     Icons.shopping_bag,
              //   ),
              //   Icon(
              //     Icons.delivery_dining_outlined,
              //   ),
              //   Icon(
              //     Icons.fire_truck,
              //   ),
              //   Icon(
              //     Icons.check,
              //   )
              // ],
              height: 300,
              completedColor: const Color.fromARGB(255, 0, 173, 35),
              incompleteColor: const Color.fromRGBO(128, 128, 128, 1),
              context: context,
              width: 200,
              circleRadius: 13,
              inProgressColor: const Color.fromARGB(255, 73, 171, 210),
              isSecondaryColumnEnabled: true,
              secondaryTitleList: const [
                "01,Jan 2024",
                "04,Jan 2024",
                "07,Jan 2024",
                "Delivery"
              ],
              secondaryContentList: const [
                "10:20 AM",
                "10:40 AM",
                "9:00 AM",
                "Estimated September 26,2024"
              ],
              statusCompletedList: const [
                TrackerStatus.completed,
                TrackerStatus.completed,
                TrackerStatus.inProgress,
                TrackerStatus.incomplete
              ],
            ))
      ])),
    )
        // This trailing comma makes auto-formatting nicer for build methods.
        );
  }
}
