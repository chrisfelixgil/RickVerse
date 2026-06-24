import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/moment_model.dart';
import 'moment_detail_screen.dart';

class MomentsScreen extends StatelessWidget {
  const MomentsScreen({super.key});

  void _openMomentDetail(BuildContext context, MomentModel moment) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MomentDetailScreen(moment: moment),
      ),
    );
  }

  Widget _buildMomentCard(BuildContext context, MomentModel moment) {
    final responsive = Responsive.of(context);
    final imageHeight = responsive.imageHeight(fraction: 0.24);

    return Card(
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openMomentDetail(context, moment),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              moment.imagePath,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    moment.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: responsive.isMobile ? 20 : 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.portalGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    moment.shortDescription,
                    maxLines: responsive.isMobile ? 3 : 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Ver detalle',
                        style: TextStyle(
                          color: AppColors.portalBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 6),
                      Icon(
                        Icons.play_circle_fill,
                        color: AppColors.portalBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final columns = responsive.listGridColumns;

    if (columns == 1) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Momentos favoritos'),
        ),
        body: ListView.separated(
          padding: EdgeInsets.all(responsive.horizontalPadding),
          itemCount: favoriteMoments.length,
          separatorBuilder: (_, __) => const SizedBox(height: 18),
          itemBuilder: (context, index) {
            return _buildMomentCard(context, favoriteMoments[index]);
          },
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Momentos favoritos'),
      ),
      body: ResponsiveContent(
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: responsive.horizontalPadding),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            childAspectRatio: columns >= 3 ? 0.72 : 0.78,
          ),
          itemCount: favoriteMoments.length,
          itemBuilder: (context, index) {
            return _buildMomentCard(context, favoriteMoments[index]);
          },
        ),
      ),
    );
  }
}
