import 'package:firebase_auth/firebase_auth.dart';
import 'package:proyectemos/services/dos_tasks_completed.dart';
import 'package:proyectemos/services/tres_tasks_completed.dart';

import '../../../services/uno_tasks_completed.dart';

class ProfileController {
  int unoTasks = 0;
  int dosTasks = 0;
  int tresTasks = 0;
  int allTasks = 17;
  double percentage = 0;

  Future<int> getUnoTaskCompleted() async {
    final resultado = await UnoTasksCompletedService.getUnoTaskCompletedInfo();

    if (resultado[0] == true) {
      unoTasks = 2;
    }
    if (resultado[1] == true) {
      unoTasks += 2;
    }
    if (resultado[2] == true) {
      unoTasks += 1;
    }
    if (resultado[3] == true) {
      unoTasks += 1;
    }

    return unoTasks;
  }

  Future<int> getDosTaskCompleted() async {
    final resultado = await DosTasksCompletedService.getDosTaskCompletedInfo();

    if (resultado[0] == true) {
      dosTasks = 2;
    }
    if (resultado[1] == true) {
      dosTasks += 2;
    }
    if (resultado[2] == true) {
      dosTasks += 1;
    }
    if (resultado[3] == true) {
      dosTasks += 1;
    }

    return dosTasks;
  }

  Future<int> getTresTaskCompleted() async {
    final resultado =
        await TresTasksCompletedService.getTresTaskCompletedInfo();

    if (resultado[0] == true) {
      tresTasks = 1;
    }
    if (resultado[1] == true) {
      tresTasks += 1;
    }
    if (resultado[2] == true) {
      tresTasks += 1;
    }
    if (resultado[3] == true) {
      tresTasks += 2;
    }

    return tresTasks;
  }

  Future<void> getPercentage() async {
    final unoTasks = await getUnoTaskCompleted();
    final dosTasks = await getDosTaskCompleted();
    final tresTasks = await getTresTaskCompleted();

    percentage = (unoTasks + dosTasks + tresTasks) / allTasks * 100;
  }

  int getAllTasks() {
    return unoTasks + dosTasks + tresTasks;
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
  }
}
