import 'package:cloud_firestore/cloud_firestore.dart';

class Nouvelle {
 final Timestamp date;
 final String nom;
 final String photo;
 final String texte;
 final DocumentReference reference;

 Nouvelle.fromMap(Map<String, dynamic> map, {this.reference})
     : assert(map['date'] != null),
       assert(map['nom'] != null),
       assert(map['photo'] != null),
       assert(map['texte'] != null),
       date = map['date'],
       nom = map['nom'],
       photo = map['photo'],
       texte = map['texte'];

 Nouvelle.fromSnapshot(DocumentSnapshot snapshot)
     : this.fromMap(snapshot.data, reference: snapshot.reference);

 @override
 String toString() => "Record<$date:$nom:$photo:$texte>";
}