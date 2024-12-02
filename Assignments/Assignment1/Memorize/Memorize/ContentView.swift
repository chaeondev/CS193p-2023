//
//  ContentView.swift
//  Memorize
//
//  Created by Chaewon on 12/1/24.
//

import SwiftUI

enum Theme: String {
    case jobs = "Jobs"
    case animals = "Animals"
    case sports = "Sports"
    
    var symbol: String {
        switch self {
        case .jobs:
            "person"
        case .animals:
            "cat"
        case .sports:
            "sportscourt"
        }
    }
    
    var emojis: Array<String> {
        switch self {
        case .jobs:
            ["👩‍⚖️", "💂‍♀️", "👩🏻‍💻", "👩‍🌾", "🕵🏻‍♀️", "👩🏻‍🚀"]
        case .animals:
            ["🐱", "🐶", "🐰", "🐹", "🦊"]
        case .sports:
            ["⚽️", "⚾️", "🏈", "🏀", "🎱", "🎾", "🏉"]
        }
    }
    
    var color: Color {
        switch self {
        case .jobs:
                .cyan
        case .animals:
                .orange
        case .sports:
                .indigo
        }
    }
}

struct ContentView: View {
   
    @State var currentEmojis: Array<String> = []
    @State var currentColor: Color = .accentColor
    
    @State var cardCount: Int = 4
    
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
            ScrollView {
                cards
            }
            Spacer()
            themeButtons
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
            ForEach(currentEmojis.indices, id: \.self) { index in
                CardView(content: currentEmojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundStyle(currentColor)
    }
    
    var themeButtons: some View {
        HStack(alignment: .lastTextBaseline, spacing: 50) {
            createButton(for: .jobs)
            createButton(for: .animals)
            createButton(for: .sports)
        }
        
    }
    
    func createButton(for theme: Theme) -> some View {
        Button {
            currentEmojis = (theme.emojis + theme.emojis).shuffled()
            currentColor = theme.color
        } label: {
            VStack {
                Image(systemName: theme.symbol)
                    .font(.title)
                    .padding(.bottom, 4)
                Text(theme.rawValue)
                    .font(.footnote)
            }
           
        }
    }
    
    
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}










#Preview {
    ContentView()
}
