import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProyectosPage extends StatefulWidget {
  const ProyectosPage({Key? key}) : super(key: key);

  @override
  State<ProyectosPage> createState() => _ProyectosPageState();
}

class _ProyectosPageState extends State<ProyectosPage> {
  final user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('Profile'),
            CircleAvatar(
              radius: 40,
              backgroundImage: (user.photoURL == null)
                  ? const NetworkImage(
                      'https://media.istockphoto.com/vectors/user-icon-flat-isolated-on-white-background-user-symbol-vector-vector-id1300845620?k=20&m=1300845620&s=612x612&w=0&h=f4XTZDAv7NPuZbG0habSpU0sNgECM0X7nbKzTUta3n8=')
                  : NetworkImage(user.photoURL!),
            ),
            const SizedBox(
              height: 8,
            ),
            (user.displayName == null)
                ? const Text('')
                : Text(
                    'Nome: ${user.displayName!}',
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Email: ${user.email!}',
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
