import '/flutter_flow/flutter_flow_util.dart';
import 'login_page_widget.dart' show LoginPageWidget;
import 'package:flutter/material.dart';

class LoginPageModel extends FlutterFlowModel<LoginPageWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for emailAddress-login widget.
  FocusNode? emailAddressLoginFocusNode;
  TextEditingController? emailAddressLoginTextController;
  String? Function(BuildContext, String?)?
      emailAddressLoginTextControllerValidator;
  // State field(s) for password-login widget.
  FocusNode? passwordLoginFocusNode;
  TextEditingController? passwordLoginTextController;
  late bool passwordLoginVisibility;
  String? Function(BuildContext, String?)? passwordLoginTextControllerValidator;

  @override
  void initState(BuildContext context) {
    passwordLoginVisibility = false;
  }

  @override
  void dispose() {
    // Desvincula los FocusNodes antes de eliminarlos
    if (emailAddressLoginFocusNode?.hasFocus ?? false) {
      emailAddressLoginFocusNode?.unfocus();
    }
    if (passwordLoginFocusNode?.hasFocus ?? false) {
      passwordLoginFocusNode?.unfocus();
    }

    // Luego elimina los FocusNodes
    emailAddressLoginFocusNode?.dispose();
    passwordLoginFocusNode?.dispose();

    // Elimina los TextEditingControllers
    emailAddressLoginTextController?.dispose();
    passwordLoginTextController?.dispose();
  }
}
