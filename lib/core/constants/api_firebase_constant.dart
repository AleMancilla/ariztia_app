import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference products =
    FirebaseFirestore.instance.collection('Products');
CollectionReference business =
    FirebaseFirestore.instance.collection('Business');
CollectionReference ariztiaOrders =
    FirebaseFirestore.instance.collection('AriztiaOrders');
// CollectionReference articles = FirebaseFirestore.instance.collection('article');
// CollectionReference groups = FirebaseFirestore.instance.collection('group');
