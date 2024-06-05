import 'package:shared_preferences/shared_preferences.dart';

class DosTasksCompletedService {
  static const comoCrearPodcastCompleted = true;
  static const laEncuestaCompleted = true;
  static const grabacionPodcastCompleted = true;

  static Future<List<bool>> getDosTaskCompletedInfo() async {
    final conocesPodcast = await getDosConocesPodcastTaskCompletedInfo();
    final comoCrearPodcastList =
        await getDosComoCrearPodcastTaskCompletedInfo();
    final laEncuestaList = await getDosLaEncuestaTaskCompletedInfo();
    final creacionEncuesta = await getDosCreacionEncuestaCompletedInfo();
    final grabacionPodcastList = await getDosGrabacionPodcastCompletedInfo();

    var comoCrearPodcast = false;
    var laEncuesta = false;
    var grabacionPodcast = false;

    if (comoCrearPodcastList[0] && comoCrearPodcastList[1]) {
      comoCrearPodcast = true;
    }

    if (laEncuestaList[0] && laEncuestaList[1]) {
      laEncuesta = true;
    }

    if (grabacionPodcastList[0] && grabacionPodcastList[1]) {
      grabacionPodcast = true;
    }

    return [
      conocesPodcast,
      comoCrearPodcast,
      laEncuesta,
      creacionEncuesta,
      grabacionPodcast,
    ];
  }

  static Future<bool> getDosConocesPodcastTaskCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final conocesPodcast =
        sharedPreferences.getBool('conocesPodcastCompleted') ?? false;

    return conocesPodcast;
  }

  static Future<List<bool>> getDosComoCrearPodcastTaskCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final comoCrearPodcastTareaUno =
        sharedPreferences.getBool('comoCrearPodcastTareaUnoCompleted') ?? false;
    final comoCrearPodcastTareaDos =
        sharedPreferences.getBool('comoCrearPodcastTareaDosCompleted') ?? false;

    if (comoCrearPodcastTareaUno && comoCrearPodcastTareaDos == true) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(
        'comoCrearPodcastCompleted',
        comoCrearPodcastCompleted,
      );
    }

    return [
      comoCrearPodcastTareaUno,
      comoCrearPodcastTareaDos,
    ];
  }

  static Future<List<bool>> getDosLaEncuestaTaskCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final laEncuestaTareaUno =
        sharedPreferences.getBool('laEncuestaTareaUnoCompleted') ?? false;
    final laEncuestaTareaDos =
        sharedPreferences.getBool('laEncuestaTareaDosCompleted') ?? false;

    if (laEncuestaTareaUno && laEncuestaTareaDos == true) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(
        'laEncuestaCompleted',
        laEncuestaCompleted,
      );
    }

    return [
      laEncuestaTareaUno,
      laEncuestaTareaDos,
    ];
  }

  static Future<bool> getDosCreacionEncuestaCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final creacionEncuesta =
        sharedPreferences.getBool('creacionEncuestaCompleted') ?? false;

    return creacionEncuesta;
  }

  static Future<List<bool>> getDosGrabacionPodcastCompletedInfo() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final grabacionPodcastTareaUno =
        sharedPreferences.getBool('grabacionPodcastTareaUnoCompleted') ?? false;
    final grabacionPodcastTareaDos =
        sharedPreferences.getBool('grabacionPodcastTareaDosCompleted') ?? false;

    if (grabacionPodcastTareaUno && grabacionPodcastTareaDos == true) {
      final preferences = await SharedPreferences.getInstance();
      await preferences.setBool(
        'grabacionPodcastCompleted',
        grabacionPodcastCompleted,
      );
    }

    return [
      grabacionPodcastTareaUno,
      grabacionPodcastTareaDos,
    ];
  }

  static Future<void> restoreAllTasks() async {
    const conocesPodcastCompleted = false;
    const comoCrearPodcastTareaUnoCompleted = false;
    const comoCrearPodcastTareaDosCompleted = false;
    const laEncuestaTareaUnoCompleted = false;
    const laEncuestaTareaDosCompleted = false;
    const creacionEncuestaCompleted = false;
    const grabacionPodcastTareaUnoCompleted = false;
    const grabacionPodcastTareaDosCompleted = false;

    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(
      'conocesPodcastCompleted',
      conocesPodcastCompleted,
    );
    await preferences.setBool(
      'comoCrearPodcastTareaUnoCompleted',
      comoCrearPodcastTareaUnoCompleted,
    );
    await preferences.setBool(
      'comoCrearPodcastTareaDosCompleted',
      comoCrearPodcastTareaDosCompleted,
    );
    await preferences.setBool(
      'laEncuestaTareaUnoCompleted',
      laEncuestaTareaUnoCompleted,
    );
    await preferences.setBool(
      'laEncuestaTareaDosCompleted',
      laEncuestaTareaDosCompleted,
    );
    await preferences.setBool(
      'creacionEncuestaCompleted',
      creacionEncuestaCompleted,
    );
    await preferences.setBool(
      'grabacionPodcastTareaUnoCompleted',
      grabacionPodcastTareaUnoCompleted,
    );
    await preferences.setBool(
      'grabacionPodcastTareaDosCompleted',
      grabacionPodcastTareaDosCompleted,
    );
  }

  static Future<bool> isLoadind(task) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool('isLoadingTask-$task') ?? false;
  }
}
