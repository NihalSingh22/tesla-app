//
//  CommonComponents.swift
//  TeslaApp
//
//  Created by Nihal Singh on 02/09/2023.
//

import Foundation
import SwiftUI



//General Button

struct Buttons: View {
    
    var icon: String
    
    
    var body: some View{
        Image(systemName: icon)
            .imageScale(.large)
            .frame(width: 44 , height: 44)
            .background(Color.white.opacity(0.05))
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
}


// Custom Divider
struct Divider: View{
    var body: some View{
        Rectangle()
            .frame(minWidth: 55 )
            .frame(height: 0.3)
            .background(Color.white)
            .opacity(0.1)
    }
    
}




struct ActionButton: View{
    
    var item: ActionItem
    
    var body: some View{
        VStack(alignment: .center){
            Buttons(icon: item.icon)
            Text(item.text)
                .frame(width: 72)
                .font(.system(size: 12, weight: .semibold,design: .default))
                .multilineTextAlignment(.center)
        }
    }
}


struct ActionItem: Hashable{
    var icon: String
    var text: String
    
}


struct FullLockedCar: View {
    
    var text: String
    var icon: String = ""
    
    
    var body: some View {
        if icon.isEmpty {
            textButton
        }else{
            iconButton
        }
    }
    
    var iconButton: some View {
        Label(text ,systemImage: icon)
            .font(.system(size: 16 , weight: .medium , design: .default))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 14 , style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14 , style: .continuous)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
    
    var textButton: some View{
        Text(text)
            .font(.system(size: 16 , weight: .medium , design: .default))
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 14 , style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 14 , style: .continuous)
                    .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
            )
    }
}
