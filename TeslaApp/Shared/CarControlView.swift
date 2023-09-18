//
//  CarControlView.swift
//  TeslaApp
//
//  Created by Nihal Singh on 28/08/2023.
//

import SwiftUI




let carControl: [ActionItem] = [ActionItem(icon: "flashlight.on.fill", text: "Flash    "),ActionItem(icon: "speaker.wave.3.fill", text: "Honk"),ActionItem(icon: "key.fill", text: "Start"),ActionItem(icon: "arrow.up.bin", text: "Front Trunk"),ActionItem(icon: "arrow.up.square", text: "Back Trunk")]




struct CarControlView: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State private var toggleValet: Bool = false
    
    var body: some View {
        ScrollView{
            VStack(spacing: 20){
                VStack(alignment: .leading , spacing: 10) {
                    HStack{
                        Button(action: {presentationMode.wrappedValue.dismiss()}){
                            Buttons(icon: "chevron.left")
                        }
                        Spacer()
                    }
                    Text("Car Controls")
                        .font(.title2)
                        .fontWeight(.semibold )
                }
                Divider()
                LockedCar()
                Divider()
                CarButtons()
                Divider()
                HStack{
                    Text("Dog Mode").fontWeight(.medium)
                    Spacer()
                    Toggle(" ",isOn: $toggleValet)
                }
                //                if toggleValet{
                //                    Text("Dog mode is now active!")
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Dark Grey"))
        .foregroundColor(Color.white)
        .navigationTitle("SUV")
        .navigationBarHidden(true)
    }
}

struct CarControlView_Previews: PreviewProvider {
    static var previews: some View {
        CarControlView()
    }
}

struct LockedCar: View {
    var body: some View {
        Button(action: {} ){
            FullLockedCar(text: "Unlock Car" , icon: "lock.fill")
        }
    }
}

struct CarButtons: View {
    var body: some View {
        VStack (spacing: 20){
            HStack{
                Spacer()
                ActionButton(item: carControl[0])
                Spacer()
                ActionButton(item: carControl[1])
                Spacer()
                ActionButton(item: carControl[2])
                Spacer()
            }
            HStack{
                Spacer()
                ActionButton(item: carControl[3])
                Spacer()
                ActionButton(item: carControl[4])
                Spacer()
            }
        }
        .padding()
    }
}
