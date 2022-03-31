//
//  ValidationFormView.swift
//  MyEasyCryptoManager (iOS)
//
//  Created by Jacob Aguilar on 27-03-22.
//

import SwiftUI

struct ValidationFormView: View {
    
    var iconName = "xmark.circle"
    var iconColor = Color(red: 188/255, green: 172/255, blue: 210/255)
    var baseForegroundColor = Color(red: 237/255, green: 230/255, blue: 249/255)
    var formText = ""
    var conditionChecked = false
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .foregroundColor(iconColor)
                .font(.system(size: 12))
            Text(formText)
                .font(.system(size: 12, design: .rounded))
                .foregroundColor(baseForegroundColor)
                .strikethrough(conditionChecked)
            
            Spacer()
        }
        .padding(.horizontal)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
    }
}

struct ValidationFormView_Previews: PreviewProvider {
    static var previews: some View {
        ValidationFormView()
    }
}
