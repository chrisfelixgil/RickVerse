import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../../core/constants/api_constants.dart';
import '../models/character_model.dart';

class RickAndMortyService {
  Future<List<CharacterModel>> getMainCharacters() async {
    final ids = [1, 2, 3, 4, 331, 244];

    final url = Uri.parse(
      '${ApiConstants.baseUrl}/character/${ids.join(',')}',
    );

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('No se pudieron cargar los personajes.');
    }

    final List<dynamic> data = jsonDecode(response.body);

    return data
        .map((characterJson) => CharacterModel.fromJson(characterJson))
        .toList();
  }

  Future<CharacterModel> getRandomCharacter() async {
    final countUrl = Uri.parse('${ApiConstants.baseUrl}/character');
    final countResponse = await http.get(countUrl);

    if (countResponse.statusCode != 200) {
      throw Exception('No se pudo obtener la cantidad de personajes.');
    }

    final countData = jsonDecode(countResponse.body);
    final int totalCharacters = countData['info']['count'];

    final randomId = Random().nextInt(totalCharacters) + 1;

    final characterUrl = Uri.parse(
      '${ApiConstants.baseUrl}/character/$randomId',
    );

    final characterResponse = await http.get(characterUrl);

    if (characterResponse.statusCode != 200) {
      throw Exception('No se pudo cargar el personaje aleatorio.');
    }

    final characterData = jsonDecode(characterResponse.body);

    return CharacterModel.fromJson(characterData);
  }
}