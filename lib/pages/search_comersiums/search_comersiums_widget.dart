import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_choice_chips.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/form_field_controller.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'search_comersiums_model.dart';
export 'search_comersiums_model.dart';

class SearchComersiumsWidget extends StatefulWidget {
  const SearchComersiumsWidget({super.key});

  @override
  State<SearchComersiumsWidget> createState() => _SearchComersiumsWidgetState();
}

class _SearchComersiumsWidgetState extends State<SearchComersiumsWidget> {
  late SearchComersiumsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Color _backgroundColor = const Color(0xFFF8F8F8); // Color predeterminado
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchComersiumsModel());

    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();

    // Inicializa el color de fondo según la hora actual
    _updateColors();
    _startTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      _updateColors(); // Actualizar los colores cada minuto
    });
  }

  void _updateColors() {
    final currentHour = DateTime.now().hour;

    setState(() {
      if (currentHour >= 6 && currentHour < 12) {
        // Mañana
        _backgroundColor = const Color.fromARGB(255, 29, 72, 92);
      } else if (currentHour >= 12 && currentHour < 18) {
        // Tarde
        _backgroundColor = const Color.fromARGB(255, 95, 41, 73);
      } else {
        // Noche
        _backgroundColor = const Color.fromARGB(255, 58, 31, 77);
      }
    });
  }

  @override
  void dispose() {
    _model.dispose();
    _timer?.cancel(); // Cancela el timer cuando se destruye el widget
    super.dispose();
  }

  Future<List<String>?> _getUserInterestList() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final userDoc = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();

    return userDoc.data()?['interestList']?.cast<String>();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return FutureBuilder<List<String>?>(
      future: _getUserInterestList(),
      builder: (context, interestListSnapshot) {
        if (!interestListSnapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondary,
            body: Center(
              child: SizedBox(
                width: 40.0,
                height: 40.0,
                child: SpinKitPumpingHeart(
                  color: FlutterFlowTheme.of(context).primary,
                  size: 40.0,
                ),
              ),
            ),
          );
        }

        final userInterestList = interestListSnapshot.data;

        return StreamBuilder<List<CommerceRecord>>(
          stream: queryCommerceRecord(
            queryBuilder: (commerceRecord) {
              if (_model.choiceChipsValue != null &&
                  _model.choiceChipsValue !=
                      FFLocalizations.of(context)
                          .getText('wis6xwfz' /* Todos */)) {
                return commerceRecord.where('category',
                    isEqualTo: _model.choiceChipsValue);
              }
              return commerceRecord;
            },
          ),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Scaffold(
                backgroundColor: FlutterFlowTheme.of(context).secondary,
                body: Center(
                  child: SizedBox(
                    width: 40.0,
                    height: 40.0,
                    child: SpinKitPumpingHeart(
                      color: FlutterFlowTheme.of(context).primary,
                      size: 40.0,
                    ),
                  ),
                ),
              );
            }
            List<CommerceRecord> searchComersiumsCommerceRecordList =
                snapshot.data!;

            // Filtrar y ordenar los negocios en base a las categorías de interés del usuario
            if (userInterestList != null && userInterestList.isNotEmpty) {
              searchComersiumsCommerceRecordList.sort((a, b) {
                final bool aIsInInterest =
                    userInterestList.contains(a.category);
                final bool bIsInInterest =
                    userInterestList.contains(b.category);

                if (aIsInInterest && !bIsInInterest) {
                  return -1;
                } else if (!aIsInInterest && bIsInInterest) {
                  return 1;
                } else {
                  return (b.createdAt ?? DateTime(0))
                      .compareTo(a.createdAt ?? DateTime(0));
                }
              });
            } else {
              searchComersiumsCommerceRecordList.sort((a, b) =>
                  (b.createdAt ?? DateTime(0))
                      .compareTo(a.createdAt ?? DateTime(0)));
            }

            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                key: scaffoldKey,
                backgroundColor: _backgroundColor, // Color dinámico de fondo
                appBar: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).primary,
                  automaticallyImplyLeading: false,
                  leading: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 10.0, 0.0, 10.0),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/Logo_(21).png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Align(
                    alignment: const AlignmentDirectional(0.0, 0.0),
                    child: Text(
                      FFLocalizations.of(context).getText(
                        '2h8nto9u' /* Comersium ™ */,
                      ),
                      textAlign: TextAlign.center,
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Lexend',
                            fontSize: 24.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  actions: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          0.0, 0.0, 16.0, 10.0),
                      child: FlutterFlowIconButton(
                        borderRadius: 20.0,
                        borderWidth: 1.0,
                        buttonSize: 40.0,
                        icon: FaIcon(
                          FontAwesomeIcons.solidBell,
                          color: FlutterFlowTheme.of(context).primaryText,
                          size: 24.0,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ),
                  ],
                  centerTitle: false,
                  elevation: 0.0,
                ),
                body: SafeArea(
                  top: true,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 8.0),
                            child: TextFormField(
                              controller: _model.textController,
                              focusNode: _model.textFieldFocusNode,
                              onChanged: (_) => EasyDebounce.debounce(
                                '_model.textController',
                                const Duration(milliseconds: 1000),
                                () async {
                                  // Realizar búsqueda
                                  await queryCommerceRecordOnce().then(
                                    (records) {
                                      // Incluimos name, description y tags para la búsqueda
                                      _model.simpleSearchResults = TextSearch(
                                        records
                                            .map(
                                              (record) => TextSearchItem(
                                                record,
                                                [
                                                  TextSearchItemTerm(
                                                      record.name),
                                                  TextSearchItemTerm(
                                                      record.description),
                                                  ...(record.tags.map((tag) =>
                                                      TextSearchItemTerm(
                                                          tag))), // Incluye los tags si existen
                                                ],
                                              ),
                                            )
                                            .toList(),
                                      )
                                          .search(_model.textController.text)
                                          .map((r) => r.object)
                                          .toList();
                                    },
                                  ).onError((_, __) {
                                    _model.simpleSearchResults = [];
                                    return null;
                                  }).whenComplete(() {
                                    setState(() {});
                                  });

                                  FFAppState().buscador = true;
                                  setState(() {});
                                },
                              ),
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                labelText: FFLocalizations.of(context).getText(
                                  'afwcuhz0' /* Busca cualquier negocio... */,
                                ),
                                suffixIcon: Icon(
                                  Icons.search_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 10.0),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 8.0, 0.0, 8.0),
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
                                          .map((category) =>
                                              ChipData(category.name))
                                          .toList();
                                      choiceChipOptions.insert(
                                          0,
                                          ChipData(FFLocalizations.of(context)
                                              .getText(
                                                  'wis6xwfz' /* Todos */)));

                                      return FlutterFlowChoiceChips(
                                        controller: _model
                                                .choiceChipsValueController ??=
                                            FormFieldController<List<String>>(
                                          _model.choiceChipsValue != null
                                              ? [_model.choiceChipsValue!]
                                              : [],
                                        ),
                                        options: choiceChipOptions,
                                        onChanged: (val) => setState(() {
                                          _model.choiceChipsValue =
                                              val?.firstOrNull;
                                          FFAppState().buscador =
                                              false; // Reinicia la búsqueda
                                        }),
                                        selectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primary,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .override(
                                                    fontFamily: 'Lexend',
                                                    color: Colors.white,
                                                  ),
                                          iconColor: Colors.white,
                                          iconSize: 18.0,
                                          elevation: 4.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        unselectedChipStyle: ChipStyle(
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .alternate,
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Lexend',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryText,
                                              ),
                                          iconColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryText,
                                          iconSize: 18.0,
                                          elevation: 2.0,
                                          borderRadius:
                                              BorderRadius.circular(16.0),
                                        ),
                                        chipSpacing: 12.0,
                                        multiselect: false,
                                        initialized:
                                            _model.choiceChipsValue != null,
                                        alignment: WrapAlignment.start,
                                      );
                                    },
                                  ),
                                ),
                              ]
                                  .addToStart(const SizedBox(width: 16.0))
                                  .addToEnd(const SizedBox(width: 16.0)),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            if (FFAppState().buscador == false)
                              Builder(
                                builder: (context) {
                                  final listadoEventos =
                                      searchComersiumsCommerceRecordList
                                          .map((e) => e)
                                          .toList();

                                  return ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      8.0,
                                      0,
                                      44.0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listadoEventos.length,
                                    itemBuilder:
                                        (context, listadoEventosIndex) {
                                      final listadoEventosItem =
                                          listadoEventos[listadoEventosIndex];
                                      return Container(
                                        width: double.infinity,
                                        decoration: const BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 12.0, 16.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              // Imagen del negocio sin bordes
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                  listadoEventosItem
                                                      .profilePhoto,
                                                  width: 100,
                                                  height: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              const SizedBox(width: 12.0),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // Nombre del negocio con color secundario
                                                    Text(
                                                      listadoEventosItem.name,
                                                      style:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleMedium
                                                              .copyWith(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                    ),
                                                    const SizedBox(height: 4.0),
                                                    // Botón para ver más información
                                                    FFButtonWidget(
                                                      onPressed: () async {
                                                        context.pushNamed(
                                                          'ProfileBusiness',
                                                          queryParameters: {
                                                            'businessData':
                                                                serializeParam(
                                                              listadoEventosItem,
                                                              ParamType
                                                                  .Document,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            'businessData':
                                                                listadoEventosItem,
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          },
                                                        );
                                                      },
                                                      text: FFLocalizations.of(
                                                              context)
                                                          .getText(
                                                        'h1t2bptp' /* Ver más */,
                                                      ),
                                                      icon: const Icon(
                                                        Icons.chevron_right,
                                                        size: 15.0,
                                                      ),
                                                      options: FFButtonOptions(
                                                        height: 40.0,
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(24.0,
                                                                0.0, 24.0, 0.0),
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        textStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.0,
                                                                ),
                                                        elevation: 3.0,
                                                        borderSide:
                                                            const BorderSide(
                                                          color: Colors
                                                              .transparent,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            if (FFAppState().buscador == true)
                              Builder(
                                builder: (context) {
                                  final listadoEvento = _model
                                      .simpleSearchResults
                                      .map((e) => e)
                                      .toList();

                                  return ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                      0,
                                      8.0,
                                      0,
                                      44.0,
                                    ),
                                    primary: false,
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: listadoEvento.length,
                                    itemBuilder: (context, listadoEventoIndex) {
                                      final listadoEventoItem =
                                          listadoEvento[listadoEventoIndex];
                                      return Container(
                                        width: 100.0,
                                        decoration: const BoxDecoration(),
                                        child: Padding(
                                          padding: const EdgeInsetsDirectional
                                              .fromSTEB(16.0, 12.0, 16.0, 12.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Container(
                                                width: 100.0,
                                                height: 100.0,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          12.0),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .accent3,
                                                    width: 2.0,
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(2.0),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    child: Image.network(
                                                      listadoEventoItem
                                                          .profilePhoto,
                                                      width: 120.0,
                                                      height: 120.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          12.0, 0.0, 0.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        listadoEventoItem.name,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyLarge
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .darkBackground,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                ),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      FFButtonWidget(
                                                        onPressed: () async {
                                                          context.pushNamed(
                                                            'ProfileBusiness',
                                                            queryParameters: {
                                                              'businessData':
                                                                  serializeParam(
                                                                listadoEventoItem,
                                                                ParamType
                                                                    .Document,
                                                              ),
                                                            }.withoutNulls,
                                                            extra: <String,
                                                                dynamic>{
                                                              'businessData':
                                                                  listadoEventoItem,
                                                              kTransitionInfoKey:
                                                                  const TransitionInfo(
                                                                hasTransition:
                                                                    true,
                                                                transitionType:
                                                                    PageTransitionType
                                                                        .fade,
                                                              ),
                                                            },
                                                          );
                                                        },
                                                        text:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          'u3dirz7w' /* Ver más */,
                                                        ),
                                                        icon: const Icon(
                                                          Icons.chevron_right,
                                                          size: 15.0,
                                                        ),
                                                        options:
                                                            FFButtonOptions(
                                                          height: 40.0,
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  24.0,
                                                                  0.0,
                                                                  24.0,
                                                                  0.0),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primary,
                                                          textStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .labelSmall
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: const Color(
                                                                        0xFFF8F8F8),
                                                                    fontSize:
                                                                        16.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                          elevation: 3.0,
                                                          borderSide:
                                                              const BorderSide(
                                                            color: Color(
                                                                0x58111417),
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                      ),
                                                    ].divide(const SizedBox(
                                                        height: 4.0)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
