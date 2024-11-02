import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class CommerceRecord extends FirestoreRecord {
  CommerceRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  bool hasName() => _name != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  bool hasEmail() => _email != null;

  // "phone" field.
  String? _phone;
  String get phone => _phone ?? '';
  bool hasPhone() => _phone != null;

  // "address" field.
  String? _address;
  String get address => _address ?? '';
  bool hasAddress() => _address != null;

  // "videoUrl" field.
  String? _videoURL;
  String get videoURL => _videoURL ?? '';
  bool hasVideoURL() => _videoURL != null;

  // "description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "website" field.
  String? _website;
  String get website => _website ?? '';
  bool hasWebsite() => _website != null;

  // "reviews" field.
  DocumentReference? _reviews;
  DocumentReference? get reviews => _reviews;
  bool hasReviews() => _reviews != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  // "service_images" field.
  List<String>? _serviceImages;
  List<String> get serviceImages => _serviceImages ?? const [];
  bool hasServiceImages() => _serviceImages != null;

  // "facebook" field.
  String? _facebook;
  String get facebook => _facebook ?? '';
  bool hasFacebook() => _facebook != null;

  // "instagram" field.
  String? _instagram;
  String get instagram => _instagram ?? '';
  bool hasInstagram() => _instagram != null;

  // "ubication" field.
  LatLng? _ubication;
  LatLng? get ubication => _ubication;
  bool hasUbication() => _ubication != null;

  // "tags" field.
  List<String>? _tags;
  List<String> get tags => _tags ?? const [];
  bool hasTags() => _tags != null;

  // "cover_photo" field.
  String? _coverPhoto;
  String get coverPhoto => _coverPhoto ?? '';
  bool hasCoverPhoto() => _coverPhoto != null;

  // "profile_photo" field.
  String? _profilePhoto;
  String get profilePhoto => _profilePhoto ?? '';
  bool hasProfilePhoto() => _profilePhoto != null;

  // "category" field.
  String? _category;
  String get category => _category ?? '';
  bool hasCategory() => _category != null;

  // "color" field.
  Color? _color;
  Color? get color => _color;
  bool hasColor() => _color != null;

  // "userRef" field.
  DocumentReference? _userRef;
  DocumentReference? get userRef => _userRef;
  bool hasUserRef() => _userRef != null;

  void _initializeFields() {
    _name = snapshotData['name'] as String?;
    _email = snapshotData['email'] as String?;
    _phone = snapshotData['phone'] as String?;
    _address = snapshotData['address'] as String?;
    _description = snapshotData['description'] as String?;
    _website = snapshotData['website'] as String?;
    _reviews = snapshotData['reviews'] as DocumentReference?;
    _createdAt = snapshotData['created_at'] as DateTime?;
    _serviceImages = getDataList(snapshotData['service_images']);
    _videoURL = snapshotData['videoURL'] as String?;
    _facebook = snapshotData['facebook'] as String?;
    _instagram = snapshotData['instagram'] as String?;
    _ubication = snapshotData['ubication'] as LatLng?;
    _coverPhoto = snapshotData['cover_photo'] as String?;
    _profilePhoto = snapshotData['profile_photo'] as String?;
    _category = snapshotData['category'] as String?;
    _color = getSchemaColor(snapshotData['color']);
    _userRef = snapshotData['userRef'] as DocumentReference?;
    _tags = (snapshotData['tags'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList();
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Commerce');

  static Stream<CommerceRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => CommerceRecord.fromSnapshot(s));

  static Future<CommerceRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => CommerceRecord.fromSnapshot(s));

  static CommerceRecord fromSnapshot(DocumentSnapshot snapshot) =>
      CommerceRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static CommerceRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      CommerceRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'CommerceRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is CommerceRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createCommerceRecordData({
  String? name,
  String? email,
  String? phone,
  String? address,
  String? description,
  String? website,
  DocumentReference? reviews,
  DateTime? createdAt,
  String? facebook,
  String? instagram,
  LatLng? ubication,
  String? coverPhoto,
  String? profilePhoto,
  String? category,
  Color? color,
  DocumentReference? userRef,
  String? videoURL,
  List<String>? tags,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'description': description,
      'website': website,
      'reviews': reviews,
      'created_at': createdAt,
      'facebook': facebook,
      'instagram': instagram,
      'ubication': ubication,
      'cover_photo': coverPhoto,
      'profile_photo': profilePhoto,
      'category': category,
      'color': color,
      'userRef': userRef,
      'videoURL': videoURL,
      'tags': tags,
    }.withoutNulls,
  );

  return firestoreData;
}

class CommerceRecordDocumentEquality implements Equality<CommerceRecord> {
  const CommerceRecordDocumentEquality();

  @override
  bool equals(CommerceRecord? e1, CommerceRecord? e2) {
    const listEquality = ListEquality();
    return e1?.name == e2?.name &&
        e1?.email == e2?.email &&
        e1?.phone == e2?.phone &&
        e1?.address == e2?.address &&
        e1?.description == e2?.description &&
        e1?.website == e2?.website &&
        e1?.reviews == e2?.reviews &&
        e1?.createdAt == e2?.createdAt &&
        listEquality.equals(e1?.serviceImages, e2?.serviceImages) &&
        e1?.facebook == e2?.facebook &&
        e1?.instagram == e2?.instagram &&
        e1?.ubication == e2?.ubication &&
        e1?.coverPhoto == e2?.coverPhoto &&
        e1?.profilePhoto == e2?.profilePhoto &&
        e1?.category == e2?.category &&
        e1?.color == e2?.color &&
        e1?.userRef == e2?.userRef &&
        e1?.videoURL == e2?.videoURL &&
        listEquality.equals(e1?.tags, e2?.tags);
  }

  @override
  int hash(CommerceRecord? e) => const ListEquality().hash([
        e?.name,
        e?.email,
        e?.phone,
        e?.address,
        e?.description,
        e?.website,
        e?.reviews,
        e?.createdAt,
        e?.serviceImages,
        e?.facebook,
        e?.instagram,
        e?.ubication,
        e?.coverPhoto,
        e?.profilePhoto,
        e?.category,
        e?.color,
        e?.userRef,
        e?.videoURL,
        e?.tags,
      ]);

  @override
  bool isValidKey(Object? o) => o is CommerceRecord;
}
