import 'package:flutter/material.dart';
import 'package:raho_member_apps/core/utils/helper.dart';

class ProfileAvatarWidget extends StatelessWidget {
  final String? base64Image;
  final double size;

  const ProfileAvatarWidget({
    super.key,
    required this.base64Image,
    this.size = 64,
  });

  @override
  Widget build(BuildContext context) {
    final bytes = decodeBase64Image(base64Image);
    if (bytes == null) {
      return CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        radius: size / 2,
        child: const Icon(Icons.person),
      );
    }
    return CircleAvatar(
      radius: size / 2,
      backgroundColor: Colors.transparent,
      child: ClipOval(
        child: Image.memory(
          bytes,
          width: size,
          height: size,
          fit: BoxFit.cover,
          gaplessPlayback: true,
          filterQuality: FilterQuality.medium,
        ),
      ),
    );
  }
}
