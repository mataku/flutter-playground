import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/component/recent_track/recent_track_component.dart';
import 'package:state_app/model/recent_track.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/recent_tracks_repository.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final homeNotifierProvider = ChangeNotifierProvider((ref) {
  final HomeNotifier notifier = HomeNotifier(
      recentTracksRepository: ref.read(recentTracksRepositoryProvider));
  notifier.fetchData();
  return notifier;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('News')),
        body: const MyHomePage2(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage2 extends ConsumerWidget {
  const MyHomePage2({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(homeNotifierProvider);
    final tracks = notifier.tracks;
    return ListView.builder(
      itemBuilder: (context, index) {
        return RecentTrackComponent(recentTrack: tracks[index], onTap: () {});
      },
      itemCount: tracks.length,
    );
  }
}

class HomeNotifier extends ChangeNotifier {
  final RecentTracksRepository recentTracksRepository;

  HomeNotifier({required this.recentTracksRepository});

  List<RecentTrack> tracks = List.empty();

  Future fetchData() async {
    debugPrint("MATAKUDEBUG push!!!!!!!!!!!!!");

    final result = await recentTracksRepository.getRecentTracksSample(1);
    if (result is Success) {
      tracks = result.getOrNull()!;
      notifyListeners();
    }
    debugPrint("MATAKUDEBUG ${result.getOrNull()}");
  }
}
