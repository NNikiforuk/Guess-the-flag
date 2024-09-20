//
//  ContentView.swift
//  Guess the flag
//
//  Created by Natalia Nikiforuk on 18/09/2024.
//

import SwiftUI

struct FlagModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(.capsule)
            .shadow(radius: 5)
    }
}

extension View {
    func imageStyle() -> some View {
        modifier(FlagModifier())
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score = 0
    @State private var questionNr = 1
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
        VStack {
            Spacer()
            Text("Guess the flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
            VStack(spacing: 15) {
                VStack {
                    Text("Tap the flag of")
                        .font(.subheadline.weight(.heavy))
                        .foregroundStyle(.secondary)
                    Text(countries[correctAnswer])
                        .font(.largeTitle.weight(.semibold))
                }
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .imageStyle()
                        }
                    }
                
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(.regularMaterial)
            .clipShape(.rect(cornerRadius: 20))
            Spacer()
        }
        .padding()
        }
        .alert("Game over", isPresented: $showingScore) {
            Button("New game", action: finish)
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    func flagTapped(_ number: Int){
        questionNr += 1
        
        if number == correctAnswer {
            score += 1
        } else {
            score -= 1
        }
        
        if questionNr <= 8 {
            askQuestion()
        } 
        
        if questionNr == 9 {
            showingScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func finish(){
        askQuestion()
        score = 0
        questionNr = 1
    }
}

#Preview {
    ContentView()
}
