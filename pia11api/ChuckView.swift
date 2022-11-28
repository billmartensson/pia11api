//
//  ChuckView.swift
//  pia11api
//
//  Created by Bill Martensson on 2022-11-28.
//

import SwiftUI

struct ChuckView: View {
    
    @State var joketext = ""
    
    var body: some View {
        VStack {
            Text(joketext)
        }
        .onAppear() {
            loadjoke()
        }
    }
    
    
    func loadjoke() {
        //let chuckurl = "https://api.chucknorris.io/jokes/random"
        let chuckurl = "https://api.chucknorris.io/jokes/random?category=animal"

        if let url = URL(string: chuckurl) {
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url) {
                    let decoder = JSONDecoder()
                    if let jsonJoke = try? decoder.decode(ChuckJoke.self, from: data) {
                        
                        joketext = jsonJoke.value
                    }
                }
            }
        }
    }
    
}

struct ChuckView_Previews: PreviewProvider {
    static var previews: some View {
        ChuckView()
    }
}

struct ChuckJoke : Codable {
    var id : String
    var value : String
}

