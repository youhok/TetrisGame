import 'package:flutter/material.dart';
import 'package:tetris/board.dart';
import 'package:tetris/value.dart';

class Piece {
  //type of tetris piece
  Tetromino type;

  Piece({required this.type});

  //the piece is just a list of integers
  List<int> position = [];

  Color get color {
    return tetrominoColors[type] ?? const Color(0xFFFFFFFF);
  }

  void initializePiece() {
    switch (type) {
      case Tetromino.L:
        position = [-26, -16, -6, -5];
        break;
      case Tetromino.J:
        position = [-25, -15, -5, -6];
        break;
      case Tetromino.I:
        position = [-4, -5, -6, -7];
        break;
      case Tetromino.O:
        position = [-15, -16, -5, -6];
        break;
      case Tetromino.S:
        position = [-15, -14, -6, -5];
        break;
      case Tetromino.Z:
        position = [-17, -16, -6, -5];
        break;
      case Tetromino.T:
        position = [-26, -16, -6, -15];
        break;
      default:
    }
  }

  //move piece

  void movePiece(Direction direction) {
    switch (direction) {
      case Direction.down:
        for (int i = 0; i < position.length; i++) {
          position[i] += rowLength;
        }
        break;
      case Direction.left:
        for (int i = 0; i < position.length; i++) {
          position[i] -= 1;
        }
        break;
      case Direction.right:
        for (int i = 0; i < position.length; i++) {
          position[i] += 1;
        }
        break;
      default:
    }
  }

  //Rotate piece
  int rotationState = 1;
  void rotatePiece() {
    List<int> newPositions = [];

    //rotate the piece based on it 's type
    switch (type) {
      case Tetromino.L:
        switch (rotationState) {
          case 0:
            // get the new  position
            newPositions = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new  position
            newPositions = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new  position
            newPositions = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength - 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new  position
            newPositions = [
              position[1] - rowLength + 1,
              position[1],
              position[1] + 1,
              position[1] - 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetromino.J:
        switch (rotationState) {
          case 0:
            // get the new  position
            newPositions = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + rowLength - 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new  position
            newPositions = [
              position[1] - rowLength - 1,
              position[1],
              position[1] - 1,
              position[1] + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new  position
            newPositions = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - rowLength + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new  position
            newPositions = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] + rowLength + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.I:
        switch (rotationState) {
          case 0:
            // get the new  position
            newPositions = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + 2,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new  position
            newPositions = [
              position[1] - rowLength,
              position[1],
              position[1] + rowLength,
              position[1] + 2 * rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new  position
            newPositions = [
              position[1] + 1,
              position[1],
              position[1] - 1,
              position[1] - 2,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new  position
            newPositions = [
              position[1] + rowLength,
              position[1],
              position[1] - rowLength,
              position[1] - 2 * rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }
      case Tetromino.O:
        //nothing
        break;
      case Tetromino.S:
        switch (rotationState) {
          case 0:
            // get the new  position
            newPositions = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new  position
            newPositions = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new  position
            newPositions = [
              position[1],
              position[1] + 1,
              position[1] + rowLength - 1,
              position[1] + rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new  position
            newPositions = [
              position[0] - rowLength,
              position[0],
              position[0] + 1,
              position[0] + rowLength + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetromino.Z:
        switch (rotationState) {
          case 0:
            // get the new  position
            newPositions = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new  position
            newPositions = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new  position
            newPositions = [
              position[0] + rowLength - 2,
              position[1],
              position[2] + rowLength - 1,
              position[3] + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new  position
            newPositions = [
              position[0] - rowLength + 2,
              position[1],
              position[2] - rowLength + 1,
              position[3] - 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

      case Tetromino.T:
        switch (rotationState) {
          case 0:
            // get the new  position
            newPositions = [
              position[2] - rowLength,
              position[2],
              position[2] + 1,
              position[2] + rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 1:
            // get the new  position
            newPositions = [
              position[1] - 1,
              position[1],
              position[1] + 1,
              position[1] + rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 2:
            // get the new  position
            newPositions = [
              position[1] - rowLength,
              position[1] - 1,
              position[1],
              position[1] + rowLength,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
          case 3:
            // get the new  position
            newPositions = [
              position[2] - rowLength,
              position[2] - 1,
              position[2],
              position[2] + 1,
            ];
            //check that is  new positions is valid move before assigning it to  the real positions
            if (piecePositionIsValid(newPositions)) {
              //update  position
              position = newPositions;
              //update  rotation state
              rotationState = (rotationState + 1) % 4;
            }
            break;
        }

        break;
      default:
    }
  }

  bool positionIsValid(int position) {
    // get the row and col of position
    int row = (position / rowLength).floor();
    int col = position % rowLength;

    // if  the position is taken , return false
    if (row < 0 || col < 0 || gameBoard[row][col] != null) {
      return false;
    }
    //otherwise the position is valid so retrun true
    else {
      return true;
    }
  }

  //check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupied = false;
    bool lastColOccupied = false;
    for (int pos in piecePosition) {
      //return false if any position is already taken
      if (!positionIsValid(pos)) {
        return false;
      }
      //get col of the positions
      int col = pos % rowLength;
      // check  if the first orr last column is occupied
      if (col == 0) {
        firstColOccupied = true;
      }
      if (col == rowLength - 1) {
        lastColOccupied = true;
      }
    }
    // if there is  a piece in the first col and last col , it is going to   through the wall
    return !(firstColOccupied && lastColOccupied);
  }
}

const Map<Tetromino, Color> tetrominoColors = {
  Tetromino.L: Color(0xFFFFA500), //Orange
  Tetromino.J: Color.fromARGB(255, 0, 102, 255), //Blue
  Tetromino.I: Color.fromARGB(255, 242, 0, 255), //pink
  Tetromino.O: Color(0xFFFFFF00), //yellow
  Tetromino.S: Color(0xFF008000), //Green
  Tetromino.Z: Color(0xFFFF0000), //Red
  Tetromino.T: Color.fromARGB(255, 144, 0, 255), //Purple
};
