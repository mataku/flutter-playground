import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/repository/auth_repository.dart';

final loginNotifierProvider = ChangeNotifierProvider.autoDispose(
    (ref) => LoginNotifier(authRepository: ref.read(authRepositoryProvider)));

class LoginScreen extends ConsumerWidget {
  final usernameTextEditController = TextEditingController();
  final passwordTextEditController = TextEditingController();

  LoginScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(loginNotifierProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Login to Last.fm',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 24)),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                controller: usernameTextEditController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Username is empty';
                  }
                  return null;
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 16)),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: TextFormField(
                controller: passwordTextEditController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.visiblePassword,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is empty';
                  }

                  return null;
                },
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 48)),
            ElevatedButton(
              onPressed: () {
                notifier.login(
                  username: usernameTextEditController.text,
                  password: passwordTextEditController.text,
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Let me in!',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginNotifier extends ChangeNotifier {
  final AuthRepository _authRepository;

  LoginNotifier({required AuthRepository authRepository})
      : _authRepository = authRepository;

  Future login({required String username, required String password}) async {
    final result =
        _authRepository.authorize(username: username, password: password);
    if (result is Success<String>) {}
  }
}
