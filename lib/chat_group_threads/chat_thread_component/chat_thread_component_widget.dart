import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/chat_group_threads/chat_thread/chat_thread_widget.dart';
import '/chat_group_threads/empty_state_simple/empty_state_simple_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_media_display.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'chat_thread_component_model.dart';
export 'chat_thread_component_model.dart';

class ChatThreadComponentWidget extends StatefulWidget {
  const ChatThreadComponentWidget({
    super.key,
    this.chatRef,
  });

  final ChatsRecord? chatRef;

  @override
  State<ChatThreadComponentWidget> createState() =>
      _ChatThreadComponentWidgetState();
}

class _ChatThreadComponentWidgetState extends State<ChatThreadComponentWidget> {
  late ChatThreadComponentModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatThreadComponentModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).background,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: StreamBuilder<List<ChatMessagesRecord>>(
              stream: queryChatMessagesRecord(
                queryBuilder: (chatMessagesRecord) => chatMessagesRecord
                    .where(
                      'chat',
                      isEqualTo: widget.chatRef?.reference,
                    )
                    .orderBy('timestamp', descending: true),
                limit: 200,
              )..listen((snapshot) {
                  List<ChatMessagesRecord> listViewChatMessagesRecordList =
                      snapshot;
                  if (_model.listViewPreviousSnapshot != null &&
                      !const ListEquality(ChatMessagesRecordDocumentEquality())
                          .equals(listViewChatMessagesRecordList,
                              _model.listViewPreviousSnapshot)) {
                    () async {
                      if (!widget.chatRef!.lastMessageSeenBy
                          .contains(currentUserReference)) {
                        await widget.chatRef!.reference.update({
                          ...mapToFirestore(
                            {
                              'last_message_seen_by':
                                  FieldValue.arrayUnion([currentUserReference]),
                            },
                          ),
                        });
                      }

                      setState(() {});
                    }();
                  }
                  _model.listViewPreviousSnapshot = snapshot;
                }),
              builder: (context, snapshot) {
                // Customize what your widget looks like when it's loading.
                if (!snapshot.hasData) {
                  return Center(
                    child: SizedBox(
                      width: 40.0,
                      height: 40.0,
                      child: SpinKitPumpingHeart(
                        color: FlutterFlowTheme.of(context).primary,
                        size: 40.0,
                      ),
                    ),
                  );
                }
                List<ChatMessagesRecord> listViewChatMessagesRecordList =
                    snapshot.data!;
                if (listViewChatMessagesRecordList.isEmpty) {
                  return EmptyStateSimpleWidget(
                    icon: Icon(
                      Icons.forum_outlined,
                      color: FlutterFlowTheme.of(context).primary,
                      size: 90.0,
                    ),
                    title: 'No hay mensajes',
                    body: 'Envía un mensaje para comenzar la conversación.',
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(
                    0,
                    12.0,
                    0,
                    24.0,
                  ),
                  reverse: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewChatMessagesRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewChatMessagesRecord =
                        listViewChatMessagesRecordList[listViewIndex];
                    return Container(
                      decoration: const BoxDecoration(),
                      child: wrapWithModel(
                        model: _model.chatThreadModels.getModel(
                          listViewChatMessagesRecord.reference.id,
                          listViewIndex,
                        ),
                        updateCallback: () => setState(() {}),
                        updateOnChange: true,
                        child: ChatThreadWidget(
                          key: Key(
                            'Key9x7_${listViewChatMessagesRecord.reference.id}',
                          ),
                          chatMessagesRef: listViewChatMessagesRecord,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: FlutterFlowTheme.of(context).alternate,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3.0,
                  color: Color(0x33000000),
                  offset: Offset(
                    0.0,
                    -2.0,
                  ),
                )
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (_model.uploadedFileUrl != '')
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 12.0, 0.0, 0.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FlutterFlowMediaDisplay(
                                  path: _model.uploadedFileUrl,
                                  imageBuilder: (path) => ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: CachedNetworkImage(
                                      fadeInDuration:
                                          const Duration(milliseconds: 500),
                                      fadeOutDuration:
                                          const Duration(milliseconds: 500),
                                      imageUrl: path,
                                      width: 120.0,
                                      height: 100.0,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  videoPlayerBuilder: (path) =>
                                      FlutterFlowVideoPlayer(
                                    path: path,
                                    width: 300.0,
                                    autoPlay: false,
                                    looping: true,
                                    showControls: true,
                                    allowFullScreen: true,
                                    allowPlaybackSpeedMenu: false,
                                  ),
                                ),
                                Align(
                                  alignment:
                                      const AlignmentDirectional(-1.0, -1.0),
                                  child: FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).error,
                                    borderRadius: 20.0,
                                    borderWidth: 2.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    icon: Icon(
                                      Icons.delete_outline_rounded,
                                      color: FlutterFlowTheme.of(context).error,
                                      size: 24.0,
                                    ),
                                    onPressed: () async {
                                      setState(() {
                                        _model.isDataUploading = false;
                                        _model.uploadedLocalFile =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl = '';
                                      });
                                    },
                                  ),
                                ),
                              ]
                                  .divide(const SizedBox(width: 8.0))
                                  .addToStart(const SizedBox(width: 16.0))
                                  .addToEnd(const SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 0.0, 0.0),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: TextFormField(
                                    controller: _model.textController,
                                    focusNode: _model.textFieldFocusNode,
                                    onFieldSubmitted: (_) async {
                                      if (_model.formKey.currentState == null ||
                                          !_model.formKey.currentState!
                                              .validate()) {
                                        return;
                                      }
                                      // newChatMessage

                                      var chatMessagesRecordReference =
                                          ChatMessagesRecord.collection.doc();
                                      await chatMessagesRecordReference
                                          .set(createChatMessagesRecordData(
                                        user: currentUserReference,
                                        chat: widget.chatRef?.reference,
                                        text: _model.textController.text,
                                        timestamp: getCurrentTimestamp,
                                        image: _model.uploadedFileUrl,
                                      ));
                                      _model.newChatCopy = ChatMessagesRecord
                                          .getDocumentFromData(
                                              createChatMessagesRecordData(
                                                user: currentUserReference,
                                                chat: widget.chatRef?.reference,
                                                text:
                                                    _model.textController.text,
                                                timestamp: getCurrentTimestamp,
                                                image: _model.uploadedFileUrl,
                                              ),
                                              chatMessagesRecordReference);
                                      // clearUsers
                                      _model.lastSeenBy = [];
                                      // In order to add a single user reference to a list of user references we are adding our current user reference to a page state.
                                      //
                                      // We will then set the value of the user reference list from this page state.
                                      // addMyUserToList
                                      _model.addToLastSeenBy(
                                          currentUserReference!);
                                      // updateChatDocument

                                      await widget.chatRef!.reference.update({
                                        ...createChatsRecordData(
                                          lastMessageTime: getCurrentTimestamp,
                                          lastMessageSentBy:
                                              currentUserReference,
                                          lastMessage:
                                              _model.textController.text,
                                        ),
                                        ...mapToFirestore(
                                          {
                                            'last_message_seen_by':
                                                _model.lastSeenBy,
                                          },
                                        ),
                                      });
                                      setState(() {
                                        _model.textController?.clear();
                                      });
                                      setState(() {
                                        _model.isDataUploading = false;
                                        _model.uploadedLocalFile =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl = '';
                                      });

                                      _model.imagesUploaded = [];
                                      setState(() {});

                                      setState(() {});
                                    },
                                    autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    textInputAction: TextInputAction.send,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0.0,
                                          ),
                                      hintText:
                                          FFLocalizations.of(context).getText(
                                        'jweo5x6r' /* Start typing here... */,
                                      ),
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelSmall
                                          .override(
                                            fontFamily: 'Poppins',
                                            letterSpacing: 0.0,
                                          ),
                                      errorStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Lexend',
                                            color: FlutterFlowTheme.of(context)
                                                .error,
                                            fontSize: 12.0,
                                            letterSpacing: 0.0,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .accent3,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primary,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(24.0),
                                      ),
                                      contentPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              16.0, 16.0, 56.0, 16.0),
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Lexend',
                                          letterSpacing: 0.0,
                                        ),
                                    maxLines: 12,
                                    minLines: 1,
                                    cursorColor:
                                        FlutterFlowTheme.of(context).primary,
                                    validator: _model.textControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 6.0, 4.0),
                                  child: FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    borderRadius: 20.0,
                                    borderWidth: 1.0,
                                    buttonSize: 40.0,
                                    fillColor:
                                        FlutterFlowTheme.of(context).secondary,
                                    icon: Icon(
                                      Icons.send_rounded,
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      size: 20.0,
                                    ),
                                    onPressed: () async {
                                      final firestoreBatch =
                                          FirebaseFirestore.instance.batch();
                                      try {
                                        if (_model.formKey.currentState ==
                                                null ||
                                            !_model.formKey.currentState!
                                                .validate()) {
                                          return;
                                        }
                                        // newChatMessage

                                        var chatMessagesRecordReference =
                                            ChatMessagesRecord.collection.doc();
                                        firestoreBatch.set(
                                            chatMessagesRecordReference,
                                            createChatMessagesRecordData(
                                              user: currentUserReference,
                                              chat: widget.chatRef?.reference,
                                              text: _model.textController.text,
                                              timestamp: getCurrentTimestamp,
                                              image: _model.uploadedFileUrl,
                                            ));
                                        _model.newChat = ChatMessagesRecord
                                            .getDocumentFromData(
                                                createChatMessagesRecordData(
                                                  user: currentUserReference,
                                                  chat:
                                                      widget.chatRef?.reference,
                                                  text: _model
                                                      .textController.text,
                                                  timestamp:
                                                      getCurrentTimestamp,
                                                  image: _model.uploadedFileUrl,
                                                ),
                                                chatMessagesRecordReference);
                                        // clearUsers
                                        _model.lastSeenBy = [];
                                        // In order to add a single user reference to a list of user references we are adding our current user reference to a page state.
                                        //
                                        // We will then set the value of the user reference list from this page state.
                                        // addMyUserToList
                                        _model.addToLastSeenBy(
                                            currentUserReference!);
                                        // updateChatDocument

                                        firestoreBatch
                                            .update(widget.chatRef!.reference, {
                                          ...createChatsRecordData(
                                            lastMessageTime:
                                                getCurrentTimestamp,
                                            lastMessageSentBy:
                                                currentUserReference,
                                            lastMessage:
                                                _model.textController.text,
                                          ),
                                          ...mapToFirestore(
                                            {
                                              'last_message_seen_by':
                                                  _model.lastSeenBy,
                                            },
                                          ),
                                        });
                                        setState(() {
                                          _model.textController?.clear();
                                        });
                                        setState(() {
                                          _model.isDataUploading = false;
                                          _model.uploadedLocalFile =
                                              FFUploadedFile(
                                                  bytes:
                                                      Uint8List.fromList([]));
                                          _model.uploadedFileUrl = '';
                                        });

                                        _model.imagesUploaded = [];
                                        setState(() {});
                                      } finally {
                                        await firestoreBatch.commit();
                                      }

                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
