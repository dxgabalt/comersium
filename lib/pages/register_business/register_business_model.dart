import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import 'register_business_widget.dart' show RegisterBusinessWidget;
import 'package:flutter/material.dart';

class RegisterBusinessModel extends FlutterFlowModel<RegisterBusinessWidget> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  bool isDataUploading1 = false;
  FFUploadedFile uploadedLocalFile1 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl1 = '';

  bool isDataUploading2 = false;
  FFUploadedFile uploadedLocalFile2 =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl2 = '';

  // State field(s) for name widget.
  FocusNode? nameFocusNode;
  TextEditingController? nameTextController;
  String? Function(BuildContext, String?)? nameTextControllerValidator;
  String? _nameTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'ya01fixm' /* Nombre de usuario requerido */,
      );
    }

    return null;
  }

  // State field(s) for password widget.
  FocusNode? passwordFocusNode;
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(BuildContext, String?)? passwordTextControllerValidator;
  String? _passwordTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'telfb8y9' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for repeatPassowd widget.
  FocusNode? repeatPassowdFocusNode;
  TextEditingController? repeatPassowdTextController;
  late bool repeatPassowdVisibility;
  String? Function(BuildContext, String?)? repeatPassowdTextControllerValidator;
  String? _repeatPassowdTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'rfiyuw02' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for email widget.
  FocusNode? emailFocusNode;
  TextEditingController? emailTextController;
  String? Function(BuildContext, String?)? emailTextControllerValidator;
  String? _emailTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'exx7h2fi' /* Field is required */,
      );
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for phone-number widget.
  FocusNode? phoneNumberFocusNode;
  TextEditingController? phoneNumberTextController;
  String? Function(BuildContext, String?)? phoneNumberTextControllerValidator;
  String? _phoneNumberTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '1p5werki' /* Numero personal requerido */,
      );
    }

    return null;
  }

  // State field(s) for address widget.
  FocusNode? addressFocusNode;
  TextEditingController? addressTextController;
  String? Function(BuildContext, String?)? addressTextControllerValidator;
  String? _addressTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'telfb8y9' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for tags widget.
  FocusNode? tagsFocusNode;
  TextEditingController? tagsTextController;
  String? Function(BuildContext, String?)? tagsTextControllerValidator;
  String? _tagsTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'telfb8y9' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for videoURL widget.
  FocusNode? videoURLFocusNode;
  TextEditingController? videoURLTextController;
  String? Function(BuildContext, String?)? videoURLTextControllerValidator;
  String? _videoURLTextControllerValidator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'telfb8y9' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for description widget.
  FocusNode? descriptionFocusNode;
  TextEditingController? descriptionTextController;
  String? Function(BuildContext, String?)? descriptionTextControllerValidator;
  String? _descriptionTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '4pvb5cd8' /* Field is required */,
      );
    }

    return null;
  }

  Color? colorPicked;
  // State field(s) for Categorys widget.
  String? categorysValue;
  FormFieldController<String>? categorysValueController;
  // State field(s) for PlacePicker widget.
  FFPlace placePickerValue = const FFPlace();
  // State field(s) for facebook widget.
  FocusNode? facebookFocusNode1;
  TextEditingController? facebookTextController1;
  String? Function(BuildContext, String?)? facebookTextController1Validator;
  String? _facebookTextController1Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        '2zs90176' /* Field is required */,
      );
    }

    return null;
  }

  // State field(s) for facebook widget.
  FocusNode? facebookFocusNode2;
  TextEditingController? facebookTextController2;
  String? Function(BuildContext, String?)? facebookTextController2Validator;
  String? _facebookTextController2Validator(BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return FFLocalizations.of(context).getText(
        'acdy29rl' /* Field is required */,
      );
    }

    return null;
  }

  bool isDataUploading3 = false;
  List<FFUploadedFile> uploadedLocalFiles3 = [];
  List<String> uploadedFileUrls3 = [];

  @override
  void initState(BuildContext context) {
    nameTextControllerValidator = _nameTextControllerValidator;
    passwordVisibility = false;
    passwordTextControllerValidator = _passwordTextControllerValidator;
    repeatPassowdVisibility = false;
    repeatPassowdTextControllerValidator =
        _repeatPassowdTextControllerValidator;
    emailTextControllerValidator = _emailTextControllerValidator;
    phoneNumberTextControllerValidator = _phoneNumberTextControllerValidator;
    addressTextControllerValidator = _addressTextControllerValidator;
    tagsTextControllerValidator = _tagsTextControllerValidator;
    videoURLTextControllerValidator = _videoURLTextControllerValidator;
    descriptionTextControllerValidator = _descriptionTextControllerValidator;
    facebookTextController1Validator = _facebookTextController1Validator;
    facebookTextController2Validator = _facebookTextController2Validator;
  }

  @override
  void dispose() {
    nameFocusNode?.dispose();
    nameTextController?.dispose();

    passwordFocusNode?.dispose();
    passwordTextController?.dispose();

    repeatPassowdFocusNode?.dispose();
    repeatPassowdTextController?.dispose();

    emailFocusNode?.dispose();
    emailTextController?.dispose();

    phoneNumberFocusNode?.dispose();
    phoneNumberTextController?.dispose();

    addressFocusNode?.dispose();
    addressTextController?.dispose();

    descriptionFocusNode?.dispose();
    descriptionTextController?.dispose();

    facebookFocusNode1?.dispose();
    facebookTextController1?.dispose();

    facebookFocusNode2?.dispose();
    facebookTextController2?.dispose();

    videoURLFocusNode?.dispose();
    videoURLTextController?.dispose();
  }
}
