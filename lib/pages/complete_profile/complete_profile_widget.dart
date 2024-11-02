import 'package:comersium/pages/complete_profile/complete_profile_model.dart';

import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
// Asegúrate de importar Firestore

class CompleteProfileWidget extends StatefulWidget {
  const CompleteProfileWidget({super.key});

  @override
  State<CompleteProfileWidget> createState() => _CompleteProfileWidgetState();
}

class _CompleteProfileWidgetState extends State<CompleteProfileWidget> {
  late CompleteProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CompleteProfileModel());

    // Cargar la información del usuario autenticado
    final user = currentUser; // Obtiene el usuario autenticado
    _model.yourNameTextController =
        TextEditingController(text: user?.phoneNumber ?? '');
    _model.yourAgeTextController =
        TextEditingController(text: user?.phoneNumber ?? '');
    _model.yourTitleTextController =
        TextEditingController(text: user?.email ?? '');

    _model.yourNameFocusNode = FocusNode();
    _model.yourAgeFocusNode = FocusNode();
    _model.yourTitleFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primary,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).primary,
        automaticallyImplyLeading: false,
        title: Text(
          'Completar Perfil',
          style: FlutterFlowTheme.of(context).headlineSmall.override(
                fontFamily: 'Lexend',
                letterSpacing: 0.0,
              ),
        ),
        actions: const [],
        centerTitle: false,
        elevation: 0.0,
      ),
      body: Form(
        key: _model.formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Campos de texto para actualizar la información del perfil
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: TextFormField(
                  controller: _model.yourNameTextController,
                  focusNode: _model.yourNameFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Nombre',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondary,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        letterSpacing: 0.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: TextFormField(
                  controller: _model.yourAgeTextController,
                  focusNode: _model.yourAgeFocusNode,
                  decoration: InputDecoration(
                    labelText: 'Número de Teléfono',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondary,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend',
                      letterSpacing: 0.0,
                      color: FlutterFlowTheme.of(context).alternate),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 0.0),
                child: TextFormField(
                  controller: _model.yourTitleTextController,
                  focusNode: _model.yourTitleFocusNode,
                  enabled: false,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    filled: true,
                    fillColor: FlutterFlowTheme.of(context).secondary,
                    contentPadding: const EdgeInsetsDirectional.fromSTEB(
                        20.0, 24.0, 20.0, 24.0),
                  ),
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        letterSpacing: 0.0,
                        color: FlutterFlowTheme.of(context).alternate,
                      ),
                ),
              ),
              // Botón para actualizar la información del perfil
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                child: FFButtonWidget(
                  onPressed: () async {
                    final user = currentUser;

                    if (user != null) {
                      try {
                        // Opcional: Actualizar datos adicionales en Firestore si tienes un documento del usuario
                        final userDoc = FirebaseFirestore.instance
                            .collection('Users')
                            .doc(user.uid);
                        await userDoc.update({
                          'display_name': _model.yourNameTextController.text,
                          'phone_number': _model.yourAgeTextController.text,
                          'email': _model.yourTitleTextController.text,
                        });

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Perfil actualizado con éxito')),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Error al actualizar el perfil')),
                        );
                      }
                    }
                  },
                  text: 'Actualizar Perfil',
                  options: FFButtonOptions(
                    width: 230.0,
                    height: 50.0,
                    color: FlutterFlowTheme.of(context).alternate,
                    textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                          fontFamily: 'Lexend',
                          color: FlutterFlowTheme.of(context).textColor,
                          letterSpacing: 0.0,
                        ),
                    elevation: 3.0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
