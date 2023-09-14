import '../../../services/uno_tasks_completed.dart';

class ProfileController {
  int unoTasks = 0;
  int dosTasks = 0;
  int tresTasks = 0;
  int allTasks = 29;
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

  Future<void> getPercentage() async {
    final unoTasks = await getUnoTaskCompleted();

    percentage = unoTasks / allTasks * 100;
  }

  int getAllTasks() {
    return unoTasks + dosTasks + tresTasks;
  }
}
