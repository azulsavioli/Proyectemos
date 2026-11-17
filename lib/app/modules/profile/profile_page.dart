import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:proyectemos/app/modules/profile/profile_controller.dart';
import 'package:proyectemos/commons/styles.dart';
import 'package:proyectemos/providers/acessibility_provider.dart';
import 'package:proyectemos/utils/navigation.dart';

import '../../../commons/google_sign_in.dart';
import '../../../repository/repository_impl.dart';
import '../../../services/auth_services.dart';
import '../widgets/card_button.dart';
import '../widgets/custom_switch.dart';

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
  var studentSchool = '';
  var studentClass = '';
  bool _loading = true;
  String? _loadError;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await getStudentInfo();
      await _controller.getUnoTaskCompleted();
      await _controller.getDosTaskCompleted();
      await _controller.getTresTaskCompleted();
      await _controller.getPercentage();
      if (!mounted) return;
      setState(() {
        percentage = _controller.percentage;
        _loading = false;
        _loadError = null;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _loading = false;
        _loadError = 'No se pudo cargar el perfil. Inténtalo de nuevo.';
      });
    }
  }

  Future<void> getStudentInfo() async {
    final allStudentsInfo = await _repository.getStudentInfo();
    if (allStudentsInfo.length > 2) {
      studentSchool = '${allStudentsInfo[1]}';
      studentClass = '${allStudentsInfo[2]}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.width * .2;
    final tasksCompleted = _controller.getAllTasks();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Perfil', style: ThemeText.paragraph16WhiteBold),
          leading: IconButton(
            tooltip: 'Voltar',
            icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
            onPressed: () => popOrReplace(context, '/proyectos'),
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.delete),
        //   onPressed: () {
        //     _repository
        //       // ..resetTaskCompleted('artistasTareaDosCompleted')
        //       // ..resetTaskCompleted('artistasTareaUnoCompleted')
        //       // ..resetTaskCompleted('latinoamericaTareaDosCompleted')
        //       // ..resetTaskCompleted('latinoamericaTareaUnoCompleted')
        //       // ..resetTaskCompleted('eventoTareaUnoCompleted')
        //       // ..resetTaskCompleted('divulgationCompleted')
        //       // ..resetTaskCompleted('conocesPodcastCompleted')
        //       // ..resetTaskCompleted('comoCrearPodcastTareaUnoCompleted')
        //       // ..resetTaskCompleted('comoCrearPodcastTareaDosCompleted')
        //       // ..resetTaskCompleted('laEncuestaTareaUnoCompleted')
        //       // ..resetTaskCompleted('laEncuestaTareaDosCompleted')
        //       // ..resetTaskCompleted('creacionEncuestaCompleted')
        //       // ..resetTaskCompleted('grabacionPodcastTareaUnoCompleted')
        //       // ..resetTaskCompleted('grabacionPodcastTareaDosCompleted')
        //       // ..resetTaskCompleted('laSociedadTareaCompleted')
        //       // ..resetTaskCompleted('movimientosSocialesCompleted')
        //       // ..resetTaskCompleted('tuAlrededorCompleted')
        //       ..resetTaskCompleted('creaTuMovimientoTareaUnoCompleted')
        //       ..resetTaskCompleted('creaTuMovimientoTareaDosCompleted');
        //   },
        // ),
        body: _loading
            ? const Center(child: CircularProgressIndicator())
            : _loadError != null
            ? Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _loadError!,
                        textAlign: TextAlign.center,
                        style: ThemeText.paragraph14Gray,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _loading = true;
                            _loadError = null;
                          });
                          _initializeData();
                        },
                        child: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 8),
                      Card(
                        elevation: 3,
                        color: Colors.white,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                                        : NetworkImage(
                                            user.photoURL!,
                                            scale: 40,
                                          ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                if (user.displayName == null)
                                  const Text('')
                                else
                                  Text(
                                    user.displayName!,
                                    textAlign: TextAlign.center,
                                    style: ThemeText.paragraph16BlueBold,
                                  ),
                                const SizedBox(height: 8),
                                Text(
                                  user.email!,
                                  textAlign: TextAlign.center,
                                  style: ThemeText.paragraph14Gray,
                                ),
                                const SizedBox(height: 8),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
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
                      const SizedBox(height: 8),
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
                      const SizedBox(height: 8),
                      acessibilityCard(context),
                      const SizedBox(height: 8),
                      logoutCard(context),
                      const SizedBox(height: 8),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Widget acessibilityCard(BuildContext context) {
  final width = MediaQuery.of(context).size.width * .9;
  final provider = context.watch<AccessibilityProvider>();
  final accessible = provider.isEnabled(context);
  return SizedBox(
    width: width,
    child: Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: ThemeColors.yellow,
              child: Icon(
                Icons.settings_accessibility_sharp,
                size: 25,
                color: ThemeColors.white,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Acessibilidade', style: ThemeText.paragraph14Gray),
                  Text(
                    provider.overridePreference == null
                        ? 'Seguindo o sistema'
                        : 'Preferência do app',
                    style: ThemeText.paragraph12Gray,
                  ),
                  if (provider.overridePreference != null)
                    TextButton(
                      onPressed: provider.clearOverride,
                      child: const Text('Seguir o sistema'),
                    ),
                ],
              ),
            ),
            Text(
              'off',
              style: TextStyle(
                color: accessible ? ThemeColors.gray : ThemeColors.blue,
                fontWeight: accessible ? FontWeight.w400 : FontWeight.w700,
              ),
            ),
            const CustomSwitch(),
            Text(
              'on',
              style: TextStyle(
                color: accessible ? ThemeColors.blue : ThemeColors.gray,
                fontWeight: accessible ? FontWeight.w700 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget logoutCard(BuildContext context) {
  final width = MediaQuery.of(context).size.width * .9;
  final authService = AuthService();

  return SizedBox(
    width: width,
    child: ElevatedButton.icon(
      icon: const Padding(
        padding: EdgeInsets.only(left: 8),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: ThemeColors.red,
          child: Icon(Icons.logout, size: 25, color: ThemeColors.white),
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        foregroundColor: ThemeColors.red,
        backgroundColor: Colors.white,
        elevation: 3,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        textStyle: ThemeText.paragraph14Gray,
      ),
      onPressed: () async {
        final provider = Provider.of<GoogleSignInProvider>(
          context,
          listen: false,
        );
        await provider.signOut();
        await authService.logout();
        if (!context.mounted) return;
        Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
      },
      label: Row(
        children: [
          const SizedBox(width: 15),
          Text('Salir', style: ThemeText.paragraph14Gray),
        ],
      ),
    ),
  );
}
