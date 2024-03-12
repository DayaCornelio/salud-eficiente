import 'package:flutter/material.dart';

class Medico extends StatelessWidget {
  const Medico({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medico'),
      ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProfileDetails(profile: profiles[index]),
                ),
              );
            },
            child: _buildProfileCard(index),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(int index) {
    return Card(
      child: ListTile(
        title: Text(profiles[index]['name']!),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profiles[index]['info']!),
            Text(profiles[index]['location']!),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatelessWidget {
  final Map<String, String> profile;

  const ProfileDetails({required this.profile, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(profile['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Información del doctor:'),
            Text(profile['info']!),
            const Text('Ubicación:'),
            Text(profile['location']!),
            const SizedBox(height: 20),
            const Text('Agendar cita:'),
            // Agregar Formulario de citas//pendienteeeeeee.......
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> profiles = [
  {
    'name': 'Dr. Carlos Andrade',
    'info': 'Especialista en quemaduras y heridas de segundo grado',
    'location': 'Clínica Salud Eficiente, Av. Principal #123'
  },
  {
    'name': 'Dra. Aurora Sanchez',
    'info': 'Especialista en pediatria.',
    'location': 'Clínica Salud Eficiente, Av. Principal #123'
  },
  {
    'name': 'Dr. Andres Garcia',
    'info': 'Medico general.',
    'location': 'Clínica Salud Eficiente, Av. Principal #123'
  }
];
