import 'package:shared_preferences/shared_preferences.dart';

class TresTasksCompletedService {
  static const movimientosSocialesCompleted = false;
  static const tuAlrededorCompleted = false;
  static const lasRedesSocialesYElActivismoCompleted = false;
  static const creacionDeSuMovimentoCompleted = false;

  static Future<List<bool>> getTresTaskCompletedInfo() async {
    final laSociedadCompleted = await getTresLaSociedadCompletedInfo();
    // final movimientosSocialesCompleted =
    //     await getTresMovimientosSocialesCompletedInfo();
    final tuAlrededorCompleted = await getTresTuAlrededorCompletedInfo();
    // final lasRedesSocialesYElActivismoCompleted =
    //     await getTresLasRedesSocialesYElActivismoCompletedInfo();
    // final creacionDeSuMovimentoCompleted = await getTresCreacionDeSuMovimentoCompletedInfo();

    return [
      laSociedadCompleted,
      movimientosSocialesCompleted,
      tuAlrededorCompleted,
      lasRedesSocialesYElActivismoCompleted,
      creacionDeSuMovimentoCompleted,
    ];
  }

  static Future<bool> getTresLaSociedadCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final laSociedad =
        sharedPreferences.getBool('laSociedadTareaCompleted') ?? false;
    return laSociedad;
  }

  static getCreaTuMovimientoTaskCompletedInfo() {}

  static getTresMovimientosSocialesCompletedInfo() {}

  static getTresTuAlrededorCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final laSociedad =
        sharedPreferences.getBool('tuAlrededorCompleted') ?? false;
    return laSociedad;
  }

  static getTresLasRedesSocialesYElActivismoCompletedInfo() {}

  static getTresCreacionDeSuMovimentoCompletedInfo() {}
}
