//
//  DrinkDetail.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI


struct DrinkDetail: View {
    var drink: Drink
    
    var startLesson: () -> Void
    
    
    var body: some View {
        
        VStack {
            ScrollView {
                Image(drink.imageName)
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fill)
                    .frame(maxHeight: 300, alignment: .top)
                    .clipped()
                VStack {
                    DrinkHeader(drink: drink)
                    DrinkSummary(drink: drink)
                }.padding(30)
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarHidden(true)
            
            HStack {
                Button(action: {
                    self.startLesson()
                }) {
                    Spacer()
                    Text("Master the \(drink.name)")
                        .padding(10)
                    Spacer()
                }
                
                .background(Color(UIColor(red: 1, green: 0, blue: 0, alpha: 0.7)))
                .cornerRadius(10)
                .font(.headline)
                .foregroundColor(.white)
            }
            .padding(.bottom, 16)
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
    }
}

struct DrinkHeader : View {
    var drink: Drink
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 7.5) {
                
                HStack(alignment: .center) {
                    Text(drink.name)
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    FavouriteButton()
                }
                
                HStack(alignment: .center, spacing: 5) {
                    Rating(rating: drink.rating)
                    
                    Text("\(drink.rating, specifier: "%.1f")")
                        .font(.footnote)
                        .fontWeight(.semibold)
                }

            }
         
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct DrinkSummary : View {
    var drink: Drink
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            HStack {
                
                VStack {
                    Text("Tall")
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("Glass")
                    .font(.caption)
                }
                
                Spacer()
                
                VStack {

                    Text("2-3 mins")
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                        Text("Time")
                        .font(.caption)
                }
                
                Spacer()
                
                VStack {
                    Text("9%")
                        .fontWeight(.bold)
                        .padding(.bottom, 5)
                    Text("Strength")
                        .font(.caption)
                }
                
             
            }
            .padding(.horizontal, 30)
            .padding(.vertical, 20)
            
            VStack(alignment: .leading) {
                
                HStack(alignment: .center) {
                    
                    Text("Summary")
                        .font(.custom("AmericanTypewriter", size: 12))
                        .tracking(1)
                        .padding(.trailing)
                    
                    Rectangle()
                        .frame(width: nil, height: 1)
                        .foregroundColor(Color(UIColor.black.withAlphaComponent(0.2)))
                }
                
                Text(drink.description)
                    .font(.system(size: 14))
                    .fontWeight(.light)
                    .lineSpacing(7)
                    .padding(.vertical, 10)
            }
        }
    }
}

struct FavouriteButton: View {
    @State private var selected = false
    
    func onClick() {
        self.selected.toggle()
    }
    
    var body: some View {
        Button(action: onClick) {
            Image(systemName: selected ? "heart.fill" : "heart")
                .foregroundColor(selected ? .red : .black)
                .font(.system(size: 20.0, weight: .semibold))
    
        }
    }
}

struct OrderButton: View {
    var body: some View {
        Button(action: {}) {
            Text("Order Now")
        }
        .frame(width: 200, height: 50)
        .background(Color.blue)
        .foregroundColor(.white)
        .font(.headline)
        .cornerRadius(10)
    }
}


struct DrinkDetail_Previews: PreviewProvider {
    static var previews: some View {
        DrinkDetail(drink: drinkData.trending[0], startLesson: {
            print("start lesson")
        })
    }
}
