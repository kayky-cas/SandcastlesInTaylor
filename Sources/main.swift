// The Swift Programming Language
// https://docs.swift.org/swift-book

import Raylib

let gameWidth = 60
let gameHeigth = 100

var game = [[Bool]](repeating: [Bool](repeating: false,
                                      count: gameWidth),
                    count: gameHeigth)

let scale = 8

let screenWidth = gameWidth   * scale
let screenHeight = gameHeigth * scale

Raylib.initWindow(Int32(screenWidth), Int32(screenHeight), "Sandcastle")
Raylib.setTargetFPS(60)

let xSize = Float(screenWidth/gameWidth)
let size = Vector2(x: xSize, y: xSize)

while Raylib.windowShouldClose == false {
    for row in (0..<(gameHeigth - 1)).reversed() {
        for col in 0..<gameWidth {
            if game[row][col] {
                if !game[row + 1][col]  {
                    game[row][col] = false
                    game[row + 1][col] = true
                } else if col < gameWidth - 1 && !game[row + 1][col + 1]  {
                    game[row][col] = false
                    game[row + 1][col + 1] = true
                } else if col > 0 && !game[row + 1][col - 1]  {
                    game[row][col] = false
                    game[row + 1][col - 1] = true
                }
            }
        }
    }
    
    if Raylib.isMouseButtonDown(.left) {
        let mousePos = Raylib.getMousePosition()

        let x = Int(mousePos.x.rounded() / xSize)
        let y = Int(mousePos.y.rounded() / xSize)

        if x >= 0 && x < gameWidth && y >= 0 && y < gameHeigth {
            game[y][x] = true
        }
    }

    Raylib.beginDrawing()
    Raylib.clearBackground(Color.blue)

    for row in 0..<gameHeigth {
        for col in 0..<gameWidth {
            if game[row][col] {
                let position = Vector2(x: Float(col) * xSize, y: Float(row) * xSize)
                Raylib.drawRectangleV(position, size, Color.orange)
            }
        }
    }

    Raylib.endDrawing()
}
Raylib.closeWindow()
