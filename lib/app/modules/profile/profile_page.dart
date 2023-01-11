import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../widgets/card_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  void goTo(routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width * .9;
    final height = MediaQuery.of(context).size.width * .2;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: ThemeColors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ThemeColors.white),
          automaticallyImplyLeading: true,
          title: const Text(
            'Perfil',
            style: ThemeText.paragraph16WhiteBold,
          ),
        ),
        // endDrawer: const DrawerMenuWidget(),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 180,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: ThemeColors.yellow,
                        child: CircleAvatar(
                          radius: 27,
                          backgroundImage: (user.photoURL == null)
                              ? const NetworkImage(
                                  'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=')
                              : NetworkImage(user.photoURL!, scale: 40),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      (user.displayName == null)
                          ? const Text('')
                          : Text(
                              user.displayName!,
                              style: ThemeText.paragraph16BlueBold,
                            ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        user.email!,
                        style: ThemeText.paragraph16GrayNormal,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * .9,
                    height: 80,
                    child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '0/14',
                                style: ThemeText.paragraph16BlueBold,
                              ),
                              Text(
                                'Tareas',
                                style: ThemeText.paragraph14Gray,
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Text(
                                '0%',
                                style: ThemeText.paragraph16BlueBold,
                              ),
                              Text(
                                'Conclusão',
                                style: ThemeText.paragraph14Gray,
                              )
                            ],
                          ),
                        ]))),
              ),
              // adicionar as rotas
              // CardButton(
              //   iconSize: 25,
              //   text: 'Notificaciones',
              //   backgroundColor: ThemeColors.red,
              //   icon: Icons.access_alarm_outlined,
              //   cardWidth: width,
              //   cardHeight: height,
              //   namedRoute: '',
              //   shadowColor: ThemeColors.red,
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // CardButton(
              //   iconSize: 25,
              //   text: 'Informaciones',
              //   backgroundColor: ThemeColors.yellow,
              //   icon: Icons.announcement_outlined,
              //   cardWidth: width,
              //   cardHeight: height,
              //   namedRoute: '',
              //   shadowColor: ThemeColors.yellow,
              // ),
              // const SizedBox(
              //   height: 8,
              // ),
              // CardButton(
              //   iconSize: 25,
              //   text: 'Logros',
              //   backgroundColor: ThemeColors.blue,
              //   icon: Icons.workspace_premium,
              //   cardWidth: width,
              //   cardHeight: height,
              //   namedRoute: '',
              //   shadowColor: ThemeColors.blue,
              // ),
              const SizedBox(
                height: 8,
              ),
              CardButton(
                iconSize: 25,
                text: 'Profesor(a)',
                backgroundColor: ThemeColors.red,
                icon: Icons.volunteer_activism_outlined,
                cardWidth: width,
                cardHeight: height,
                namedRoute: '',
                shadowColor: ThemeColors.red,
              ),
              const SizedBox(
                height: 8,
              ),
              // CardButton(
              //   iconSize: 25,
              //   text: 'Configuraciones',
              //   backgroundColor: ThemeColors.yellow,
              //   icon: Icons.settings_rounded,
              //   cardWidth: width,
              //   cardHeight: height,
              //   namedRoute: '',
              //   shadowColor: ThemeColors.yellow,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
