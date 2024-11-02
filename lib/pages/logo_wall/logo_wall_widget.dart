import 'dart:math';
import 'package:comersium/flutter_flow/flutter_flow_util.dart';
import 'package:comersium/pages/logo_wall/hexagonal_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'dart:async';
import '/backend/backend.dart';
import 'package:text_search/text_search.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';

class LogoWallWidget extends StatefulWidget {
  const LogoWallWidget({super.key});

  @override
  _LogoWallWidgetState createState() => _LogoWallWidgetState();
}

class _LogoWallWidgetState extends State<LogoWallWidget> {
  Offset _offset = Offset.zero; // Posición inicial del grid
  Color backgroundColor = Colors.white;
  Timer? _timer;

  late TextEditingController _textController;
  late FocusNode _textFieldFocusNode;
  String? _choiceChipsValue;
  late FormFieldController<List<String>> _choiceChipsValueController;
  List<CommerceRecord> _simpleSearchResults = [];

  @override
  void initState() {
    super.initState();
    backgroundColor = _determineBackgroundColor();
    _startTimer();

    _textController = TextEditingController();
    _textFieldFocusNode = FocusNode();

    // Inicializa el controlador del ChoiceChips
    _choiceChipsValueController = FormFieldController<List<String>>(
      _choiceChipsValue != null ? [_choiceChipsValue!] : [],
    );

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

  @override
  void dispose() {
    _timer?.cancel();
    _textController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  List<Offset> _generateHexagonalPositions(int count, double size) {
    List<Offset> positions = [];
    int rows = (sqrt(count)).ceil();

    for (int i = 0; i < count; i++) {
      int row = i ~/ rows;
      int col = i % rows;

      // Reducir la distancia entre los íconos ajustando los multiplicadores
      double x = col * size * 1; // Se redujo de 1.5 a 1.2
      double y = row * size * sqrt(2); // Se redujo de sqrt(3) a sqrt(2.5)

      if (col % 2 == 1) {
        y += size * sqrt(2) / 2;
      }

      positions.add(Offset(x, y));
    }

    return positions;
  }

  void _onCircleTap(CommerceRecord commerce) {
    context.pushNamed(
      'ProfileBusiness',
      queryParameters: {
        'businessData': serializeParam(commerce, ParamType.Document),
      }.withoutNulls,
      extra: <String, dynamic>{
        'businessData': commerce,
        kTransitionInfoKey: const TransitionInfo(
          hasTransition: true,
          transitionType: PageTransitionType.fade,
        ),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: _textController,
                focusNode: _textFieldFocusNode,
                onChanged: (_) => EasyDebounce.debounce(
                  '_textController',
                  const Duration(milliseconds: 2000),
                  () async {
                    // Realizar búsqueda tanto por nombre como por tags
                    await queryCommerceRecordOnce()
                        .then(
                          (records) => _simpleSearchResults = TextSearch(
                            records
                                .map(
                                  (record) => TextSearchItem.fromTerms(record, [
                                    record.name, // Búsqueda por nombre
                                    record
                                        .description, // Búsqueda por descripción (opcional)
                                    ...record.tags, // Búsqueda por etiquetas
                                  ]),
                                )
                                .toList(),
                          )
                              .search(_textController
                                  .text) // Búsqueda por texto ingresado
                              .map((r) => r.object)
                              .toList(),
                        )
                        .onError((_, __) => _simpleSearchResults = [])
                        .whenComplete(() => setState(() {}));
                  },
                ),
                decoration: InputDecoration(
                  labelText: 'Busca cualquier negocio...',
                  labelStyle: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Lexend',
                        color: FlutterFlowTheme.of(context).secondaryText,
                      ),
                  suffixIcon: Icon(
                    Icons.search_rounded,
                    color: FlutterFlowTheme.of(context).secondaryText,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: StreamBuilder<List<CategoriesRecord>>(
                  stream: queryCategoriesRecord(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final categories = snapshot.data!;
                    final choiceChipOptions = categories
                        .map((category) => ChipData(category.name))
                        .toList();
                    choiceChipOptions.insert(0, const ChipData('Todos'));

                    return FlutterFlowChoiceChips(
                      controller: _choiceChipsValueController,
                      options: choiceChipOptions,
                      onChanged: (val) {
                        setState(() {
                          _choiceChipsValue = val?.firstOrNull;
                        });
                      },
                      selectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).bodyMedium.override(
                                  fontFamily: 'Lexend',
                                  color: Colors.white,
                                ),
                        iconColor: Colors.white,
                        iconSize: 18.0,
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      unselectedChipStyle: ChipStyle(
                        backgroundColor: FlutterFlowTheme.of(context).alternate,
                        textStyle: FlutterFlowTheme.of(context)
                            .bodyMedium
                            .override(
                              fontFamily: 'Lexend',
                              color: FlutterFlowTheme.of(context).secondaryText,
                            ),
                        iconColor: FlutterFlowTheme.of(context).secondaryText,
                        iconSize: 18.0,
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      chipSpacing: 12.0,
                      multiselect: false,
                      alignment: WrapAlignment.start,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<CommerceRecord>>(
                stream: queryCommerceRecord(
                  queryBuilder: (commerceRecord) {
                    if (_choiceChipsValue != null &&
                        _choiceChipsValue != 'Todos') {
                      return commerceRecord.where('category',
                          isEqualTo: _choiceChipsValue);
                    }
                    return commerceRecord;
                  },
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final commerceList = _textController.text.isEmpty
                      ? snapshot.data!
                      : _simpleSearchResults;

                  if (commerceList.isEmpty) {
                    return const Center(
                      child: Text("No hay comercios disponibles."),
                    );
                  }

                  List<Offset> hexPositions = _generateHexagonalPositions(
                    commerceList.length,
                    130.0,
                  );

                  double maxX = hexPositions.map((pos) => pos.dx).reduce(max);
                  double minX = hexPositions.map((pos) => pos.dx).reduce(min);
                  double maxY = hexPositions.map((pos) => pos.dy).reduce(max);
                  double minY = hexPositions.map((pos) => pos.dy).reduce(min);

                  double gridWidth = maxX - minX + 40.0;
                  double gridHeight = maxY - minY + 160.0;

                  double horizontalLimit =
                      max((gridWidth - screenSize.width) / 2, 0);
                  double verticalLimit =
                      max((gridHeight - screenSize.height) / 2, 0);

                  Offset centerOffset = Offset(
                    (screenSize.width - gridWidth) / 2,
                    (screenSize.height - gridHeight) / 2,
                  );

                  return GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        Offset potentialOffset = _offset + details.delta;

                        _offset = Offset(
                          potentialOffset.dx
                              .clamp(-horizontalLimit, horizontalLimit),
                          potentialOffset.dy
                              .clamp(-verticalLimit, verticalLimit),
                        );
                      });
                    },
                    child: Stack(
                      children: [
                        CustomPaint(
                          painter: HexagonalPainter(
                            positions: hexPositions,
                            offset: _offset + centerOffset,
                            onTap: (index) => _onCircleTap(commerceList[index]),
                          ),
                          size: screenSize,
                        ),
                        ...hexPositions.asMap().entries.map((entry) {
                          int index = entry.key;
                          Offset pos = entry.value;
                          final commerce = commerceList[index];

                          double distanceFromCenter =
                              (pos + _offset + centerOffset).distance -
                                  screenSize.width / 5;

                          double scaleFactor =
                              1.0 - min(0.2, distanceFromCenter / 500);

                          return Positioned(
                            left: pos.dx +
                                _offset.dx +
                                centerOffset.dx -
                                80 * scaleFactor,
                            top: pos.dy +
                                _offset.dy +
                                centerOffset.dy -
                                80 * scaleFactor,
                            child: GestureDetector(
                              onTap: () => _onCircleTap(commerce),
                              child: AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 200),
                                child: ScaleAnimation(
                                  scale: scaleFactor,
                                  child: FadeInAnimation(
                                    child: SizedBox(
                                      width: 160 * scaleFactor,
                                      height: 160 * scaleFactor,
                                      child: ClipOval(
                                        child: Image.network(
                                          commerce.profilePhoto,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
