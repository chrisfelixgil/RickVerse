import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de'),
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
                  'assets/images/rick-y-morty_portada2.jpg',
                  height: responsive.imageHeight(fraction: 0.28),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                'Rick and Morty',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.isMobile ? 28 : 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.portalGreen,
                ),
              ),

            const SizedBox(height: 12),

            const Text(
              'Rick and Morty es una serie animada de ciencia ficción, comedia '
              'y aventuras interdimensionales. La historia sigue a Rick Sanchez, '
              'un científico brillante, excéntrico e irresponsable, y a su nieto '
              'Morty Smith, quien termina acompañándolo en viajes peligrosos por '
              'distintas realidades del multiverso.',
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.justify,
            ),

            const SizedBox(height: 24),

            const _InfoCard(
              icon: Icons.movie,
              title: 'Tipo de obra',
              value: 'Serie animada de ciencia ficción y comedia',
            ),

            const _InfoCard(
              icon: Icons.person,
              title: 'Creadores',
              value: 'Justin Roiland y Dan Harmon',
            ),

            const _InfoCard(
              icon: Icons.tv,
              title: 'Temporadas',
              value: '9 temporadas',
            ),

            const _InfoCard(
              icon: Icons.calendar_month,
              title: 'Año de estreno',
              value: '2013',
            ),

            const _InfoCard(
              icon: Icons.explore,
              title: 'Tema principal',
              value: 'Viajes interdimensionales, ciencia, familia y caos multiversal',
            ),

            const SizedBox(height: 14),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Text(
                  'RickVerse es una aplicación móvil creada como proyecto académico '
                  'para explorar personajes, momentos memorables y datos importantes '
                  'de Rick and Morty usando Flutter y la Rick and Morty API.',
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          color: AppColors.portalGreen,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}