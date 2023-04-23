import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkCircleAvatar extends StatelessWidget {
  final double radius;
  final String? avatarUrl;
  final Widget placeholder;

  const NetworkCircleAvatar({
    Key? key,
    required this.radius,
    this.avatarUrl,
    required this.placeholder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: avatarUrl == null
          ? placeholder
          : ClipRRect(
              borderRadius: BorderRadius.circular(radius),
              child: CachedNetworkImage(
                width: radius * 2,
                height: radius * 2,
                fit: BoxFit.cover,
                imageUrl: avatarUrl!,
                placeholder: (_, __) => Center(
                  child: placeholder,
                ),
              ),
            ),
    );
  }
}
