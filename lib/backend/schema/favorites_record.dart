import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class FavoritesRecord extends FirestoreRecord {
  FavoritesRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "favorite_id" field.
  String? _favoriteId;
  String get favoriteId => _favoriteId ?? '';
  bool hasFavoriteId() => _favoriteId != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "commerce_id" field.
  DocumentReference? _commerceId;
  DocumentReference? get commerceId => _commerceId;
  bool hasCommerceId() => _commerceId != null;

  DocumentReference get parentReference => reference.parent.parent!;

  void _initializeFields() {
    _favoriteId = snapshotData['favorite_id'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _commerceId = snapshotData['commerce_id'] as DocumentReference?;
  }

  static Query<Map<String, dynamic>> collection([DocumentReference? parent]) =>
      parent != null
          ? parent.collection('favorites')
          : FirebaseFirestore.instance.collectionGroup('favorites');

  static DocumentReference createDoc(DocumentReference parent, {String? id}) =>
      parent.collection('favorites').doc(id);

  static Stream<FavoritesRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => FavoritesRecord.fromSnapshot(s));

  static Future<FavoritesRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => FavoritesRecord.fromSnapshot(s));

  static FavoritesRecord fromSnapshot(DocumentSnapshot snapshot) =>
      FavoritesRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static FavoritesRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      FavoritesRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'FavoritesRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is FavoritesRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createFavoritesRecordData({
  String? favoriteId,
  DocumentReference? userId,
  DocumentReference? commerceId,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'favorite_id': favoriteId,
      'user_id': userId,
      'commerce_id': commerceId,
    }.withoutNulls,
  );

  return firestoreData;
}

class FavoritesRecordDocumentEquality implements Equality<FavoritesRecord> {
  const FavoritesRecordDocumentEquality();

  @override
  bool equals(FavoritesRecord? e1, FavoritesRecord? e2) {
    return e1?.favoriteId == e2?.favoriteId &&
        e1?.userId == e2?.userId &&
        e1?.commerceId == e2?.commerceId;
  }

  @override
  int hash(FavoritesRecord? e) =>
      const ListEquality().hash([e?.favoriteId, e?.userId, e?.commerceId]);

  @override
  bool isValidKey(Object? o) => o is FavoritesRecord;
}
