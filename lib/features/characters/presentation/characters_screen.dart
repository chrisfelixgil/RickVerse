import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/character_model.dart';
import '../../../data/services/rick_and_morty_service.dart';
import 'character_detail_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late final Future<List<CharacterModel>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _charactersFuture = RickAndMortyService().getMainCharacters();
  }

  void _openCharacterDetail(CharacterModel character) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CharacterDetailScreen(character: character),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'alive':
        return AppColors.portalGreen;
      case 'dead':
        return Colors.redAccent;
      default:
        return Colors.orangeAccent;
    }
  }

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

  Widget _buildCharacterCard(CharacterModel character) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => _openCharacterDetail(character),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  character.image,
                  width: 64,
                  height: 64,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 10,
                          color: _getStatusColor(character.status),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${_translateStatus(character.status)} - ${character.species}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 18),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final columns = responsive.listGridColumns;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Personajes'),
      ),
      body: FutureBuilder<List<CharacterModel>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.portalGreen,
              ),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.all(responsive.horizontalPadding),
                child: Text(
                  'No se pudieron cargar los personajes.\n\n${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final characters = snapshot.data ?? [];

          if (columns == 1) {
            return ListView.separated(
              padding: EdgeInsets.all(responsive.horizontalPadding),
              itemCount: characters.length,
              separatorBuilder: (_, __) => const SizedBox(height: 14),
              itemBuilder: (context, index) {
                return _buildCharacterCard(characters[index]);
              },
            );
          }

          return ResponsiveContent(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(vertical: responsive.horizontalPadding),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: columns >= 3 ? 2.4 : 2.1,
              ),
              itemCount: characters.length,
              itemBuilder: (context, index) {
                return _buildCharacterCard(characters[index]);
              },
            ),
          );
        },
      ),
    );
  }
}
