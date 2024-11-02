import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'interests_model.dart';
export 'interests_model.dart';
import 'dart:async';

class InterestsWidget extends StatefulWidget {
  const InterestsWidget({super.key});

  @override
  State<InterestsWidget> createState() => _InterestsWidgetState();
}

class _InterestsWidgetState extends State<InterestsWidget> {
  Color backgroundColor = Colors.white;
  Timer? _timer;
  late InterestsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => InterestsModel());
    backgroundColor = _determineBackgroundColor();
    _startTimer();

    // Cargar las categorías desde Firestore
    _loadCategories();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Color _determineBackgroundColor() {
    final currentHour = DateTime.now().hour;
    if (currentHour >= 6 && currentHour < 12) {
      return const Color.fromARGB(255, 29, 72, 92); // Mañana
    } else if (currentHour >= 12 && currentHour < 18) {
      return const Color.fromARGB(255, 95, 41, 73); // Tarde
    } else {
      return const Color.fromARGB(255, 58, 31, 77); // Noche
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      setState(() {
        backgroundColor = _determineBackgroundColor();
      });
    });
  }

  Future<void> _loadCategories() async {
    try {
      final snapshot =
          await FirebaseFirestore.instance.collection('Categories').get();
      if (mounted) {
        setState(() {
          categories =
              snapshot.docs.map((doc) => doc['name'] as String).toList();
        });
      }
    } catch (e) {
      print('Error loading categories: $e');
    }
  }

  Future<void> _saveInterests() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .update({
          'interestList': _model.selectedCategories,
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '¡Intereses guardados con éxito!',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend',
                      color: Colors.white,
                    ),
              ),
              backgroundColor: FlutterFlowTheme.of(context).primary,
            ),
          );

          // Redirigir a la pantalla LogoWall después de un pequeño retraso
          await Future.delayed(const Duration(seconds: 2));
          if (mounted) {
            context.pushNamed('LogoWall');
          }
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error al guardar los intereses. Por favor, inténtelo de nuevo.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend',
                      color: Colors.white,
                    ),
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _model.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildCategoryButton(String category) {
    final isSelected = _model.isCategorySelected(category);

    return GestureDetector(
      onTap: () {
        setState(() {
          _model.toggleCategory(category);
        });
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondary,
          borderRadius: BorderRadius.circular(30.0),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: FlutterFlowTheme.of(context)
                        .darkBackground
                        .withOpacity(0.5),
                    offset: const Offset(-4, -4),
                    blurRadius: 10.0,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(4, 4),
                    blurRadius: 10.0,
                  ),
                ]
              : [
                  const BoxShadow(
                    color: Colors.black12,
                    offset: Offset(4, 4),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                  BoxShadow(
                    color: backgroundColor.withOpacity(0.7),
                    offset: const Offset(-4, -4),
                    blurRadius: 15.0,
                    spreadRadius: 1.0,
                  ),
                ],
        ),
        child: Center(
          child: Text(
            category,
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Lexend',
                  color: isSelected
                      ? FlutterFlowTheme.of(context).darkBackground
                      : backgroundColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: categories.isEmpty
            ? Center(
                child: CircularProgressIndicator(
                  color: FlutterFlowTheme.of(context).primary,
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Selecciona 3 categorías que te interesen.',
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Lexend',
                            fontSize: 18.0,
                            color: FlutterFlowTheme.of(context).secondary,
                          ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150.0,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return _buildCategoryButton(categories[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: _model.selectedCategories.length == 3
                          ? () async {
                              await _saveInterests();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40.0, vertical: 15.0),
                        backgroundColor: _model.selectedCategories.length == 3
                            ? FlutterFlowTheme.of(context).alternate
                            : Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 10.0,
                        shadowColor: Colors.black.withOpacity(0.3),
                      ),
                      child: Text(
                        'Continuar',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).titleSmall.override(
                              fontFamily: 'Lexend',
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
