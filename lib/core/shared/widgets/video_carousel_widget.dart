import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoCarouselWidget extends StatefulWidget {
  const VideoCarouselWidget({
    super.key,
    required this.videoPath,
    this.width,
    this.height,
    this.padding,
    required this.borderRadius,
    required this.applyImageRadius,
  });
  final String videoPath;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final bool applyImageRadius;
  @override
  State<VideoCarouselWidget> createState() => _VideoCarouselWidgetState();
}

class _VideoCarouselWidgetState extends State<VideoCarouselWidget> {
  late FlickManager flickManager;
  @override
  void initState() {
    super.initState();
    flickManager = FlickManager(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(widget.videoPath)));
  }

  @override
  void dispose() {
    flickManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: widget.applyImageRadius
          ? BorderRadius.circular(widget.borderRadius)
          : BorderRadius.zero,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: widget.applyImageRadius
              ? BorderRadius.circular(widget.borderRadius)
              : BorderRadius.zero,
        ),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        child: FlickVideoPlayer(flickManager: flickManager),
      ),
    );
  }
}
