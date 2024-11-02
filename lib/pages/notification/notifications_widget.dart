import 'package:comersium/flutter_flow/flutter_flow_model.dart';
import 'package:comersium/pages/notification/blocs/notifications/notifications_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'notifications_model.dart';
export 'notifications_model.dart';
import 'dart:async';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({super.key});

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  late NotificationsModel _model;
  Color backgroundColor = Colors.white;
  Timer? _timer;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    backgroundColor = _determineBackgroundColor();
    _startTimer();
    _model = createModel(context, () => NotificationsModel());

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
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
        automaticallyImplyLeading: false,
        title: context.select(
          (NotificationsBloc bloc) => Text('${bloc.state.status}'),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<NotificationsBloc>().requestPermission();
            },
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
        elevation: 2.0,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'No tienes nuevas notificaciones.',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Lexend',
                      fontSize: 18.0,
                    ),
              ),
              // Puedes agregar más elementos aquí para mostrar notificaciones.
            ],
          ),
        ),
      ),
    );
  }
}
