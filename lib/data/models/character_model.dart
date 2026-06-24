class CharacterModel {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String location;
  final String image;
  final int episodeCount;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episodeCount,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'],
      name: json['name'] ?? 'Sin nombre',
      status: json['status'] ?? 'Desconocido',
      species: json['species'] ?? 'Desconocida',
      type: json['type'] ?? '',
      gender: json['gender'] ?? 'Desconocido',
      origin: json['origin']?['name'] ?? 'Desconocido',
      location: json['location']?['name'] ?? 'Desconocida',
      image: json['image'] ?? '',
      episodeCount: (json['episode'] as List?)?.length ?? 0,
    );
  }
}