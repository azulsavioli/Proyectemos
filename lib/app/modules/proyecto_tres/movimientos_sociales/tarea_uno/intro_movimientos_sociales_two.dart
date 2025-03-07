import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:proyectemos/commons/strings/strings_crea_tu_movimiento.dart';
import 'package:proyectemos/repository/proyectemos_repository.dart';
import 'package:proyectemos/services/toast_services.dart';
import '../../../../../commons/styles.dart';
import '../../../../../utils/get_user.dart';
import 'movimientos_sociales_controller.dart';

class IntroDosMovimientosSocialesPage extends StatefulWidget {
  final MovimientosSocialesController controller;
  const IntroDosMovimientosSocialesPage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  State<IntroDosMovimientosSocialesPage> createState() =>
      _IntroDosMovimientosSocialesPageState();
}

class _IntroDosMovimientosSocialesPageState
    extends State<IntroDosMovimientosSocialesPage>
    with AutomaticKeepAliveClientMixin {
  final _repository = ProyectemosRepository();
  MovimientosSocialesController get _controller => widget.controller;

  late Future<List<String>?>? studentsNamesFuture;

  Map<String, bool> nameSelection = {};

  @override
  void initState() {
    super.initState();
    final currentUser = getCurrentUser(context);
    studentsNamesFuture = _repository.getStudents();
    studentsNamesFuture?.then((names) {
      if (names != null) {
        for (final name in names) {
          if (name == currentUser?.displayName) {
            // nameSelection[name] = true;
            nameSelection[name] = (name == currentUser?.displayName);
            if (!_controller.studentGroup.contains(name)) {
              _controller.studentGroup.add(name);
            }
          } else {
            nameSelection[name] = false;
          }
        }
        setState(() {});
      }
    });
  }

  int countSelectedNames() {
    return nameSelection.values.where((value) => value).length;
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

    super.build(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text(
              StringsCreaTuMovimiento.eligirGrupo,
              style: ThemeText.paragraph16GrayNormal,
            ),
            const SizedBox(height: 30),
            FutureBuilder<List<String>?>(
              future: studentsNamesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Padding(
                    padding: EdgeInsets.only(top: 250),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: ThemeColors.blue,
                    )),
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
                  for (final name in names) {
                    if (!nameSelection.containsKey(name)) {
                      nameSelection[name] = (name == currentUser?.displayName);
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 80),
                    child: Column(
                      children: names
                          .map((name) => _buildCheckbox(name, currentUser))
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

  @override
  bool get wantKeepAlive => true;

  Widget _buildCheckbox(String name, GoogleSignInAccount? currentUser) {
    return CheckboxListTile(
      activeColor: ThemeColors.blue,
      title: Text(
        name,
        style: ThemeText.paragraph16GrayNormal,
      ),
      value: nameSelection[name],
      onChanged: (bool? value) {
        if (name == currentUser?.displayName && value == false) {
          showToast(
            'No puedes deseleccionar tu propio nombre.',
            color: ThemeColors.yellow,
          );
          return;
        }

        if (value == true && countSelectedNames() >= 3) {
          showToast(
            '¡Selecione un mínimo 2 y máximo 3 alumnos!',
            color: ThemeColors.yellow,
          );
          return;
        }
        setState(() {
          nameSelection[name] = value!;
          if (value) {
            if (!_controller.studentGroup.contains(name)) {
              _controller.studentGroup.add(name);
            }
          } else {
            if (name != currentUser?.displayName) {
              _controller.studentGroup.remove(name);
            }
            _controller.studentGroup.remove(name);
          }
        });
      },
    );
  }
}
