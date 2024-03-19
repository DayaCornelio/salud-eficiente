import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Perfil'),
      ),
      backgroundColor:
          Color.fromARGB(255, 183, 218, 235), // Color de fondo beige
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo),
                  SizedBox(width: 8.0),
                  Text('Agregar Foto del Perfil'),
                ],
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Nombre',
              ),
            ),
            const SizedBox(height: 3.0),
            TextFormField(
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Edad',
              ),
            ),
            const SizedBox(height: 5.0),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Agregar peso (kg)',
              ),
              items: <String>[
                '30-40 kg',
                '40-50 kg',
                '50-60 kg',
                '60-70 kg',
                '70-80 kg',
                '80-90 kg',
                '90-100 kg',
                '100-110 kg',
                // Agrega más opciones según sea necesario
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Add functionality when a weight option is selected
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add functionality to save changes
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                    255, 30, 226, 233), // Color de fondo rosa
              ),
              child: const Text('Guardar Cambios'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.blue,
        onTap: (int index) {
          if (index == 0) {
            // Navegar a la página de inicio si se presiona "Inicio"
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProfilePage()),
            );
          }
        },
      ),
    );
  }
}
