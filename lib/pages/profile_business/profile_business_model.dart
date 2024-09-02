import '/components/review_widget.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'profile_business_widget.dart' show ProfileBusinessWidget;
import 'package:flutter/material.dart';

class ProfileBusinessModel extends FlutterFlowModel<ProfileBusinessWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for PageView widget (replacement for Carousel).
  late final PageController pageController;
  int carouselCurrentIndex = 1;

  // State field(s) for GoogleMap widget.
  LatLng? googleMapsCenter;
  final googleMapsController = Completer<GoogleMapController>();
  // Model for review component.
  late ReviewModel reviewModel;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {
    reviewModel = createModel(context, () => ReviewModel());

    // Initialize the PageController
    pageController = PageController(initialPage: carouselCurrentIndex);
  }

  @override
  void dispose() {
    // Dispose of the PageController
    pageController.dispose();

    reviewModel.dispose();
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
