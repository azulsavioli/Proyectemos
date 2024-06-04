import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/app/modules/registration/registration_controller.dart';
import 'package:proyectemos/repository/repository_impl.dart';

import '../../../commons/styles.dart';
import '../../../services/toast_services.dart';
import '../../../utils/get_user.dart';

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
  String dropdownValor1 = '';
  String dropdownValor2 = '';
  String studentName = '';

  bool schoolChoosed = false;
  bool classRoomChoosed = false;
  List schools = [];

  @override
  Widget build(BuildContext context) {
    final currentUser = getCurrentUser(context);

    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: AppBar(
        backgroundColor: ThemeColors.blue,
        elevation: 0,
        title: Text(
          'Registro de estudiantes',
          style: ThemeText.paragraph16White,
          textAlign: TextAlign.center,
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
                      return const Center(
                          child: CircularProgressIndicator(
                        color: ThemeColors.blue,
                      ));
                    }

                    final schoolOptions = [
                      'Selecione sua escuela!',
                      ...snapshot.data!,
                    ];
                    return DropdownButtonFormField2<String>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      hint: const Padding(
                        padding: EdgeInsets.only(left: 12),
                        child: Text('Elige tu escuela'),
                      ),
                      value: (dropdownValor1.isEmpty) ? null : dropdownValor1,
                      iconStyleData: IconStyleData(
                        iconSize: 42,
                        iconEnabledColor: ThemeColors.yellow,
                      ),
                      onChanged: (option) {
                        if (option == 'Selecione sua escuela!') {
                          showToast(
                            color: ThemeColors.red,
                            'Por favor, selecione uma escola válida',
                          );
                        } else {
                          setState(() {
                            dropdownValor1 = option!;
                            dropdownValor2 = '';
                            schoolChoosed = true;
                          });
                        }
                      },
                      items: schoolOptions.map((String value) {
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
                          child: CircularProgressIndicator(
                            color: ThemeColors.blue,
                          ),
                        );
                      }

                      final classOptions = [
                        'Selecione sua clase!',
                        ...snapshot.data!,
                      ];
                      return DropdownButtonFormField2<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        hint: const Padding(
                          padding: EdgeInsets.only(left: 12),
                          child: Text('Elige tu grado'),
                        ),
                        value:
                            dropdownValor2.isNotEmpty ? dropdownValor2 : null,
                        iconStyleData: IconStyleData(
                          iconSize: 42,
                          iconEnabledColor: ThemeColors.yellow,
                        ),
                        onChanged: (option) {
                          if (option == 'Selecione sua clase!') {
                            showToast(
                              color: ThemeColors.red,
                              'Por favor, selecione uma clase válida',
                            );
                          } else {
                            setState(() {
                              classRoomChoosed = true;
                              dropdownValor2 = option!;
                            });
                          }
                        },
                        items: classOptions.map((String value) {
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
              if (classRoomChoosed && currentUser == null)
                TextFormField(
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    label: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Text(
                        'Nombre del estudiante',
                        style: ThemeText.paragraph16GrayLight,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Por favor, ingrese su nombre';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      studentName = value;
                    });
                  },
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
                    if (currentUser != null)
                      {
                        setState(
                          () => studentName = currentUser.displayName!,
                        ),
                      },
                    if (dropdownValor1 != 'Selecione sua escuela!' &&
                        dropdownValor2 != 'Selecione sua clase!' &&
                        dropdownValor1.isNotEmpty &&
                        dropdownValor2.isNotEmpty &&
                        studentName.isNotEmpty &&
                        studentName != '')
                      {
                        _controller.saveStudentOptions(
                          currentUser,
                          dropdownValor1,
                          dropdownValor2,
                          studentName,
                          formKey,
                          context,
                        ),
                      }
                    else
                      {
                        showToast(
                          color: ThemeColors.red,
                          'Seleciona sus datos correctamente',
                        ),
                      },
                  },
                  label: Text(
                    'Confirmar los datos',
                    style: ThemeText.paragraph16WhiteBold,
                  ),
                  icon: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
