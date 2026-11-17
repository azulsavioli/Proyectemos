import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings_como_crear_un_podcast.dart';
import 'package:proyectemos/repository/proyectemos_repository.dart';
import 'package:proyectemos/services/toast_services.dart';
import '../../../../../commons/styles.dart';
import '../../../../../utils/get_user.dart';
import 'controller_dos_como_crear_podcast.dart';

class IntroTareaDosComoCrearPodcastPage extends StatefulWidget {
  final ControllerCrearUnPodcast controller;
  const IntroTareaDosComoCrearPodcastPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<IntroTareaDosComoCrearPodcastPage> createState() =>
      _IntroTareaDosComoCrearPodcastPageState();
}

class _IntroTareaDosComoCrearPodcastPageState
    extends State<IntroTareaDosComoCrearPodcastPage>
    with AutomaticKeepAliveClientMixin {

  final _repository = ProyectemosRepository();
  ControllerCrearUnPodcast get _controller => widget.controller;

  late Future<List<String>?> studentsNamesFuture;

  Map<String, bool> nameSelection = {};

  GoogleSignInAccount? _currentUser;

  @override
  void initState() {
    super.initState();
    studentsNamesFuture = _repository.getStudents();
    _loadCurrentUserAndSetNames();
  }

  Future<void> _loadCurrentUserAndSetNames() async {
    _currentUser = await getCurrentUser(context);
    final names = await studentsNamesFuture;

    if (names != null) {
      for (final name in names) {
        if (name == _currentUser?.displayName) {
          nameSelection[name] = true;
          if (!_controller.studentGroup.contains(name)) {
            _controller.studentGroup.add(name);
          }
        } else {
          nameSelection[name] = false;
        }
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text(
              StringsComoCrearUnPodcast.introTareaDosCrearUnPodcast,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<String>?>(
              future: studentsNamesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(color: ThemeColors.blue),
                  );
                } else if (snapshot.hasError) {
                  return Text('Erro: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text(
                    'Nenhum aluno encontrado',
                    style: ThemeText.paragraph16GrayNormal,
                  );
                } else {
                  final names = snapshot.data!;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      children: names
                          .map((name) => _buildCheckbox(name, _currentUser))
                          .toList(),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckbox(String name, GoogleSignInAccount? currentUser) {
    return CheckboxListTile(
      activeColor: ThemeColors.blue,
      title: Text(name, style: ThemeText.paragraph16GrayNormal),
      value: nameSelection[name],
      onChanged: (bool? value) {
        if (name == currentUser?.displayName && value == false) {
          showToast(context, 'No puedes deseleccionar tu propio nombre.',
              ThemeColors.yellow, ThemeColors.white);
          return;
        }
        if (value == true && countSelectedNames() >= 3) {
          showToast(context,
              '¡Selecione un mínimo 2 y máximo 3 alumnos!',
              ThemeColors.yellow, ThemeColors.white);
          return;
        }
        setState(() {
          nameSelection[name] = value!;
          if (value && !_controller.studentGroup.contains(name)) {
            _controller.studentGroup.add(name);
          } else {
            _controller.studentGroup.remove(name);
          }
        });
      },
    );
  }

  int countSelectedNames() {
    return nameSelection.values.where((v) => v).length;
  }

  @override
  bool get wantKeepAlive => true;
}