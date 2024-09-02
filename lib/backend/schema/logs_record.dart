import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class LogsRecord extends FirestoreRecord {
  LogsRecord._(
    super.reference,
    super.data,
  ) {
    _initializeFields();
  }

  // "log_id" field.
  String? _logId;
  String get logId => _logId ?? '';
  bool hasLogId() => _logId != null;

  // "user_id" field.
  DocumentReference? _userId;
  DocumentReference? get userId => _userId;
  bool hasUserId() => _userId != null;

  // "commerce_id" field.
  DocumentReference? _commerceId;
  DocumentReference? get commerceId => _commerceId;
  bool hasCommerceId() => _commerceId != null;

  // "message" field.
  String? _message;
  String get message => _message ?? '';
  bool hasMessage() => _message != null;

  // "level" field.
  List<String>? _level;
  List<String> get level => _level ?? const [];
  bool hasLevel() => _level != null;

  // "created_at" field.
  DateTime? _createdAt;
  DateTime? get createdAt => _createdAt;
  bool hasCreatedAt() => _createdAt != null;

  void _initializeFields() {
    _logId = snapshotData['log_id'] as String?;
    _userId = snapshotData['user_id'] as DocumentReference?;
    _commerceId = snapshotData['commerce_id'] as DocumentReference?;
    _message = snapshotData['message'] as String?;
    _level = getDataList(snapshotData['level']);
    _createdAt = snapshotData['created_at'] as DateTime?;
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('logs');

  static Stream<LogsRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => LogsRecord.fromSnapshot(s));

  static Future<LogsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => LogsRecord.fromSnapshot(s));

  static LogsRecord fromSnapshot(DocumentSnapshot snapshot) => LogsRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static LogsRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      LogsRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'LogsRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is LogsRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createLogsRecordData({
  String? logId,
  DocumentReference? userId,
  DocumentReference? commerceId,
  String? message,
  DateTime? createdAt,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'log_id': logId,
      'user_id': userId,
      'commerce_id': commerceId,
      'message': message,
      'created_at': createdAt,
    }.withoutNulls,
  );

  return firestoreData;
}

class LogsRecordDocumentEquality implements Equality<LogsRecord> {
  const LogsRecordDocumentEquality();

  @override
  bool equals(LogsRecord? e1, LogsRecord? e2) {
    const listEquality = ListEquality();
    return e1?.logId == e2?.logId &&
        e1?.userId == e2?.userId &&
        e1?.commerceId == e2?.commerceId &&
        e1?.message == e2?.message &&
        listEquality.equals(e1?.level, e2?.level) &&
        e1?.createdAt == e2?.createdAt;
  }

  @override
  int hash(LogsRecord? e) => const ListEquality().hash(
      [e?.logId, e?.userId, e?.commerceId, e?.message, e?.level, e?.createdAt]);

  @override
  bool isValidKey(Object? o) => o is LogsRecord;
}
