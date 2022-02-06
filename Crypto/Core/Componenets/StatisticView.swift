//
//  StatisticView.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-05.
//

import SwiftUI

struct StatisticView: View {
    let stat:StatisticModel
    var body: some View {
        VStack{
            Text(stat.title)
                .font(.caption)
                .foregroundColor(Color.theme.secondTextColor)
            Text(stat.value)
                .font(.headline)
                .foregroundColor(.black)
            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (stat.percentageChange ?? 0 )>=0 ? 0 : 180))
                Text(stat.percentageChange?.asPercentageString() ?? "")
                    .font(.caption)
                    .bold()
            }
            .foregroundColor((stat.percentageChange ?? 0) >= 0 ? Color.theme.greencolor : .red)
            .opacity(stat.percentageChange == nil ? 0 : 1)
        }
       
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(stat: DeveloperPreview.stat3)
    }
}
