//
//  ContentView.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Trending().tabItem {
                Image(systemName: "house")
                        .font(.system(size: 18))
            }

            Text("Second").tabItem {
                Image(systemName: "square.grid.2x2")
                        .font(.system(size: 18))
            }

            Text("Third").tabItem {
                Image(systemName: "bookmark")
                        .font(.system(size: 18))
            }

            Text("Settings").tabItem {
                Image(systemName: "gear")
                        .font(.system(size: 18))
            }
        }

    }
}

struct Trending: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Discover Recipes")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()

                    DrinkRow(categoryName: "Trending", drinks: drinkData.trending)
                            .padding(.top)


                    DrinkRow(categoryName: "Suggested", drinks: drinkData.suggested)
                            .padding(.top)

                }
            }.navigationBarHidden(true)
                    .navigationBarTitle(Text(""))
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
