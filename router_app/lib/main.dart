import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const MyApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FirstScreen(),
      routes: [
        GoRoute(
          path: 'second',
          builder: (context, state) => const SecondScreen(),
          routes: [
            GoRoute(
                path: 'third',
                builder: (context, state) => const ThirdScreen()),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // initialRoute: '/',
      // routes: {
      //   '/': (context) => const FirstScreen(),
      //   '/second': (context) => const SecondScreen(),
      //   '/second/third': (context) => const ThirdScreen()
      // },
      routerConfig: _router,
    );
  }
}

class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First screen'),
      ),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
              child: const Text('Go to first'),
              onPressed: () {
                // Navigator.of(context).pushNamed('/second');
                // MaterialPageRoute: iOS: slideIn, Android: zoonIn
                // .push(MaterialPageRoute(builder: (_) => const SecondScreen()));
                GoRouter.of(context).push('/');
              }),
          ElevatedButton(
              child: const Text('Go to second'),
              onPressed: () {
                // Navigator.of(context).pushNamed('/second');
                // MaterialPageRoute: iOS: slideIn, Android: zoonIn
                // .push(MaterialPageRoute(builder: (_) => const SecondScreen()));
                GoRouter.of(context).push('/second');
              }),
          ElevatedButton(
            child: const Text('Go to third via SecondScreen (go)'),
            onPressed: () {
              // Navigator.of(context) .pushNamed('/second/third');
              // MaterialPageRoute: iOS: slideIn, Android: zoonIn
              // .push(MaterialPageRoute(builder: (_) => const SecondScreen()));

              // go: Go to ThirdScreen via SecondScreen
              // push: Go to ThirdScreen, back to FirstScreen

              GoRouter.of(context).go('/second/third');
            },
          ),
          ElevatedButton(
            child: const Text('Go to third directly (push)'),
            onPressed: () {
              // Navigator.of(context) .pushNamed('/second/third');
              // MaterialPageRoute: iOS: slideIn, Android: zoonIn
              // .push(MaterialPageRoute(builder: (_) => const SecondScreen()));

              // go: Go to ThirdScreen via SecondScreen
              // push: Go to ThirdScreen, back to FirstScreen

              GoRouter.of(context).push('/second/third');
            },
          )
        ]),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            child: const Text('Back'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: const Text('Go to third'),
            onPressed: () {
              // Navigator.of(context).pushNamed('/second/third');
              // .push(MaterialPageRoute(builder: (_) => const ThirdScreen()));
              GoRouter.of(context).push('/second/third');
            },
          ),
        ],
      )),
    );
  }
}

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third screen'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Back'))
        ],
      )),
    );
  }
}
