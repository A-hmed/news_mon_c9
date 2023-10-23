import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_mon_c9/data/model/sources_response.dart';

class OfflineDataSource {
  void saveSources(String categoryId, SourcesResponse sourcesResponse) {
    CollectionReference tabsCollection =
        FirebaseFirestore.instance.collection("tabs");
    DocumentReference docRef = tabsCollection.doc(categoryId);
    docRef.set(sourcesResponse.toJson());
  }

  Future<SourcesResponse?> getSources(String categoryId) async {
    CollectionReference tabsCollection =
        FirebaseFirestore.instance.collection("tabs");
    DocumentReference documentReference = tabsCollection.doc(categoryId);

    DocumentSnapshot snapshot = await documentReference.get();
    if (snapshot.data() == null) return null;

    SourcesResponse sourcesResponse = SourcesResponse.fromJson(snapshot.data());
    return sourcesResponse;
  }
}
