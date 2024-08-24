import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:state_app/model/result.dart';
import 'package:state_app/model/user/top_album.dart';
import 'package:state_app/repository/user_repository.dart';
import 'package:state_app/ui/home/component/top_albums_component.dart';

final topAlbumsNotifier = ChangeNotifierProvider((ref) {
  final TopAlbumsNotifier notifier =
      TopAlbumsNotifier(userRepository: ref.read(userRepositoryProvider));
  notifier.fetchData();
  return notifier;
});

class TopAlbumsScreen extends ConsumerStatefulWidget {
  const TopAlbumsScreen({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TopAlbumsPageState();
  }
}

class TopAlbumsNotifier extends ChangeNotifier {
  final UserRepository userRepository;

  int _page = 1;

  TopAlbumsNotifier({
    required this.userRepository,
  });

  TopAlbumsState topAlbumsState = const TopAlbumsState(
    topAlbums: [],
    hasMore: true,
    isLoading: false,
  );

  Future fetchData() async {
    debugPrint("MATAKUDEBUG fetchData page: $_page $hashCode");
    if (!topAlbumsState.hasMore) return;
    topAlbumsState = TopAlbumsState(
      topAlbums: topAlbumsState.topAlbums,
      hasMore: topAlbumsState.hasMore,
      isLoading: true,
    );
    final result = await userRepository.getTopAlbumsSample(_page);
    if (result is Success) {
      List<TopAlbum> albums = (result as Success<List<TopAlbum>>).data;
      List<TopAlbum> currentTopAlbums = List.of(topAlbumsState.topAlbums);
      currentTopAlbums.addAll(albums);
      topAlbumsState = TopAlbumsState(
        topAlbums: currentTopAlbums,
        hasMore: albums.isNotEmpty,
        isLoading: false,
      );
      if (albums.isNotEmpty) {
        _page++;
      }
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _page = 1;
    super.dispose();
  }
}

class TopAlbumsState {
  final List<TopAlbum> topAlbums;
  final bool hasMore;
  final bool isLoading;

  const TopAlbumsState({
    required this.topAlbums,
    required this.hasMore,
    required this.isLoading,
  });
}

class _TopAlbumsPageState extends ConsumerState<TopAlbumsScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    debugPrint("MATAKUDEBUG init! ${_scrollController.hashCode}");
    _scrollController.addListener(_onScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScrollListener() {
    TopAlbumsNotifier notifier = ref.read(topAlbumsNotifier);
    TopAlbumsState topAlbumsState = notifier.topAlbumsState;
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent * 0.95 &&
        !topAlbumsState.isLoading &&
        topAlbumsState.hasMore) {
      notifier.fetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nofifier = ref.watch(topAlbumsNotifier);
    final topAlbumsState = nofifier.topAlbumsState;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: topAlbumsState.topAlbums.isEmpty
            ? const Text('empty')
            : TopAlbumsComponent(
                albums: topAlbumsState.topAlbums,
                hasMore: topAlbumsState.hasMore,
                scrollController: _scrollController,
              ),
      ),
    );
  }
}
