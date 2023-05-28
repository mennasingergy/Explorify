import 'package:explorify/Search/MySearchPage.dart';
import 'package:explorify/main_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Categories/categories_screen.dart';
import 'Category/Provider.dart';
import 'Category/category_screen.dart';
import 'Explore/exploreCard.dart';
import 'Explore/explore_screen.dart';
import 'Intro/tabscontroller_screen.dart';
import 'Post/post_screen.dart';
import 'Saved/saved.dart';
import 'Saved/saved_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import './Intro/Bismillah.dart';
import 'Auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //bool _initialized = false;
  //bool _error = false;

  // void initializeFlutterFire() async {
  //   try {
  //     await Firebase.initializeApp();
  //     setState(() {
  //       _initialized = true;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _error = true;
  //     });
  //   }
  // }

  // @override
  // void initState()  {
  //    initializeFlutterFire();
  //   super.initState();
  // }

  //final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
    create: (ctx) => FavProvider(),
    child: MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (dummCtx) => const MainPage(),
        '/exploreRoute': (dummyCtx) => ExplorePage(),
        '/categoriesRoute': (dummyCtx) => const TabsControllerScreen(),
        '/categoryRoute': (dummyCtx) => CategoryScreen(),
        '/favoriteRoute': (dummyCtx) => FavScreen(),
        '/ExploreRoute': (dummyCtx) => ExploreScreen(),
        '/postRoute': (dummyCtx) => PostScreen(),
        '/SearchRoute': (dummyCtx) => MySearchPage()
      },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text('Explorify'),
      ),
      // body: LoginPage(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
