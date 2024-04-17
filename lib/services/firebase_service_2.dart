// ignore_for_file: non_constant_identifier_names, avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<List> getOdontologia() async {
  List Odontologia = [];

  CollectionReference CollectionReferenceOdontologia =
      db.collection('odontologia');

  QuerySnapshot queryOdontologia = await CollectionReferenceOdontologia.get();

  queryOdontologia.docs.forEach((documento) {
    Odontologia.add(documento.data());
  });

  return Odontologia;
}

Future<void> addOdontologia(
    String rating, String comment, String date, String time) async {
  await FirebaseFirestore.instance.collection("odontologia").add({
    'Calificacion': rating,
    'Comentario': comment,
    'Fecha': date,
    'Hora': time,
  });
}
