import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyectemos/commons/styles.dart';

import '../widgets/drawer_menu.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
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
            'Profile',
            style: ThemeText.title20White,
          ),
        ),
        // endDrawer: const DrawerMenuWidget(),
        body: Center(
          child: Column(
            children: [
              Card(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: ThemeColors.blue,
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
                              style: ThemeText.paragraph16Blue,
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
                    child: Container(
                      color: ThemeColors.white,
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
                                  style: ThemeText.paragraph16Blue,
                                ),
                                Text(
                                  'Tareas',
                                  style: ThemeText.paragraph14Blue,
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  '0',
                                  style: ThemeText.paragraph16Blue,
                                ),
                                Text(
                                  'Notas',
                                  style: ThemeText.paragraph14Blue,
                                )
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: const [
                                Text(
                                  '0%',
                                  style: ThemeText.paragraph16Blue,
                                ),
                                Text(
                                  'Conclusão',
                                  style: ThemeText.paragraph14Blue,
                                )
                              ],
                            ),
                          ])),
                    )),
              ),
              Text(
                'Email: ${user.email!}',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
