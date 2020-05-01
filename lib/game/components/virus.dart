import 'dart:ui';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';

import 'package:experiments_with_web/game/game.dart';

class Virus {
  Virus({
    @required this.gameTime,
    double left,
    double top,
  }) {
    virusRect = Rect.fromLTWH(left, top, gameTime.tileSize, gameTime.tileSize);
  }

  final GameTime gameTime;

  // COMPONENT VARIABLES
  Rect virusRect;
  bool isVirusDead = false;
  bool isVirusOffScreen = false;
  List<Sprite> movingVirusSprite;
  Sprite deadVirusSprite;
  double flyingSpriteIndex = 0;

  void render(Canvas c) {
    final _inflatedRect = virusRect.inflate(2.0);

    if (isVirusDead) {
      deadVirusSprite.renderRect(c, _inflatedRect);
    } else {
      movingVirusSprite[flyingSpriteIndex.toInt()].renderRect(c, _inflatedRect);
    }
  }

  void update(double t) {
    if (isVirusDead) {
      final _translateY = gameTime.tileSize * 18 * t;

      virusRect = virusRect.translate(0, _translateY);

      if (virusRect.top > gameTime.screenSize.height) {
        isVirusOffScreen = true;
      }
    }
  }

  // Virus onTapDown..
  // Change color if virus is tapped...
  void onTapDown() {
    isVirusDead = true;

    // ADDS THE VIRUS AGAIN..
    gameTime.createVirus();
  }
}
