//
//  CircleButton.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct CircleButton: View {
    var iconName:String
    var body: some View {
        Image(systemName: iconName)
            .font(.headline)
            .foregroundColor(Color.black)
            .frame(width:50,height: 50)
            .background(Circle()
                            .foregroundColor(Color.theme.bacckground)
            )
            .shadow(color: .gray, radius: 10, x: 0, y: 0)
            .padding()
        
    }
}

struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        CircleButton(iconName: "heart.fill")
            .padding()
            .previewLayout(.sizeThatFits)
      
    }
}
