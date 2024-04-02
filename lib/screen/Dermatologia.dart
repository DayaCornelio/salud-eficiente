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
            const SizedBox(height: 10),
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
  _ProfileDetailsState createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  void _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 1),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _scheduleAppointment(BuildContext context) {
    if (_selectedDate == null || _selectedTime == null) {
      // Ensure date and time are selected
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content:
                const Text('Por favor, seleccione fecha y hora para la cita.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    } else {
      // Implement your appointment scheduling logic here
      // For example, you can show a dialog box confirming the appointment
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Cita Agendada'),
            content: Text(
                'Su cita con ${widget.profile['name']} el ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year} a las ${_selectedTime!.hour}:${_selectedTime!.minute} ha sido agendada con éxito.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile['name']!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Información del doctor:'),
            Text(widget.profile['info']!),
            const Text('Ubicación:'),
            Text(widget.profile['location']!),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDate(context);
              },
              child: const Text('Seleccionar fecha'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _selectTime(context);
              },
              child: const Text('Seleccionar hora'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _scheduleAppointment(context);
              },
              child: const Text('Visualizar Cita'),
            ),
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
