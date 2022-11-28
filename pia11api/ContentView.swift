//
//  ContentView.swift
//  pia11api
//
//  Created by Bill Martensson on 2022-11-28.
//

import SwiftUI

struct ContentView: View {
    
    @State var jsontext = ""
    
    @State var petitions = [Petition]()
    
    var body: some View {
        VStack {
            Text("Hello, world!")
            //Text(jsontext)
            
            List(petitions, id: \.title) { pet in
                VStack {
                    Text(pet.title)
                    Text(String(pet.created))
                }
            }
        }
        .onAppear() {
            loaddata()
        }
        
    }
    
    
    func loaddata() {
        
        /*
            UI
            |
            | LOAD IN BACK
            |\
            | \ BACK
            | |
            |/  main.async
         */
        
        
        print("LOAD DATA")
        
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"

        if let url = URL(string: urlString) {
            
            DispatchQueue.global(qos: .background).async {
                if let data = try? Data(contentsOf: url) {
                    // we're OK to parse!
                    print("DATA HÄMTAD")
                    
                    parse(json: data)
                    
                    /*
                    DispatchQueue.main.async {
                        //jsontext = String(decoding: data, as: UTF8.self)
                        //print(jsontext)
                    }
                    */
                }
            }
            print("EFTER BACKGROUND")
            
            
        }
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()

        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            
            for pet in jsonPetitions.results {
                print("*******************************")
                print(pet.title)
            }
            
            
        }
        
        
        
        
        
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
    var created : Int
}

struct Petitions: Codable {
    var results: [Petition]
}



/*
 
 /login
 /register
 email, password
 {
    "sessionkey": "abc123"
 }
 
 /products
 {
    "products": [
        {
            "id": 78,
            "name": "banan",
            "price": 7
        },
         {
            "id", 34,
             "name": "apelsin",
             "price": 12
         }
    ]
 }
 
 /order
 sessionkey, productid, 3
 /order?sessionkey=abc123&productid=78&amount=3
 {
    "orderstatus": true
 }
 
 
 NAMN       TELEFON
 Bartail    78
 Kerstin    34
 
 
 {
    "people": [
        {
            "name": "Bartail",
            "phone": "78"
        }
    ]
 }
 
 
 
 */


