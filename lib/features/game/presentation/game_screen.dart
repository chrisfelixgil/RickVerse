import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../data/models/character_model.dart';
import '../../../data/services/rick_and_morty_service.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, this.onBack});

  final VoidCallback? onBack;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final RickAndMortyService _service = RickAndMortyService();

  CharacterModel? _character;
  bool _isLoading = true;
  String? _errorMessage;

  final Set<String> _selectedLetters = {};
  final Set<String> _correctLetters = {};
  final Set<String> _wrongLetters = {};

  int _attemptsLeft = 6;
  int _wins = 0;
  int _losses = 0;
  int _streak = 0;

  final List<String> _letters = const [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'Ñ',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  @override
  void initState() {
    super.initState();
    _loadNewCharacter();
  }

  Future<void> _loadNewCharacter() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _selectedLetters.clear();
      _correctLetters.clear();
      _wrongLetters.clear();
      _attemptsLeft = 6;
    });

    try {
      final character = await _service.getRandomCharacter();

      setState(() {
        _character = character;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = 'No se pudo cargar el personaje. Intenta de nuevo.';
        _isLoading = false;
      });
    }
  }

  String get _characterName {
    return _character?.name.toUpperCase() ?? '';
  }

  bool get _hasWon {
    if (_characterName.isEmpty) return false;

    for (final character in _characterName.characters) {
      if (_isLetter(character) && !_correctLetters.contains(character)) {
        return false;
      }
    }

    return true;
  }

  bool get _hasLost {
    return _attemptsLeft <= 0;
  }

  bool get _isGameOver {
    return _hasWon || _hasLost;
  }

  void _selectLetter(String letter) {
    if (_isGameOver || _selectedLetters.contains(letter)) return;

    setState(() {
      _selectedLetters.add(letter);

      if (_characterName.contains(letter)) {
        _correctLetters.add(letter);
      } else {
        _wrongLetters.add(letter);
        _attemptsLeft--;
      }

      if (_hasWon) {
        _wins++;
        _streak++;
      }

      if (_hasLost) {
        _losses++;
        _streak = 0;
      }
    });
  }

  bool _isLetter(String value) {
    return RegExp(r'^[A-ZÑ]$').hasMatch(value);
  }

  String _hiddenName() {
    if (_characterName.isEmpty) return '';

    final buffer = StringBuffer();

    for (final character in _characterName.characters) {
      if (character == ' ') {
        buffer.write('   ');
      } else if (!_isLetter(character)) {
        buffer.write('$character ');
      } else if (_correctLetters.contains(character) || _hasLost) {
        buffer.write('$character ');
      } else {
        buffer.write('_ ');
      }
    }

    return buffer.toString().trim();
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

  String _translateSpecies(String species) {
    switch (species.toLowerCase()) {
      case 'human':
        return 'Humano';
      case 'alien':
        return 'Alienígena';
      case 'humanoid':
        return 'Humanoide';
      case 'robot':
        return 'Robot';
      case 'animal':
        return 'Animal';
      default:
        return species;
    }
  }

  Color _letterColor(String letter) {
    if (_correctLetters.contains(letter)) {
      return AppColors.portalGreen;
    }

    if (_wrongLetters.contains(letter)) {
      return Colors.redAccent;
    }

    return Colors.blueGrey;
  }

  Color _letterBackgroundColor(String letter) {
    if (_correctLetters.contains(letter)) {
      return AppColors.portalGreen.withOpacity(0.18);
    }

    if (_wrongLetters.contains(letter)) {
      return Colors.redAccent.withOpacity(0.18);
    }

    return AppColors.card;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: widget.onBack ?? () => Navigator.maybePop(context),
        ),
        title: const Text('Juega conmigo'),
        actions: [
          IconButton(
            onPressed: _loadNewCharacter,
            icon: const Icon(
              Icons.refresh,
              color: AppColors.portalGreen,
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.portalGreen,
        ),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                color: Colors.redAccent,
                size: 52,
              ),
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                onPressed: _loadNewCharacter,
                child: const Text('Intentar de nuevo'),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: EdgeInsets.all(Responsive.of(context).horizontalPadding),
      child: ResponsiveContent(
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            _GameHeaderCard(
              character: _character!,
              attemptsLeft: _attemptsLeft,
              hiddenName: _hiddenName(),
              hint:
                  '${_translateSpecies(_character!.species)} / ${_translateGender(_character!.gender)}',
              hasWon: _hasWon,
              hasLost: _hasLost,
              onNewCharacter: _loadNewCharacter,
            ),
            const SizedBox(height: 16),
            _buildKeyboard(),
            const SizedBox(height: 16),
            _ScoreBoard(
              wins: _wins,
              losses: _losses,
              streak: _streak,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildKeyboard() {
    final responsive = Responsive.of(context);
    final keySize = responsive.letterKeySize(_letters.length);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: _letters.map((letter) {
                final isSelected = _selectedLetters.contains(letter);

                return InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: isSelected ? null : () => _selectLetter(letter),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    width: keySize,
                    height: keySize,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _letterBackgroundColor(letter),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _letterColor(letter),
                        width: 1.4,
                      ),
                      boxShadow: [
                        if (_correctLetters.contains(letter))
                          BoxShadow(
                            color: AppColors.portalGreen.withOpacity(0.35),
                            blurRadius: 10,
                          ),
                        if (_wrongLetters.contains(letter))
                          BoxShadow(
                            color: Colors.redAccent.withOpacity(0.25),
                            blurRadius: 10,
                          ),
                      ],
                    ),
                    child: Text(
                      letter,
                      style: TextStyle(
                        fontSize: keySize * 0.42,
                        fontWeight: FontWeight.bold,
                        color: isSelected
                            ? AppColors.textPrimary
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 18),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 12,
              runSpacing: 8,
              children: const [
                _LegendDot(
                  color: AppColors.portalGreen,
                  text: 'Correcta',
                ),
                _LegendDot(
                  color: Colors.redAccent,
                  text: 'Incorrecta',
                ),
                _LegendDot(
                  color: Colors.blueGrey,
                  text: 'No usada',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _GameHeaderCard extends StatelessWidget {
  final CharacterModel character;
  final int attemptsLeft;
  final String hiddenName;
  final String hint;
  final bool hasWon;
  final bool hasLost;
  final VoidCallback onNewCharacter;

  const _GameHeaderCard({
    required this.character,
    required this.attemptsLeft,
    required this.hiddenName,
    required this.hint,
    required this.hasWon,
    required this.hasLost,
    required this.onNewCharacter,
  });

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final message = hasWon
        ? '¡Ganaste! Adivinaste el personaje.'
        : hasLost
            ? 'Perdiste. El personaje era ${character.name}.'
            : 'Adivina el nombre del personaje antes de quedarte sin intentos.';

    return Card(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(responsive.isMobile ? 16 : 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.portalBlue.withOpacity(0.45),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.card,
              AppColors.card.withOpacity(0.65),
              AppColors.background,
            ],
          ),
        ),
        child: Column(
          children: [
            const Text(
              'Ahorcado del multiverso',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 27,
                fontWeight: FontWeight.bold,
                color: AppColors.portalGreen,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: responsive.isCompact ? 14 : 15,
                height: 1.4,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 20),
            LayoutBuilder(
              builder: (context, constraints) {
                final stackVertically = constraints.maxWidth < 560;

                final imageSection = _CharacterImageCard(
                  character: character,
                  imageHeight: responsive.isMobile ? 150 : 180,
                );
                final infoSection = Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Intentos restantes',
                      style: TextStyle(
                        color: AppColors.portalBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _AttemptsIndicator(attemptsLeft: attemptsLeft),
                    const SizedBox(height: 18),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 18,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: AppColors.portalBlue.withOpacity(0.35),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          hiddenName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: responsive.isMobile ? 20 : 23,
                            letterSpacing: 3,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: Colors.deepPurpleAccent.withOpacity(0.45),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.search,
                            color: Colors.deepPurpleAccent,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Pista: $hint',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );

                if (stackVertically) {
                  return Column(
                    children: [
                      imageSection,
                      const SizedBox(height: 16),
                      infoSection,
                    ],
                  );
                }

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 4, child: imageSection),
                    const SizedBox(width: 14),
                    Expanded(flex: 5, child: infoSection),
                  ],
                );
              },
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onNewCharacter,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Nuevo personaje'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CharacterImageCard extends StatelessWidget {
  final CharacterModel character;
  final double imageHeight;

  const _CharacterImageCard({
    required this.character,
    this.imageHeight = 155,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Personaje misterioso',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: AppColors.portalGreen,
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.portalGreen.withOpacity(0.25),
                blurRadius: 16,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              character.image,
              height: imageHeight,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class _AttemptsIndicator extends StatelessWidget {
  final int attemptsLeft;

  const _AttemptsIndicator({
    required this.attemptsLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(6, (index) {
        final isActive = index < attemptsLeft;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 6),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive
                    ? AppColors.portalGreen.withOpacity(0.22)
                    : Colors.blueGrey.withOpacity(0.18),
                border: Border.all(
                  color: isActive ? AppColors.portalGreen : Colors.blueGrey,
                  width: 1.5,
                ),
                boxShadow: [
                  if (isActive)
                    BoxShadow(
                      color: AppColors.portalGreen.withOpacity(0.35),
                      blurRadius: 10,
                    ),
                ],
              ),
              child: Icon(
                Icons.blur_circular,
                size: 17,
                color: isActive ? AppColors.portalGreen : Colors.blueGrey,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String text;

  const _LegendDot({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: color,
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class _ScoreBoard extends StatelessWidget {
  final int wins;
  final int losses;
  final int streak;

  const _ScoreBoard({
    required this.wins,
    required this.losses,
    required this.streak,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
        child: Row(
          children: [
            Expanded(
              child: _ScoreItem(
                icon: Icons.gps_fixed,
                title: 'Aciertos',
                value: '$wins',
                color: AppColors.portalGreen,
              ),
            ),
            Container(width: 1, height: 48, color: Colors.blueGrey),
            Expanded(
              child: _ScoreItem(
                icon: Icons.close,
                title: 'Fallos',
                value: '$losses',
                color: Colors.redAccent,
              ),
            ),
            Container(width: 1, height: 48, color: Colors.blueGrey),
            Expanded(
              child: _ScoreItem(
                icon: Icons.flash_on,
                title: 'Racha',
                value: '$streak',
                color: Colors.deepPurpleAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScoreItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color color;

  const _ScoreItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}