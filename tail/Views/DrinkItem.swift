//
//  DrinkItem.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI

struct DrinkItem: View {
    var drink: Drink
    
    @State var showDetails = false

    var body: some View {
        Button(action: {
            self.showDetails.toggle()
        }) {
            VStack(alignment: .leading, spacing: 16.0) {
                Image(drink.imageName)
                        .resizable()
                        .renderingMode(.original)
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 250, height: 170)
                        .cornerRadius(10)

                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(drink.name)
                            .foregroundColor(.primary)
                            .font(.headline)
                            .fontWeight(.semibold)
                        Spacer()
                        Rating(rating: drink.rating)
                    }
                    
                    Text(drink.shortDescription)
                            .foregroundColor(.secondary)
                            .font(.subheadline)
                            .multilineTextAlignment(.leading)
                }
            }
        }
        .sheet(isPresented: $showDetails) {
            DrinkDetail(drink: self.drink)
        }
        
    }
}

struct DrinkItem_Previews: PreviewProvider {
    static var previews: some View {
        DrinkItem(drink: drinkData.suggested[0])
    }
}
