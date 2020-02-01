//
//  ContentView.swift
//  iOSAssignment
//
//  Created by Neelam Gupta on 01/02/20.
//  Copyright © 2020 Neelam Gupta. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct ContentView: View {
    @ObservedObject var networkingManager = NetworkingManager()
    
    var body: some View {
        NavigationView {
             GeometryReader { geometry in
                List(self.networkingManager.jsonData.rows!, id: \.self) {item in
          
                HStack{
                    WebImage(url: URL(string: item.imageHref))
                      .onSuccess { image, cacheType in
                          // Success
                      }
                      .placeholder(Image(systemName: "photo")) // Placeholder Image
                      // Supports ViewBuilder as well
                      .placeholder {
                          Rectangle().foregroundColor(.gray)
                      }
                    .resizable()
                    .frame(width: 80,
                           height: 80,
                           alignment: .topLeading)
                        .scaledToFit()
            
                    VStack{
                        Text(item.title!)
                        Text(item.description!)
                        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    }
                }
             }
            .padding()
            .navigationBarTitle(Text(networkingManager.jsonData.title), displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
