//
//  DrinkRow.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI

struct DrinkRow: View {
    var categoryName: String
    var drinks: [Drink]

    var body: some View {

        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top) {
                    ForEach(self.drinks, id: \.name) { drink in
                        DrinkItem(drink: drink)
                            .padding(.trailing, 30)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct DrinkRow_Previews: PreviewProvider {
    static var previews: some View {
        DrinkRow(categoryName: "Trending", drinks: drinkData.trending)
    }
}
