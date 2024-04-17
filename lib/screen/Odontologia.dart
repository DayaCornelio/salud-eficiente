import 'package:flutter/material.dart';
import 'package:salud_eficiente/services/firebase_service_2.dart';
import 'package:salud_eficiente/services/firebase_service_3.dart';

class Odontologia extends StatelessWidget {
  const Odontologia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dermatología'),
        backgroundColor: const Color.fromARGB(255, 189, 190, 190),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CitasAgendadas()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: profiles.length,
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
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class ProfileDetails extends StatefulWidget {
  final Map<String, String> profile;

  const ProfileDetails({required this.profile, Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _commentController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile['name']!),
        backgroundColor: const Color.fromARGB(255, 197, 61, 152),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Información del doctor:'),
            Text(widget.profile['info']!),
            const Text('Ubicación:'),
            Text(widget.profile['location']!),
            const SizedBox(height: 20),
            TextField(
              controller: _ratingController,
              decoration: const InputDecoration(
                labelText: 'Calificar servicio',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: const InputDecoration(
                labelText: 'Deje su comentario',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(
                labelText: 'Fecha (DD/MM/AAAA)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _timeController,
              decoration: const InputDecoration(
                labelText: 'Hora (HH:MM)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await addOdontologia(
                  _ratingController.text,
                  _commentController.text,
                  _dateController.text,
                  _timeController.text,
                );
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}

class CitasAgendadas extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const CitasAgendadas({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Citas Agendadas'),
        backgroundColor: const Color.fromARGB(255, 189, 190, 190),
      ),
      body: FutureBuilder<List>(
        future: getOdontologia(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List? data = snapshot.data;
            return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (_, index) => Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TitleSection(title: data?[index]['Calificacion']),
                    TitleSection(title: data?[index]['Comentario']),
                    TitleSection(title: data?[index]['Fecha']),
                    TitleSection(title: data?[index]['Hora']),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
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
