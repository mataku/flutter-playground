import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:state_app/model/artwork.dart';
import 'package:state_app/model/presentation/int_representation.dart';
import 'package:state_app/model/profile/user_info.dart';
import 'package:state_app/router/router.dart';
import 'package:state_app/ui/common/app_dialog.dart';
import 'package:state_app/ui/common/artwork_component.dart';
import 'package:state_app/ui/common/value_description.dart';

class AccountContent extends StatelessWidget {
  final UserInfo? _userInfo;
  final VoidCallback onLogout;

  const AccountContent(this._userInfo, this.onLogout, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_userInfo != null) _UserInfoComponent(_userInfo),
          const Divider(),
          _AccountCell(
            title: 'Theme',
            description: 'dark',
            onTapCell: () => {const ThemeSelectionRoute().go(context)},
          ),
          _AccountCell(
            title: 'Logout',
            description: 'Logout from Last.fm',
            onTapCell: () {
              showDialog(
                context: context,
                builder: (context) => AppDialog(
                  title: 'Logout?',
                  description: 'Logout from Last.fm',
                  dismissOnTap: () {
                    context.pop();
                  },
                  confirmOnTap: () {
                    context.pop();
                    onLogout();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _UserInfoComponent extends StatelessWidget {
  final UserInfo _userInfo;

  const _UserInfoComponent(this._userInfo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 12,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            ClipOval(
              child: ArtworkSquareComponent(
                imageUrl: _userInfo.images.imageUrl(),
                size: 96,
              ),
            ),
            const Padding(padding: EdgeInsets.only(left: 16)),
            _UserListeningInfoComponent(
              username: _userInfo.name,
              playcount: _userInfo.playcount,
              albumCount: _userInfo.albumCount,
              artistCount: _userInfo.artistCount,
            ),
          ],
        ),
      ),
    );
  }
}

class _UserListeningInfoComponent extends StatelessWidget {
  final String username;
  final String playcount;
  final String albumCount;
  final String artistCount;

  const _UserListeningInfoComponent({
    required this.username,
    required this.playcount,
    required this.albumCount,
    required this.artistCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          username,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Padding(padding: EdgeInsets.only(top: 12)),
        _UserListeningCountComponent(
          playcount: playcount,
          albumCount: albumCount,
          artistCount: artistCount,
        )
      ],
    );
  }
}

class _UserListeningCountComponent extends StatelessWidget {
  final String playcount;
  final String albumCount;
  final String artistCount;

  const _UserListeningCountComponent({
    required this.playcount,
    required this.albumCount,
    required this.artistCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ValueDescription(
          value: IntRepresentation.toReadableValue(playcount),
          label: 'Scrobbles',
        ),
        const Padding(padding: EdgeInsets.only(left: 32)),
        ValueDescription(
          value: IntRepresentation.toReadableValue(albumCount),
          label: 'Albums',
        ),
        const Padding(padding: EdgeInsets.only(left: 32)),
        ValueDescription(
          value: IntRepresentation.toReadableValue(artistCount),
          label: 'Artists',
        ),
      ],
    );
  }
}

class _AccountCell extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTapCell;

  const _AccountCell({
    required this.title,
    required this.description,
    required this.onTapCell,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTapCell,
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 8)),
              Text(
                description,
                style: TextStyle(
                  fontSize: 14,
                  color: theme.colorScheme.onSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
