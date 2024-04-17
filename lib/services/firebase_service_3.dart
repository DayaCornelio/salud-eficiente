// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getMedico() async {
  List Medico = [];

  CollectionReference CollectionReferenceMedico = db.collection('medico');

  QuerySnapshot queryMedico = await CollectionReferenceMedico.get();

  queryMedico.docs.forEach((documento) {
    Medico.add(documento.data());
  });

  return Medico;
}

Future<void> addMedico(
    String rating, String comment, String date, String time) async {
  await FirebaseFirestore.instance.collection("medico").add({
    'Calificacion': rating,
    'Comentario': comment,
    'Fecha': date,
    'Hora': time,
  });
}
