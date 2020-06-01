//
//  Rating.swift
//  tail
//
//  Created by Jack Allen on 01/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI

var lightGray = Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1))

struct Rating: View {
    var rating: Float;
    
    var body: some View {
        HStack(alignment: .center, spacing: 4) {
         
            ForEach(1...5, id: \.self) { i in
                Image(systemName: "star.fill")
                    .foregroundColor(Float(i) <= self.rating ? .yellow : lightGray)
                    .font(.system(size: 15.0))
            }
            
        }
    }
}

struct Rating_Previews: PreviewProvider {
    static var previews: some View {
        Rating(rating: 3)
    }
}
