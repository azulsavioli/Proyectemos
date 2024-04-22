import 'package:shared_preferences/shared_preferences.dart';

class TresTasksCompletedService {
  static const movimientosSocialesCompleted = false;
  static const tuAlrededorCompleted = false;
  static const lasRedesSocialesYElActivismoCompleted = false;

  static Future<List<bool>> getTresTaskCompletedInfo() async {
    final laSociedadCompleted = await getTresLaSociedadCompletedInfo();
    final movimientosSocialesCompleted =
        await getTresMovimientosSocialesCompletedInfo();
    final tuAlrededorCompleted = await getTresTuAlrededorCompletedInfo();
    // final lasRedesSocialesYElActivismoCompleted =
    //     await getTresLasRedesSocialesYElActivismoCompletedInfo();
    final creacionDeSuMovimentoCompleted =
        await getTresCreacionDeSuMovimentoCompletedInfo();

    final creacionTasksCompleted = (creacionDeSuMovimentoCompleted[0] &&
        creacionDeSuMovimentoCompleted[1]);

    return [
      laSociedadCompleted,
      movimientosSocialesCompleted,
      tuAlrededorCompleted,
      lasRedesSocialesYElActivismoCompleted,
      creacionTasksCompleted,
    ];
  }

  static Future<bool> getTresLaSociedadCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final laSociedad =
        sharedPreferences.getBool('laSociedadTareaCompleted') ?? false;
    return laSociedad;
  }

  static getCreaTuMovimientoTaskCompletedInfo() {}

  static getTresMovimientosSocialesCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final movimientoSociale =
        sharedPreferences.getBool('movimientosSocialesCompleted') ?? false;
    return movimientoSociale;
  }

  static getTresTuAlrededorCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final laSociedad =
        sharedPreferences.getBool('tuAlrededorCompleted') ?? false;
    return laSociedad;
  }

  // O: pode ser que nao sera feito

  static getTresLasRedesSocialesYElActivismoCompletedInfo() {}

  static getTresCreacionDeSuMovimentoCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final creaTuMovimientoTareaUno =
        sharedPreferences.getBool('creaTuMovimientoTareaUnoCompleted') ?? false;
    final creaTuMovimientoTareaDos =
        sharedPreferences.getBool('creaTuMovimientoTareaDosCompleted') ?? false;
    return [creaTuMovimientoTareaUno, creaTuMovimientoTareaDos];
  }
}
