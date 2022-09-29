import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/colors.dart';
import '../managers/board.dart';

import 'animated_tile.dart';
import 'button.dart';

class TileBoardWidget extends ConsumerWidget {
  const TileBoardWidget(
      {super.key, required this.moveAnimation, required this.scaleAnimation});

  final CurvedAnimation moveAnimation;
  final CurvedAnimation scaleAnimation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board = ref.watch(boardManager);

    final size = max(
        290.0,
        min((MediaQuery.of(context).size.shortestSide * 0.90).floorToDouble(),
            460.0));

    final sizePerTile = (size / 4).floorToDouble();
    final tileSize = sizePerTile - 12.0 - (12.0 / 4);
    final boardSize = sizePerTile * 4;
    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: Stack(
        children: [
          ...List.generate(board.tiles.length, (i) {
            var tile = board.tiles[i];

            return AnimatedTile(
              key: ValueKey(tile.id),
              tile: tile,
              moveAnimation: moveAnimation,
              scaleAnimation: scaleAnimation,
              size: tileSize,
              child: Container(
                width: tileSize,
                height: tileSize,
                decoration: BoxDecoration(
                    color: tileColors[tile.value],
                    borderRadius: BorderRadius.circular(6.0)),
                child: Center(
                    child: Text(
                  '${tile.value}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: tile.value < 8 ? textColor : textColorWhite),
                )),
              ),
            );
          }),
          if (board.over)
            Positioned.fill(
                child: Container(
              color: overlayColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    board.won ? 'You win!' : 'Game over!',
                    style: const TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 64.0),
                  ),
                  ButtonWidget(
                    text: board.won ? 'New Game' : 'Try again',
                    onPressed: () {
                      ref.read(boardManager.notifier).newGame();
                    },
                  )
                ],
              ),
            ))
        ],
      ),
    );
  }
}
