class MomentModel {
  final String title;
  final String shortDescription;
  final String fullDescription;
  final String imagePath;
  final String youtubeVideoId;

  const MomentModel({
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.imagePath,
    required this.youtubeVideoId,
  });
}

const List<MomentModel> favoriteMoments = [
  MomentModel(
    title: 'Pickle Rick vs Rats',
    shortDescription: 'Rick se transforma en pepinillo y lucha por sobrevivir.',
    fullDescription:
        'Rick Sanchez se transforma en un pepinillo, conocido como Pickle Rick, '
        'para evitar ir a terapia familiar. Atrapado en un desagüe pluvial, '
        'debe enfrentarse a una horda de ratas hambrientas usando su inteligencia, '
        'improvisación y habilidades científicas.',
    imagePath: 'assets/images/Arma_de_Pepinillo_Rick.webp',
    youtubeVideoId: 'gDCZz_8z2gk',
  ),
  MomentModel(
    title: 'Mr. Meeseeks pelea',
    shortDescription: 'Los Meeseeks pierden la paciencia por culpa de Jerry.',
    fullDescription:
        'Jerry Smith intenta mejorar su tiro de golf usando una caja de Mr. Meeseeks. '
        'El problema se sale de control cuando llama a demasiados Meeseeks y ninguno '
        'logra cumplir el objetivo. Frustrados, comienzan a culparse entre ellos y '
        'la situación termina en caos.',
    imagePath: 'assets/images/mr-meeseeks-rick-y-morty.jpg',
    youtubeVideoId: 'Vvj8SwmKO7U',
  ),
  MomentModel(
    title: 'La infección de parásitos',
    shortDescription: 'La familia Smith enfrenta recuerdos falsos y parásitos.',
    fullDescription:
        'La familia Smith se enfrenta a una invasión de parásitos alienígenas '
        'telepáticos que se infiltran creando recuerdos falsos. Cada nuevo personaje '
        'parece ser parte de la familia, pero en realidad puede ser una amenaza.',
    imagePath: 'assets/images/infeccion_parasitos.jpg',
    youtubeVideoId: 'g1vE9IcSz8k',
  ),
];