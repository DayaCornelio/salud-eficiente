import 'package:flutter/material.dart';

class Odontologia extends StatelessWidget {
  const Odontologia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Odontologia'),
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
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

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
    final TimeOfDay? pickedTime = await showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Seleccionar Hora'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                for (int hour = 10; hour <= 18; hour++)
                  for (int minute = 0; minute < 60; minute += 30)
                    ListTile(
                      title: Text('$hour:${minute.toString().padLeft(2, '0')}'),
                      onTap: () {
                        Navigator.of(context)
                            .pop(TimeOfDay(hour: hour, minute: minute));
                      },
                    ),
              ],
            ),
          ),
        );
      },
    );

    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  void _sendFeedback(BuildContext context) {
    final String comment = _commentController.text;
    if (comment.isNotEmpty && _rating > 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Servicio y comentario enviado'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Calificación: $_rating estrellas'),
                const SizedBox(height: 10),
                Text('Comentario: $comment'),
              ],
            ),
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
      // Alerta de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text(
                'Por favor, proporcione una calificación y un comentario antes de enviar.'),
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

  void _viewAppointment(BuildContext context) {
    String appointmentInfo = "No hay cita agendada";
    if (_selectedDate != null && _selectedTime != null) {
      appointmentInfo =
          "Fecha de cita: ${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}\n";
      appointmentInfo +=
          "Hora de cita: ${_selectedTime!.hour}:${_selectedTime!.minute}";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cita Agendada'),
          content: Text(appointmentInfo),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.profile['name']!),
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _viewAppointment(context);
              },
              child: const Text('Ver cita agendada'),
            ),
            const SizedBox(height: 80),
            Row(
              children: [
                const Text('Calificar servicio: '),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 1;
                    });
                  },
                  icon: Icon(_rating >= 1 ? Icons.star : Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 2;
                    });
                  },
                  icon: Icon(_rating >= 2 ? Icons.star : Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 3;
                    });
                  },
                  icon: Icon(_rating >= 3 ? Icons.star : Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 4;
                    });
                  },
                  icon: Icon(_rating >= 4 ? Icons.star : Icons.star_border),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = 5;
                    });
                  },
                  icon: Icon(_rating >= 5 ? Icons.star : Icons.star_border),
                ),
              ],
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
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _sendFeedback(context);
              },
              child: const Text('Enviar'),
            ),
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
