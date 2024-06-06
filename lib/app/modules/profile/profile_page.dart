import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/profile/profile_controller.dart';
import 'package:proyectemos/commons/styles.dart';

import '../../../commons/google_sign_in.dart';
import '../../../repository/repository_impl.dart';
import '../../../services/auth_services.dart';
import '../widgets/card_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _controller = ProfileController();
  final _repository = RepositoryImpl();
  var percentage = 0.0;
  final user = FirebaseAuth.instance.currentUser!;
  var allStudentsInfo = [];
  var studentSchool = '';
  var studentClass = '';

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await getStudentInfo();
    await _controller.getUnoTaskCompleted();
    await _controller.getDosTaskCompleted();
    await _controller.getTresTaskCompleted();
    await _controller
        .getPercentage(); // Espera a conclusão da obtenção da porcentagem
    setState(() {
      // Atualiza o estado com a nova porcentagem
      percentage = _controller.percentage;
    });
  }

  Future<void> getStudentInfo() async {
    allStudentsInfo = await _repository.getStudentInfo();
    studentSchool = allStudentsInfo[1];
    studentClass = allStudentsInfo[2];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.width * .2;
    var tasksCompleted = 0;
    final _repository = RepositoryImpl();

    setState(() {
      tasksCompleted = _controller.getAllTasks();
    });

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Perfil',
            style: ThemeText.paragraph16WhiteBold,
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
            onPressed: () => Navigator.pushNamed(context, '/proyectos'),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.delete),
          onPressed: () {
            _repository
              // ..resetTaskCompleted('artistasTareaDosCompleted')
              // ..resetTaskCompleted('artistasTareaUnoCompleted')
              // ..resetTaskCompleted('latinoamericaTareaDosCompleted')
              // ..resetTaskCompleted('latinoamericaTareaUnoCompleted')
              // ..resetTaskCompleted('eventoTareaUnoCompleted')
              // ..resetTaskCompleted('divulgationCompleted')
              // ..resetTaskCompleted('conocesPodcastCompleted')
              // ..resetTaskCompleted('comoCrearPodcastTareaUnoCompleted')
              // ..resetTaskCompleted('comoCrearPodcastTareaDosCompleted')
              // ..resetTaskCompleted('laEncuestaTareaUnoCompleted')
              // ..resetTaskCompleted('laEncuestaTareaDosCompleted')
              // ..resetTaskCompleted('creacionEncuestaCompleted')
              // ..resetTaskCompleted('grabacionPodcastTareaUnoCompleted')
              // ..resetTaskCompleted('grabacionPodcastTareaDosCompleted')
              // ..resetTaskCompleted('laSociedadTareaCompleted')
              // ..resetTaskCompleted('movimientosSocialesCompleted')
              // ..resetTaskCompleted('tuAlrededorCompleted')
              ..resetTaskCompleted('creaTuMovimientoTareaUnoCompleted')
              ..resetTaskCompleted('creaTuMovimientoTareaDosCompleted');
          },
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Card(
                  elevation: 3,
                  color: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 180,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: ThemeColors.yellow,
                          child: CircleAvatar(
                            radius: 27,
                            backgroundImage: (user.photoURL == null)
                                ? const NetworkImage(
                                    'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=',
                                  )
                                : NetworkImage(user.photoURL!, scale: 40),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        if (user.displayName == null)
                          const Text('')
                        else
                          Text(
                            user.displayName!,
                            style: ThemeText.paragraph16BlueBold,
                          ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          user.email!,
                          style: ThemeText.paragraph14Gray,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  color: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '$tasksCompleted/${_controller.allTasks}',
                                style: ThemeText.paragraph16BlueBold,
                              ),
                              Text(
                                'Tareas',
                                style: ThemeText.paragraph14Gray,
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${_controller.percentage.toStringAsFixed(0)}%',
                                style: ThemeText.paragraph16BlueBold,
                              ),
                              Text(
                                'Conclusão',
                                style: ThemeText.paragraph14Gray,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  color: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Escola',
                                style: ThemeText.paragraph16BlueBold,
                              ),
                              Text(
                                '$studentSchool',
                                style: ThemeText.paragraph14Gray,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Card(
                  elevation: 3,
                  color: Colors.white,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 80,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Turma',
                                style: ThemeText.paragraph16BlueBold,
                              ),
                              Text(
                                '$studentClass',
                                style: ThemeText.paragraph14Gray,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                CardButton(
                  iconSize: 25,
                  text: 'Profesor(a)',
                  backgroundColor: ThemeColors.green,
                  icon: Icons.volunteer_activism_outlined,
                  cardWidth: width,
                  cardHeight: height,
                  namedRoute: '/profile_contato_professora',
                  shadowColor: ThemeColors.green,
                ),
                const SizedBox(
                  height: 8,
                ),
                logoutCard(context, _controller),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget logoutCard(
  BuildContext context,
  ProfileController _controller,
) {
  final width = MediaQuery.of(context).size.width * .9;
  final height = MediaQuery.of(context).size.width * .2;
  final authService = AuthService();

  return SizedBox(
    height: height,
    width: width,
    child: ElevatedButton.icon(
      icon: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: ThemeColors.red,
          child: Icon(
            Icons.logout,
            size: 25,
            color: ThemeColors.white,
          ),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          // Definindo a forma retangular
          borderRadius: BorderRadius.circular(10), // Raio de borda desejado
        ),
        foregroundColor: ThemeColors.red,
        backgroundColor: Colors.white,
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 20),
        textStyle: ThemeText.paragraph14Gray,
      ),
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        if (provider.googleSignIn.currentUser != null) {
          provider.googleLogout();
        } else {
          authService.logout();
        }
      },
      label: Row(
        children: [
          const SizedBox(
            width: 15,
          ),
          Text(
            "Salir",
            style: ThemeText.paragraph14Gray,
          ),
        ],
      ),
    ),
  );
}
