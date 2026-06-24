import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/character_model.dart';

class CharacterDetailScreen extends StatelessWidget {
  final CharacterModel character;

  const CharacterDetailScreen({
    super.key,
    required this.character,
  });

  String _translateStatus(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return 'Vivo';
      case 'dead':
        return 'Muerto';
      default:
        return 'Desconocido';
    }
  }

  String _translateGender(String gender) {
    switch (gender.toLowerCase()) {
      case 'male':
        return 'Masculino';
      case 'female':
        return 'Femenino';
      case 'genderless':
        return 'Sin género';
      default:
        return 'Desconocido';
    }
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final typeText = character.type.isEmpty ? 'No especificado' : character.type;

    return Scaffold(
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: responsive.horizontalPadding),
        child: ResponsiveContent(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.network(
                  character.image,
                  height: responsive.imageHeight(fraction: 0.32),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 22),
              Text(
                character.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: responsive.isMobile ? 26 : 30,
                  fontWeight: FontWeight.bold,
                  color: AppColors.portalGreen,
                ),
              ),
              const SizedBox(height: 20),
              _DetailCard(
                title: 'Estado',
                value: _translateStatus(character.status),
                icon: Icons.favorite,
              ),
              _DetailCard(
                title: 'Especie',
                value: character.species,
                icon: Icons.pets,
              ),
              _DetailCard(
                title: 'Tipo',
                value: typeText,
                icon: Icons.biotech,
              ),
              _DetailCard(
                title: 'Género',
                value: _translateGender(character.gender),
                icon: Icons.person,
              ),
              _DetailCard(
                title: 'Origen',
                value: character.origin,
                icon: Icons.public,
              ),
              _DetailCard(
                title: 'Ubicación actual',
                value: character.location,
                icon: Icons.location_on,
              ),
              _DetailCard(
                title: 'Cantidad de episodios',
                value: '${character.episodeCount}',
                icon: Icons.movie,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _DetailCard({
    required this.title,
    required this.value,
    required this.icon,
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
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }
}