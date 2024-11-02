import '/flutter_flow/flutter_flow_util.dart';
import 'interests_widget.dart' show InterestsWidget;
import 'package:flutter/material.dart';

class InterestsModel extends FlutterFlowModel<InterestsWidget> {
  List<String> selectedCategories = [];

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {}

  bool isCategorySelected(String category) {
    return selectedCategories.contains(category);
  }

  void toggleCategory(String category) {
    if (isCategorySelected(category)) {
      selectedCategories.remove(category);
    } else {
      if (selectedCategories.length < 3) {
        selectedCategories.add(category);
      }
    }
  }
}
