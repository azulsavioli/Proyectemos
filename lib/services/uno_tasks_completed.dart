import 'package:shared_preferences/shared_preferences.dart';

class UnoTasksCompletedService {
  static const latinoamericaCompleted = true;
  static const artistasCompleted = true;
  static const eventoCulturalCompleted = true;
  static const divulgationCompleted = true;

  static Future<List<bool>> getUnoTaskCompletedInfo() async {
    final latinoamericaList = await getUnoLatinoamericaTaskCompletedInfo();
    final artistsList = await getUnoArtistasTaskCompletedInfo();
    final eventoCultural = await getUnoEventoTaskCompletedInfo();
    final divulgation = await getUnoDivulgationCompletedInfo();

    var latinoamerica = false;
    var artistas = false;

    if (latinoamericaList[0] && latinoamericaList[1]) {
      latinoamerica = true;
    }

    if (artistsList[0] && artistsList[1]) {
      artistas = true;
    }

    return [latinoamerica, artistas, eventoCultural, divulgation];
  }

  static Future<List<bool>> getUnoLatinoamericaTaskCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final tareaUnoLatinoamerica =
        sharedPreferences.getBool('latinoamericaTareaUnoCompleted') ?? false;
    final tareaDosLatinoamerica =
        sharedPreferences.getBool('latinoamericaTareaDosCompleted') ?? false;

    if (tareaUnoLatinoamerica && tareaDosLatinoamerica == true) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(
        'latinoamericaCompleted',
        latinoamericaCompleted,
      );
    }

    return [
      tareaUnoLatinoamerica,
      tareaDosLatinoamerica,
    ];
  }

  static Future<List<bool>> getUnoArtistasTaskCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final tareaUnoArtistas =
        sharedPreferences.getBool('artistasTareaUnoCompleted') ?? false;
    final tareaDosArtistas =
        sharedPreferences.getBool('artistasTareaDosCompleted') ?? false;

    if (tareaUnoArtistas && tareaDosArtistas == true) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(
        'artistasCompleted',
        artistasCompleted,
      );
    }

    return [tareaUnoArtistas, tareaDosArtistas];
  }

  static Future<bool> getUnoEventoTaskCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final tareaUnoEvento =
        sharedPreferences.getBool('eventoTareaUnoCompleted') ?? false;

    return tareaUnoEvento;
  }

  static Future<bool> getUnoDivulgationCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final divulgation =
        sharedPreferences.getBool('divulgationCompleted') ?? false;

    return divulgation;
  }

  static Future<List<bool>> getUnoDivulgationFeedType() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final feedTurma = sharedPreferences.getBool('feedTurma') ?? false;
    final feedTodos = sharedPreferences.getBool('feedTodos') ?? false;

    return [feedTurma, feedTodos];
  }
}
