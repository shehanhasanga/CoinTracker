//
//  XmarkButton.swift
//  Crypto
//
//  Created by shehan karunarathna on 2022-02-06.
//

import SwiftUI

struct XmarkButton: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        Button{
//            print("pressed")
//            presentationMode.wrappedValue.dismiss()
        } label: {
            Image(systemName: "xmark")
        }
    }
}

struct XmarkButton_Previews: PreviewProvider {
    static var previews: some View {
        XmarkButton()
    }
}
