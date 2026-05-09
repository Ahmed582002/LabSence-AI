import 'dart:typed_data';
import 'package:flutter/material.dart';

class ViewPhoto extends StatelessWidget {
  final double radius;
  final Uint8List image;
  const ViewPhoto({super.key, required this.radius, required this.image});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(radius: radius, backgroundImage: MemoryImage(image));
  }
}
