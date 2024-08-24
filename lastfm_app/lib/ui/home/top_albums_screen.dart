import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/user/top_album.dart';
import 'package:state_app/repository/user_repository.dart';
import 'package:state_app/ui/home/component/top_albums_component.dart';

final topAlbumsNotifier = ChangeNotifierProvider.autoDispose((ref) {
  final TopAlbumsNotifier notifier =
      TopAlbumsNotifier(userRepository: ref.read(userRepositoryProvider));
  notifier.fetchData();
  return notifier;
});

class TopAlbumsScreen extends ConsumerWidget {
  const TopAlbumsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nofifier = ref.watch(topAlbumsNotifier);
    final topAlbums = nofifier.albums;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: topAlbums.isEmpty
            ? const Text('empty')
            : TopAlbumsComponent(albums: topAlbums),
      ),
    );
  }
}

class TopAlbumsNotifier extends ChangeNotifier {
  final UserRepository userRepository;

  TopAlbumsNotifier({
    required this.userRepository,
  });

  List<TopAlbum> albums = List.empty();

  Future fetchData() async {
    final result = await userRepository.getTopAlbumsSample(1);
    if (result is Success) {
      albums = (result as Success<List<TopAlbum>>).data;
      notifyListeners();
    }
  }
}
