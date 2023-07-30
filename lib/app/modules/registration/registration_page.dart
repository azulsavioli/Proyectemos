import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/registration/registration_controller.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../commons/styles.dart';
import '../../../services/toast_services.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final formKey = GlobalKey<FormState>();
  final _repository = RepositoryImpl();
  final _controller = RegistrationController();
  var dropdownValor1;
  var dropdownValor2;
  bool schoolChoosed = false;
  List schools = [];

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ThemeColors.white,
        appBar: AppBar(
          backgroundColor: ThemeColors.blue,
          elevation: 0,
          title: Text(
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
                Center(
                  child: Text(
                    'Elige tu escuela y clase',
                    style: ThemeText.paragraph16GrayBold,
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 70,
                  child: FutureBuilder<List<String>>(
                    future: _repository.getSchoolsInfo(),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<List<String>> snapshot,
                    ) {
                      if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      snapshot.data!.insert(0, 'Selecione sua escuela!');
                      dropdownValor1 ??= snapshot.data![0];

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
                        value: (dropdownValor1.isEmpty) ? null : dropdownValor1,
                        iconSize: 42,
                        iconEnabledColor: ThemeColors.yellow,
                        isExpanded: true,
                        onChanged: (option) {
                          setState(() {
                            dropdownValor1 = option;
                            schoolChoosed = true;
                          });
                        },
                        items: snapshot.data
                            ?.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                if (!schoolChoosed)
                  const SizedBox()
                else
                  SizedBox(
                    height: 70,
                    child: FutureBuilder<List<String>>(
                      future: _repository.getClassRoomInfo(dropdownValor1),
                      builder: (
                        BuildContext context,
                        AsyncSnapshot<List<String>> snapshot,
                      ) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        snapshot.data!.insert(0, 'Selecione sua clase!');
                        dropdownValor2 ??= snapshot.data![0];

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
                          value:
                              (dropdownValor2.isEmpty) ? null : dropdownValor2,
                          iconSize: 42,
                          iconEnabledColor: ThemeColors.yellow,
                          isExpanded: true,
                          onChanged: (option) {
                            setState(() {
                              dropdownValor2 = option;
                            });
                          },
                          items: snapshot.data
                              ?.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
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
                      if (dropdownValor1 != 'Selecione sua escuela!' &&
                          dropdownValor2 != 'Selecione sua clase!')
                        {
                          _controller.saveStudentOptions(
                            dropdownValor1,
                            dropdownValor2,
                            formKey,
                            context,
                          )
                        }
                      else
                        {
                          showToast(
                            color: ThemeColors.red,
                            'Seleciona sus datos correctamente',
                          )
                        }
                    },
                    label: Text(
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
