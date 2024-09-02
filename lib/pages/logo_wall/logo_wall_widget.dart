import 'dart:math';
import 'package:comersium/pages/logo_wall/details_screen.dart';
import 'package:comersium/pages/logo_wall/hexagonal_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LogoWallWidget extends StatefulWidget {
  const LogoWallWidget({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LogoWallWidget> {
  Offset _offset = Offset.zero; // Posición inicial del grid

  List<Offset> _generateHexagonalPositions(int count, double size) {
    List<Offset> positions = [];
    int rows = (count / 6).ceil();
    int columns = (count / rows).ceil();

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < columns; col++) {
        if (positions.length >= count) {
          break;
        }

        double x = col * size * 1.5;
        double y =
            row * size * sqrt(3) + (col % 2 == 1 ? size * sqrt(3) / 2 : 0);
        positions.add(Offset(x, y));
      }
    }
    return positions;
  }

  void _onCircleTap(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    int totalCircles = 80;

    List<Offset> hexPositions =
        _generateHexagonalPositions(totalCircles, 100.0);

    List<String> imageUrls = [
      'https://picsum.photos/200/300',
      'https://picsum.photos/300/300',
      'https://picsum.photos/400/300',
      'https://picsum.photos/500/300',
      'https://picsum.photos/600/300',
      'https://picsum.photos/700/300',
      'https://picsum.photos/800/300',
      'https://picsum.photos/900/300',
      'https://picsum.photos/1000/300',
      'https://picsum.photos/1100/300',
    ];

    double gridWidth =
        hexPositions.map((pos) => pos.dx).reduce((a, b) => max(a, b)) + 100.0;
    double gridHeight =
        hexPositions.map((pos) => pos.dy).reduce((a, b) => max(a, b)) + 100.0;

    Offset centerOffset = Offset(
      (screenSize.width - gridWidth) / 2,
      (screenSize.height - gridHeight) / 2,
    );

    double horizontalLimit = (screenSize.width - gridWidth) / 2 - 100.0;
    double verticalLimit = (screenSize.height - gridHeight) / 2 - 225.0;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Nuestros Comercios'),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: GestureDetector(
          onPanUpdate: (details) {
            setState(() {
              Offset potentialOffset = _offset + details.delta;
              _offset = Offset(
                potentialOffset.dx.clamp(horizontalLimit, -horizontalLimit),
                potentialOffset.dy.clamp(verticalLimit, -verticalLimit),
              );
            });
          },
          child: Stack(
            children: [
              CustomPaint(
                painter: HexagonalPainter(
                  positions: hexPositions,
                  offset: _offset + centerOffset,
                  onTap: _onCircleTap,
                ),
                size: screenSize,
              ),
              ...hexPositions.asMap().entries.map((entry) {
                int index = entry.key;
                Offset pos = entry.value;

                // Calcula la distancia desde el centro de la pantalla
                double distanceFromCenter =
                    (pos + _offset + centerOffset).distance -
                        screenSize.width / 2;

                // Invertimos el factor de escala para que los iconos sean más grandes en el centro
                double scaleFactor = 0.9 - min(0.2, distanceFromCenter / 500);

                return Positioned(
                  left:
                      pos.dx + _offset.dx + centerOffset.dx - 70 * scaleFactor,
                  top: pos.dy + _offset.dy + centerOffset.dy - 70 * scaleFactor,
                  child: GestureDetector(
                    onTap: () => _onCircleTap(index),
                    child: AnimationConfiguration.staggeredList(
                      position: index,
                      duration: const Duration(milliseconds: 200),
                      child: ScaleAnimation(
                        scale: scaleFactor,
                        child: FadeInAnimation(
                          child: SizedBox(
                            width: 140 * scaleFactor,
                            height: 140 * scaleFactor,
                            child: ClipOval(
                              child: Image.network(
                                imageUrls[index % imageUrls.length],
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
        ));
  }
}
