//
//  Copyright © 2019 Peter Barclay. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    private let choices = ["Rock", "Paper", "Scissors"]
    private let maxQuestions = 10
    
    @State private var playerShouldWin = false
    @State private var currentChoice = 0
    @State private var playerChoice = 0
    @State private var score = 0
    @State private var askedCount = 1
    
    private func startNewGame() {
        score = 0
        askedCount = 1
        nextRound()
    }
    
    private func nextRound() {
        playerShouldWin = Bool.random()
        currentChoice = Int.random(in: 0 ..< choices.count)
    }
    
    private func endRound() {
        score += isWin ? 1 : -1
        askedCount += 1

        if isGameOver {
            endGame()
        } else {
            nextRound()
        }
    }
    
    private func endGame() {
        
    }
    
    var isGameOver: Bool {
        return askedCount == maxQuestions
    }
    
    var isWin: Bool {
        switch currentChoice {
        case 0: return playerChoice == (playerShouldWin ? 1 : 2)
        case 1: return playerChoice == (playerShouldWin ? 2 : 0)
        case 2: return playerChoice == (playerShouldWin ? 0 : 1)
        default: return false
        }
    }
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(askedCount) of \(maxQuestions)")
            
            Text("I chose \(choices[currentChoice])")
            
            Text("You need to \(playerShouldWin ? "Win" : "Lose")")
            
            Picker(selection: $playerChoice, label: Text("Player Choice")) {
                ForEach(0 ..< choices.count) {
                    Text(self.choices[$0])
                }
            }.pickerStyle(SegmentedPickerStyle())
            
            if !isGameOver {
                Button("Next") {
                    self.endRound()
                }
            }
            
            Text("Score: \(score)")
            
            if isGameOver {
                 Button("Play Again") {
                     self.startNewGame()
                 }
             }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
