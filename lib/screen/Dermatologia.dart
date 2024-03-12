import 'package:flutter/material.dart';

class Dermatologia extends StatelessWidget {
  const Dermatologia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dermatología'),
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
    'name': 'Dr. Juan Pérez',
    'info': 'Especialista en Dermatología con más de 10 años de experiencia.',
    'location': 'Clínica Salud Eficiente, Av. Principal #123'
  },
  {
    'name': 'Dra. María García',
    'info': 'Experta en tratamientos de piel y enfermedades dermatológicas.',
    'location': 'Clínica Salud Eficiente, Av. Principal #123'
  },
  {
    'name': 'Dr. Carlos Martínez',
    'info':
        'Dermatólogo certificado, disponible para consultas y tratamientos.',
    'location': 'Clínica Salud Eficiente, Av. Principal #123'
  }
];
