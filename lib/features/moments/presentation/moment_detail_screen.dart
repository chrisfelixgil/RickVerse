import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/youtube_video_player.dart';
import '../../../data/models/moment_model.dart';

class MomentDetailScreen extends StatelessWidget {
  final MomentModel moment;

  const MomentDetailScreen({
    super.key,
    required this.moment,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(moment.title),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: responsive.horizontalPadding),
        child: ResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: Image.asset(
                  moment.imagePath,
                  height: responsive.imageHeight(fraction: 0.3),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                moment.title,
                style: TextStyle(
                  fontSize: responsive.isMobile ? 24 : 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.portalGreen,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                moment.fullDescription,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Video relacionado',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              YoutubeVideoPlayer(videoId: moment.youtubeVideoId),
            ],
          ),
        ),
      ),
    );
  }
}