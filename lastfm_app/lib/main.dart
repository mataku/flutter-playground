import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/router/router.dart';
import 'package:state_app/store/kv_store.dart';
import 'package:state_app/ui/common/theme_notifier.dart';
import 'package:state_app/ui/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: reconsider
  await KVStore().init();
  runApp(
    ProviderScope(
      child: Consumer(builder: (context, ref, child) {
        return FutureBuilder(
          future: ref.watch(themeNotifierProvider.notifier).getCurrentTheme(),
          builder: (context, AsyncSnapshot<AppTheme> snapshot) {
            return snapshot.hasData
                ? const MyApp()
                : const CircularProgressIndicator();
          },
        );
      }),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final themeNotifier = ref.watch(themeNotifierProvider);
    final theme = themeNotifier.appTheme ?? AppTheme.dark;

    return MaterialApp.router(
      title: '',
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
        colorScheme: theme.colorScheme,
        useMaterial3: true,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        brightness: theme.brightness,
      ),
      builder: (context, child) {
        return ColoredBox(
          color: theme.colorScheme.surface,
          child: child,
        );
      },
      routerConfig: router,
    );
  }
}
