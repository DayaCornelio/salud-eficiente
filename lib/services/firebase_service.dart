// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getDermatologia() async {
  List Dermatologia = [];

  CollectionReference CollectionReferenceDermatologia =
      db.collection('dermatologia');

  QuerySnapshot queryDermatologia = await CollectionReferenceDermatologia.get();

  queryDermatologia.docs.forEach((documento) {
    Dermatologia.add(documento.data());
  });

  return Dermatologia;
}

Future<void> addDermatologia(
    String rating, String comment, String date, String time) async {
  await FirebaseFirestore.instance.collection("dermatologia").add({
    'Calificacion': rating,
    'Comentario': comment,
    'Fecha': date,
    'Hora': time,
  });
}
