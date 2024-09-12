import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris/piece.dart';
import 'package:tetris/pixel.dart';
import 'package:tetris/value.dart';

List<List<Tetromino?>> gameBoard = List.generate(
  colLength,
  (i) => List.generate(
    rowLength,
    (j) => null,
  ),
);

class GameBoard extends StatefulWidget {
  const GameBoard({super.key});

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  Piece currentPiece = Piece(type: Tetromino.L);
  int currentScore = 0;
  bool gameOver = false;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    currentPiece.initializePiece();
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      if (gameOver) {
        timer.cancel(); // Stop the game loop when game is over
        return;
      }
      setState(() {
        clearLines();
        if (!checkCollision(Direction.down)) {
          currentPiece.movePiece(Direction.down);
        } else {
          placePiece();
          createNewPiece();
        }
      });
    });
  }

  bool checkCollision(Direction direction) {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      if (row >= colLength || col < 0 || col >= rowLength) {
        return true;
      }

      if (row >= 0 && col >= 0 && gameBoard[row][col] != null) {
        return true;
      }
    }
    return false;
  }

  void placePiece() {
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      if (row >= 0 && col >= 0) {
        gameBoard[row][col] = currentPiece.type;
      }
    }
  }

  void createNewPiece() {
    Random rand = Random();
    Tetromino randomType =
        Tetromino.values[rand.nextInt(Tetromino.values.length)];
    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    if (isGameOver()) {
      gameOver = true;
      showGameOverDialog();
    }
  }

  void moveLeft() {
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  void moveRight() {
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  void rotatePiece() {
    setState(() {
      currentPiece.rotatePiece();
    });
  }

 void clearLines() {
  for (int row = colLength - 1; row >= 0; row--) {
    bool rowIsFull = true;
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[row][col] == null) {
        rowIsFull = false;
        break;
      }
    }
    if (rowIsFull) {
      for (int r = row; r > 0; r--) {
        gameBoard[r] = List.from(gameBoard[r - 1]);
      }
      gameBoard[0] = List.generate(rowLength, (index) => null);
      currentScore++;
    }
  }
}


  bool isGameOver() {
    for (int col = 0; col < rowLength; col++) {
      if (gameBoard[0][col] != null) {
        return true;
      }
    }
    return false;
  }

  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Game Over"),
          content: Text("Your score: $currentScore"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                resetGame();
              },
              child: Text("Restart"),
            ),
          ],
        );
      },
    );
  }

  void resetGame() {
    setState(() {
      gameBoard = List.generate(
        colLength,
        (i) => List.generate(
          rowLength,
          (j) => null,
        ),
      );
      currentScore = 0;
      gameOver = false;
      currentPiece = Piece(type: Tetromino.L);
      currentPiece.initializePiece();
      startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
                itemCount: rowLength * colLength,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: rowLength),
                itemBuilder: (context, index) {
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.color,
                    );
                  } else if (gameBoard[row][col] != null) {
                    final Tetromino? tetrominoType = gameBoard[row][col];
                    return Pixel(
                        color: tetrominoColors[tetrominoType]);
                  } else {
                    return Pixel(color: Colors.grey[900]);
                  }
                }),
          ),
          Text(
            "Score: $currentScore",
            style: TextStyle(color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0, top: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: moveLeft,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back_ios_new)),
                IconButton(
                    onPressed: rotatePiece,
                    color: Colors.white,
                    icon: Icon(Icons.rotate_right)),
                IconButton(
                    onPressed: moveRight,
                    color: Colors.white,
                    icon: Icon(Icons.arrow_forward_ios)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
