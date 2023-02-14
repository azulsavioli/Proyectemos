import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../commons/styles.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final dropSchoolValue = ValueNotifier('');
  final dropSeriesValue = ValueNotifier('');
  final dropClassroomValue = ValueNotifier('');
  final dropSchoolOptions = ['Aplicação', 'Marista', 'Terceirão'];
  final dropSeriesOptions = ['1º Colegial', '2º Colegial', '3º Colegial'];
  final dropClassroomOptions = ['A1', 'B2', 'C3'];

  Future<void> saveStudentOptions() async {
    const isStudentInfoSaved = true;
    final preferences = await SharedPreferences.getInstance();
    final studentInfo =
        '${dropSchoolValue.value}/${dropSeriesValue.value}/${dropClassroomValue.value}';
    await preferences.setString('studentInfo', studentInfo);
    await preferences.setBool('studentInfoSaved', isStudentInfoSaved);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          backgroundColor: ThemeColors.blue,
          elevation: 0,
          title: const Text(
            'Registro de estudiantes',
            style: ThemeText.paragraph16White,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    'Elige tu escuela, grado y clase',
                    style: ThemeText.paragraph16GrayBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 70,
                  child: ValueListenableBuilder(
                    valueListenable: dropSchoolValue,
                    builder: (BuildContext context, String value, _) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text('Elige tu escuela'),
                        ),
                        value: (value.isEmpty) ? null : value,
                        iconSize: 42,
                        iconEnabledColor: ThemeColors.yellow,
                        isExpanded: true,
                        onChanged: (option) =>
                            dropSchoolValue.value = option.toString(),
                        items: dropSchoolOptions
                            .map(
                              (op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 70,
                  child: ValueListenableBuilder(
                    valueListenable: dropSeriesValue,
                    builder: (BuildContext context, String value, _) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text('Elige tu grado'),
                        ),
                        value: (value.isEmpty) ? null : value,
                        iconSize: 42,
                        iconEnabledColor: ThemeColors.yellow,
                        isExpanded: true,
                        onChanged: (option) =>
                            dropSeriesValue.value = option.toString(),
                        items: dropSeriesOptions
                            .map(
                              (op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                SizedBox(
                  height: 70,
                  child: ValueListenableBuilder(
                    valueListenable: dropClassroomValue,
                    builder: (BuildContext context, String value, _) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text('Elige tu clase'),
                        ),
                        value: (value.isEmpty) ? null : value,
                        iconSize: 42,
                        iconEnabledColor: ThemeColors.yellow,
                        isExpanded: true,
                        onChanged: (option) =>
                            dropClassroomValue.value = option.toString(),
                        items: dropClassroomOptions
                            .map(
                              (op) => DropdownMenuItem(
                                value: op,
                                child: Text(op),
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 60,
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeColors.red,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () => {
                      if (formKey.currentState!.validate())
                        {
                          saveStudentOptions.call().then(
                                (value) =>
                                    ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Datos salvos com sucesso'),
                                  ),
                                ),
                              ),
                          Navigator.pushNamed(context, '/proyectos')
                        }
                      else
                        {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                '''¡Ups! Ha ocurrido un error y sus datos no ha sido enviado. ¡Inténtalo de nuevo!''',
                              ),
                            ),
                          ),
                        }
                    },
                    label: const Text(
                      'Confirmar los datos',
                      style: ThemeText.paragraph16WhiteBold,
                    ),
                    icon: const Icon(Icons.check),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
