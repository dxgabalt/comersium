import 'package:comersium/pages/profile_business/reviewSummary_business_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_google_map.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'profile_business_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ProfileBusinessWidget extends StatefulWidget {
  const ProfileBusinessWidget({
    super.key,
    required this.businessData,
  });

  final CommerceRecord? businessData;

  @override
  State<ProfileBusinessWidget> createState() => _ProfileBusinessWidgetState();
}

class _ProfileBusinessWidgetState extends State<ProfileBusinessWidget> {
  late ProfileBusinessModel _model;
  late YoutubePlayerController _youtubeController;
  TextEditingController? _commentController;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileBusinessModel());
    _model.textController ??= TextEditingController();
    _commentController = TextEditingController();

    _model.textFieldFocusNode ??= FocusNode();

    _youtubeController = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
        widget.businessData?.videoURL ?? '',
      )!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();
    _youtubeController.dispose();
    _commentController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: valueOrDefault<Color>(
            widget.businessData?.color,
            Colors.white,
          ),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30.0,
            borderWidth: 1.0,
            buttonSize: 60.0,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: Color.fromARGB(255, 223, 223, 223),
              size: 30.0,
            ),
            onPressed: () async {
              context.pushNamed('searchComersiums');
            },
          ),
          title: Text(
            valueOrDefault<String>(
              widget.businessData?.name,
              'Business Name',
            ),
            style: FlutterFlowTheme.of(context).headlineMedium.override(
                  fontFamily: 'Outfit',
                  color: const Color.fromARGB(255, 223, 223, 223),
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          centerTitle: false,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Imagen de portada y perfil
                SizedBox(
                  height: 220.0, // Altura total del contenedor
                  child: Stack(
                    children: [
                      // Imagen de portada (background)
                      Positioned.fill(
                        child: Image.network(
                          widget.businessData!.coverPhoto,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit
                              .cover, // Hace que la imagen cubra todo el espacio
                        ),
                      ),
                      // Imagen de perfil (Logo)
                      Align(
                        alignment: const AlignmentDirectional(-0.85,
                            0.0), // Posiciona la imagen más a la izquierda
                        child: Material(
                          color: Colors.transparent,
                          elevation: 6.0, // Añade sombra para darle profundidad
                          shape: const CircleBorder(),
                          child: Container(
                            width:
                                130.0, // Tamaño de la imagen circular de perfil
                            height: 130.0,
                            decoration: const BoxDecoration(
                              color: Colors
                                  .white, // Fondo blanco alrededor de la imagen
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: Image.network(
                                widget.businessData!.profilePhoto,
                                width: 130.0,
                                height: 130.0,
                                fit: BoxFit
                                    .cover, // Hace que la imagen llene el círculo
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Contenedor con fondo accent3 y bordes redondeados
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(
                      16.0, 32.0, 16.0, 32.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0), // Espaciado interno
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .accent2
                          .withOpacity(0.5), // Fondo accent3
                      borderRadius: BorderRadius.circular(
                          15.0), // Bordes redondeados de 15 píxeles
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Información del negocio
                        Center(
                          child: Text(
                            valueOrDefault<String>(
                              widget.businessData?.name,
                              'Business Name',
                            ),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: const Color(0xFF15161E),
                                  fontSize: 35.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),

                        // Descripción del negocio
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 4.0, 0.0, 4.0),
                            child: Text(
                              valueOrDefault<String>(
                                widget.businessData?.description,
                                'Descripción sobre negocio',
                              ),
                              textAlign: TextAlign.start,
                              style: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Plus Jakarta Sans',
                                    color: const Color(0xFF606A85),
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ),
                        ),

                        // Iconos sociales
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 16.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: widget.businessData?.color,
                                icon: FaIcon(
                                  FontAwesomeIcons.facebookF,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  await launchURL(
                                      widget.businessData!.facebook);
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: widget.businessData?.color,
                                icon: FaIcon(
                                  FontAwesomeIcons.instagram,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  await launchURL(
                                      widget.businessData!.instagram);
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: widget.businessData?.color,
                                icon: Icon(
                                  Icons.phone,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  await launchUrl(Uri(
                                    scheme: 'tel',
                                    path: widget.businessData!.phone,
                                  ));
                                },
                              ),
                              FlutterFlowIconButton(
                                borderRadius: 20.0,
                                borderWidth: 1.0,
                                buttonSize: 40.0,
                                fillColor: widget.businessData?.color,
                                icon: Icon(
                                  Icons.email,
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  size: 24.0,
                                ),
                                onPressed: () async {
                                  await launchUrl(Uri(
                                      scheme: 'mailto',
                                      path: widget.businessData!.email,
                                      query: {
                                        'subject': 'Cliente interesado',
                                      }
                                          .entries
                                          .map((MapEntry<String, String> e) =>
                                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                                          .join('&')));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Carrusel de imágenes
                if (widget.businessData!.serviceImages.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 32.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(
                          0.0, 16.0, 0.0, 16.0), // Espaciado interno
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .accent2
                            .withOpacity(0.5), // Fondo accent3
                        borderRadius:
                            BorderRadius.circular(15.0), // Bordes redondeados
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título del carrusel
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 0, 0,
                                16.0), // Espacio entre título y carrusel
                            child: Text(
                              'Destacados',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context)
                                        .darkBackground,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),

                          // Carrusel de imágenes
                          CarouselSlider(
                            options: CarouselOptions(
                              height: 450.0,
                              autoPlay: true,
                              enlargeCenterPage: true,
                              viewportFraction: 0.9,
                              aspectRatio: 16 / 9,
                              autoPlayInterval: const Duration(seconds: 3),
                            ),
                            items:
                                widget.businessData!.serviceImages.map((image) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    width: MediaQuery.of(context).size.width,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.0),
                                      child: Image.network(
                                        image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 32.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0), // Espacio interno
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .accent2
                          .withOpacity(0.5), // Fondo accent3
                      borderRadius:
                          BorderRadius.circular(15.0), // Bordes redondeados
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título "Nuestro Catálogo"
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom:
                                  16.0), // Espacio inferior para separar del GridView
                          child: Text(
                            'Nuestro Catálogo',
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context)
                                      .darkBackground,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),

                        // GridView de imágenes
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.0,
                            mainAxisSpacing: 12.0,
                            childAspectRatio: 0.6,
                          ),
                          itemCount: widget.businessData!.serviceImages.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      child: Container(
                                        color: Colors.black,
                                        child: Image.network(
                                          widget.businessData!
                                              .serviceImages[index],
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(28.0),
                                child: Image.network(
                                  widget.businessData!.serviceImages[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                // Youtube player
                if (widget.businessData!.videoURL.isNotEmpty)
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        16.0, 0.0, 16.0, 32.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(
                          16.0, 16.0, 16.0, 16.0), // Espaciado interno
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context)
                            .accent2
                            .withOpacity(0.5), // Fondo accent3
                        borderRadius:
                            BorderRadius.circular(15.0), // Bordes redondeados
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título del video
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 0, 0,
                                16.0), // Espacio entre título y video
                            child: Text(
                              'Video promocional',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: FlutterFlowTheme.of(context)
                                        .darkBackground,
                                    fontSize: 24.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),

                          // Reproductor de video
                          YoutubePlayer(
                            controller: _youtubeController,
                            showVideoProgressIndicator: true,
                            topActions: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios_new),
                                onPressed: () {
                                  _youtubeController.seekTo(
                                    _youtubeController.value.position -
                                        const Duration(seconds: 5),
                                  );
                                },
                              ),
                              const Spacer(),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios),
                                onPressed: () {
                                  _youtubeController.seekTo(
                                    _youtubeController.value.position +
                                        const Duration(seconds: 5),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 12.0, 0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0), // Espaciado interno
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context)
                          .accent2
                          .withOpacity(0.5), // Fondo accent3
                      borderRadius:
                          BorderRadius.circular(15.0), // Bordes redondeados
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 4.0),
                          child: Text(
                            FFLocalizations.of(context)
                                .getText('5fl6ai1t' /* Ubicanos */),
                            style: FlutterFlowTheme.of(context)
                                .headlineSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context)
                                      .darkBackground,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 12.0),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on, // Icono de ubicación
                                color: Color(0xFF606A85),
                                size: 20.0,
                              ),
                              const SizedBox(
                                  width: 8.0), // Espacio entre ícono y texto
                              Expanded(
                                child: Text(
                                  valueOrDefault<String>(
                                    widget.businessData?.address,
                                    'Usa google Maps para encontrarnos',
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .labelSmall
                                      .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF606A85),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 300.0,
                          decoration: BoxDecoration(
                            color: Colors.white, // Fondo del mapa
                            borderRadius: BorderRadius.circular(
                                12.0), // Bordes redondeados
                          ),
                          child: Builder(builder: (context) {
                            final googleMapMarker = widget.businessData;
                            return FlutterFlowGoogleMap(
                              controller: _model.googleMapsController,
                              onCameraIdle: (latLng) =>
                                  _model.googleMapsCenter = latLng,
                              initialLocation: _model.googleMapsCenter ??=
                                  widget.businessData!.ubication!,
                              markers: [
                                if (googleMapMarker != null)
                                  FlutterFlowMarker(
                                    googleMapMarker.reference.path,
                                    googleMapMarker.ubication!,
                                  ),
                              ],
                              markerColor: GoogleMarkerColor.red,
                              mapType: MapType.normal,
                              style: GoogleMapStyle.silver,
                              initialZoom: 14.0,
                              allowInteraction: true,
                              allowZoom: true,
                              showZoomControls: true,
                              showLocation: false,
                              showCompass: false,
                              showMapToolbar: false,
                              showTraffic: false,
                              centerMapOnMarkerTap: true,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ),

                // Comentarios y sección final
                Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 12.0, 0.0, 0.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            ReviewSummary(
                                commerceRef: widget.businessData!.reference),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 12.0),
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: OutlinedButton(
                                          onPressed: () {
                                            _openReviewModal(
                                                context, widget.businessData);
                                          },
                                          style: OutlinedButton.styleFrom(
                                              side: const BorderSide(
                                                  color: Colors.black,
                                                  width: 2), // Bordes negros
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(
                                                    30.0), // Bordes totalmente redondeados
                                              ),
                                              backgroundColor:
                                                  Colors.transparent,
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                      48.0,
                                                      16.0,
                                                      48.0,
                                                      16.0) // Fondo transparente
                                              ),
                                          child: Text(
                                            FFLocalizations.of(context).getText(
                                              '0z1j1v5v' /* Escribe una opinion */,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyLarge
                                                .override(
                                                  fontFamily:
                                                      'Plus Jakarta Sans',
                                                  color:
                                                      const Color(0xFF15161E),
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  12.0, 0.0, 12.0, 12.0),
                              child: StreamBuilder<List<ReviewRecord>>(
                                stream: queryReviewRecord(
                                  parent: widget.businessData?.reference,
                                  queryBuilder: (reviewRecord) => reviewRecord
                                      .where('commerce_id',
                                          isEqualTo:
                                              widget.businessData?.reference)
                                      .orderBy('created_at', descending: true)
                                      .limit(5),
                                ),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Center(
                                      child: SpinKitPumpingHeart(
                                        color: Colors.greenAccent,
                                        size: 40.0,
                                      ),
                                    );
                                  }
                                  List<ReviewRecord> reviewList =
                                      snapshot.data!;
                                  return ListView.builder(
                                    padding: EdgeInsets.zero,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: reviewList.length,
                                    itemBuilder: (context, index) {
                                      final review = reviewList[index];
                                      return StreamBuilder<UsersRecord>(
                                        stream: UsersRecord.getDocument(
                                            review.userId!),
                                        builder: (context, userSnapshot) {
                                          if (!userSnapshot.hasData) {
                                            return const SizedBox.shrink();
                                          }
                                          final user = userSnapshot.data!;
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF5F5F5),
                                                borderRadius:
                                                    BorderRadius.circular(12.0),
                                              ),
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          user.displayName,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Lexend',
                                                                color: const Color(
                                                                    0xFF15161E),
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                        ),
                                                      ),
                                                      Text(
                                                        dateTimeFormat(
                                                            'MMM d, yyyy',
                                                            review.createdAt!),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodySmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Lexend',
                                                                  color: const Color(
                                                                      0xFF9E9E9E),
                                                                ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(height: 8),
                                                  Row(
                                                    children: List.generate(5,
                                                        (index) {
                                                      return Icon(
                                                        index < review.rating
                                                            ? Icons.star
                                                            : Icons.star_border,
                                                        size: 16,
                                                        color: Colors.amber,
                                                      );
                                                    }),
                                                  ),
                                                  const SizedBox(height: 10),
                                                  Text(
                                                    review.comment,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodySmall
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 0, 0, 0),
                                                          fontSize: 16,
                                                        ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: OutlinedButton(
                                onPressed: () {
                                  _openViewMoreCommentsModal(
                                      context, widget.businessData);
                                },
                                style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.black,
                                        width: 2), // Bordes negros
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          30.0), // Bordes totalmente redondeados
                                    ),
                                    backgroundColor: Colors.transparent,
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            48.0,
                                            16.0,
                                            48.0,
                                            16.0) // Fondo transparente
                                    ),
                                child: Text(
                                  'Ver más opiniones',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyLarge
                                      .override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: const Color(0xFF15161E),
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 50.0, bottom: 10.0),
                              child: Text(
                                FFLocalizations.of(context).getText(
                                  'gnoogxc2' /* COMERSIUM™ */,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Lexend',
                                      color: FlutterFlowTheme.of(context)
                                          .alternate,
                                      fontSize: 26.0,
                                      letterSpacing: 8.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Método para abrir el modal con más opiniones
// Método para abrir el modal con más opiniones
void _openViewMoreCommentsModal(
    BuildContext context, CommerceRecord? businessData) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black87,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height *
                  0.75, // Ajusta la altura para que no ocupe toda la pantalla
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      'Todas las opiniones',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: StreamBuilder<List<ReviewRecord>>(
                      stream: queryReviewRecord(
                        parent: businessData?.reference,
                        queryBuilder: (reviewRecord) => reviewRecord
                            .where('commerce_id',
                                isEqualTo: businessData?.reference)
                            .orderBy('created_at', descending: true),
                      ),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        final reviews = snapshot.data!;
                        return ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            final review = reviews[index];
                            return StreamBuilder<UsersRecord>(
                              stream: UsersRecord.getDocument(review.userId!),
                              builder: (context, userSnapshot) {
                                if (!userSnapshot.hasData) {
                                  return const SizedBox.shrink();
                                }
                                final user = userSnapshot.data!;
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF5F5F5),
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                user.displayName,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Lexend',
                                                          color: const Color(
                                                              0xFF15161E),
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                              ),
                                            ),
                                            Text(
                                              dateTimeFormat('MMM d, yyyy',
                                                  review.createdAt!),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodySmall
                                                  .override(
                                                    fontFamily: 'Lexend',
                                                    color:
                                                        const Color(0xFF9E9E9E),
                                                  ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          children: List.generate(5, (index) {
                                            return Icon(
                                              index < review.rating
                                                  ? Icons.star
                                                  : Icons.star_border,
                                              size: 16,
                                              color: Colors.amber,
                                            );
                                          }),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          review.comment,
                                          style: FlutterFlowTheme.of(context)
                                              .bodySmall
                                              .override(
                                                fontFamily: 'Lexend',
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 16,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}

// Método para abrir el modal
void _openReviewModal(BuildContext context, CommerceRecord? businessData) {
  int selectedRating = 0; // Mantiene la calificación seleccionada
  TextEditingController commentController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.black87,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Deja tu opinión',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Tu opinión es muy importante para nosotros',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    '¿Cómo valorarías la experiencia?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          index < selectedRating
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 40,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedRating =
                                index + 1; // Asigna la calificación
                          });
                        },
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: commentController,
                  decoration: InputDecoration(
                    hintText: 'Escribe tu comentario aquí...',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  maxLines: 4,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    // Subir la calificación y el comentario a Firebase
                    final comment = commentController.text;

                    if (comment.isNotEmpty && selectedRating > 0) {
                      // Asegúrate de que estás agregando el comentario a la subcolección correcta
                      await ReviewRecord.createDoc(businessData!.reference)
                          .set(createReviewRecordData(
                        commerceId: businessData.reference,
                        userId: currentUserReference,
                        comment: comment,
                        createdAt: getCurrentTimestamp,
                        rating: selectedRating,
                      ));

                      // Cierra el modal y llama a setState en el widget padre para actualizar la lista
                      Navigator.pop(context);
                      setState(
                          () {}); // Forzar la actualización del widget para mostrar la nueva reseña
                    } else {
                      // Muestra un error si el comentario o la calificación no se han dado
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Debes ingresar una calificación y un comentario.'),
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Center(child: Text('Enviar mensaje')),
                ),
                SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
              ],
            ),
          );
        },
      );
    },
  );
}
