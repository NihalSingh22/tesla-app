//
//  ContentView.swift
//  Shared
//
//  Created by Nihal Singh on 17/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    
    @State private var openVoiceCommand = false
    @State private var openMedia = false
    @State private var openCharging = false
    
    @State private var actionText = ""
    @State private var actionIcon = ""
    @State private var openAction = false
    
    
    var body: some View {
        NavigationView {
            ZStack{
                
                ScrollView{
                    VStack(spacing: 20){
                        Header()
                        Divider()
                        Teslacar(openCharging: $openCharging)
                        Divider()
                        IconsTwo(openAction: $openAction, actionText: $actionText, actionIcon: $actionIcon , openCharging: $openCharging, openMedia: $openMedia , title:"Shortcuts", Edit: true, actionItems: quickShortcuts)
                        Divider()
                        IconsTwo(openAction: $openAction, actionText: $actionText, actionIcon: $actionIcon , openCharging: $openCharging, openMedia: $openMedia , title:"Recent Actions", Edit: true, actionItems: recentActions)
                        Divider()
                        AllSettings()
                        RearrangeButton()
                    }
                    .padding()
                }
                VoiceCommand(open: $openVoiceCommand)
                
                
                if (openVoiceCommand || openCharging || openMedia || openAction){
                    Color.black.opacity(0.5)
                        .edgesIgnoringSafeArea(.all)
                        .transition(.opacity)
                        .onTapGesture {
                            withAnimation{
                                openVoiceCommand = false
                                openCharging = false
                                openMedia = false
                                openAction = false
                            }
                        }
                }
                
                
                if openVoiceCommand{
                    VoiceCommandView(open: $openVoiceCommand, text: "Take me to mashreq station" )
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                
                if openCharging{
                    ChargingView()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                
                if openMedia{
                    MediaPlayer()
                        .zIndex(1)
                        .transition(.move(edge: .bottom))
                }
                
                
//                if openAction  && !actionText.isEmpty{
//                    ActionNotification(open: $openAction, icon: actionIcon, text: actionText)
//                    zIndex(1)
//                        .transition(.move(edge: .bottom))
//                }
                
                
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("Dark Grey"))
            .foregroundColor(Color.white)
            .navigationTitle("SUV")
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


// VoiceCommand Button
struct VoiceCommand: View {
    
    
    @Binding var open: Bool
    
    
    var body: some View{
        VStack{
            
            Spacer()
            HStack{
                Spacer()
                Button(action:{withAnimation{
                    open = true
                }}){
                    Image(systemName: "mic.fill")
                        .font(.system(size:24 ,weight: .semibold, design: .default))
                        .frame(width: 64, height: 64)
                        .background(Color("Green"))
                        .foregroundColor(Color("Dark Grey"))
                        .clipShape(Circle())
                        .padding()
                        .shadow(radius: 10)
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}


//Home header

struct Header: View {
    var body: some View{
        HStack{
            VStack(alignment: .leading,spacing:10){
                Text("Model X".uppercased())
                    .font(.caption2)
                    .fontWeight(.medium)
                    .padding(.vertical,4)
                    .padding(.horizontal,8)
                    .foregroundColor(Color.white)
                    .background(Color("Red"))
                    .clipShape(Capsule())
                Text("SUV")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
            }
            
            Spacer()
            HStack{
                Button(action:{}){
                    Buttons(icon:"lock.fill")
                }
                Button(action:{}){
                    Buttons(icon:"gear")
                }
            }
        }
        .padding(.top)
    }
}




struct Teslacar: View{
    
    @Binding var openCharging: Bool
    
    var body: some View{
        VStack(spacing: 10){
            HStack(alignment:.center){
                
                Button(action: {
                    withAnimation{
                        openCharging = true
                    }
                }){
                    Label("223 Kilometers".uppercased(), systemImage: "battery.50")
                        .font(.system(size: 14 , weight: .semibold, design: .rounded))
                        .foregroundColor(Color("Green"))
                }
                
                Spacer()
                VStack(alignment: .trailing){
                    Text("Parked")
                        .fontWeight(.semibold)
                    Text("Updated 5 min ago")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
            
            Image("tesla car")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
        }
    }
    
}


// category header
struct IconsOne: View{
    
    var title: String
    var Edit: Bool
    
    var body: some View{
        HStack(alignment: .center){
            Text(title)
                .font(.title2)
                .fontWeight(.semibold)
            Spacer()
            if Edit{
                Button(action:{}){
                    Text("Edit")
                        .foregroundColor(.gray)
                        .fontWeight(.medium)
                }
            }
        }
    }
}

// category view
struct IconsTwo: View{
    
    @Binding var openAction: Bool
    @Binding var actionText: String
    @Binding var actionIcon : String
    
    @Binding var openCharging: Bool
    @Binding var openMedia: Bool
    
    var title: String
    var Edit: Bool
    
    var actionItems: [ActionItem]
    
    var body: some View{
        VStack{
            IconsOne(title: title, Edit: Edit)
            ScrollView(.horizontal, showsIndicators: false){
                
                
                
                HStack(alignment: .top){
                    
                    if title == "Shortcuts"{
                        
                        
                        
                        Button(action: {withAnimation{
                            openCharging = true
                        }}){
                            
                            ActionButton(item: chargingShortcut)
                            
                        }
                        
                        
                        
                        Button(action: {withAnimation{
                            openMedia = true
                        }}){
                            ActionButton(item: mediaShortcut )}
                    }
                    
                    
                    ForEach(actionItems,id:\.self){
                        item in Button(action: {
                            withAnimation{
                                openAction = true
                                actionText = item.text
                                actionIcon = item.icon
                            }
                        }){
                            ActionButton(item: item)
                        }
                    }
                }
            }
        }
    }
}



let quickShortcuts: [ActionItem] = [
    ActionItem(icon: "fanblades.fill", text: "Fan On"),ActionItem(icon: "bolt.car", text: "Close Charge Port")
]



let chargingShortcut = ActionItem(icon: "bolt.fill", text: "Charging")
let mediaShortcut = ActionItem(icon: "music.note", text: "Media")


let recentActions: [ActionItem] = [ActionItem(icon: "person.fill.viewfinder", text: "Summon"),ActionItem(icon: "fanblades", text: "Fan Off"),ActionItem(icon: "arrow.up.square", text: "Open Trunk")]


struct AllSettings: View{ 
    var body: some View{
        VStack{
            IconsOne(title: "All Settings", Edit: false)
            LazyVGrid(columns: [GridItem(.fixed(170)),GridItem(.fixed(170))]){
                
                NavigationLink(destination: CarControlView()){
                    
                    Setting(icon: "car.fill", title: "Controls",subtitle: " Functions")
                    
                }
                
                
                Setting(icon: "fanblades.fill", title: "Climate", subtitle: "24° C ",backgroundColor: Color("Blue"))
                
                NavigationLink(destination: LocationMap()){
                    Setting(icon: "location.fill", title: "Location" , subtitle: "Burj Khalifa")
                }
                
                Setting(icon: "checkerboard.shield", title: "Security", subtitle: "No event detected")
                Setting(icon: "sparkles", title: "Upgrades",subtitle: "1 Upgrade available")
            }
        }
    }
}


struct Setting: View{
    
    
    var icon: String
    var title: String
    var subtitle: String
    
    var backgroundColor: Color = Color.white.opacity(0.05)
    
    
    var body: some View {
        HStack(alignment: .center, spacing: 2){
            Image(systemName: icon)
            VStack(alignment: .leading,spacing: 2){
                Text(title)
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.system(size: 16, weight: .medium, design: .default))
                
                Text(subtitle.uppercased())
                    .font(.system(size: 9, weight: .medium, design: .default))
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
            }
            .padding(.leading,5)
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding(.horizontal,8)
        .padding(.vertical,16
        )
        .background(backgroundColor)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.1), lineWidth: 0.5))
    }
}


struct RearrangeButton: View{
    
    var body: some View{
        Button(action: {}){
            Text("Rearrange Groups")
                .font(.caption2)
                .padding(.vertical,8)
                .padding(.horizontal,14)
                .background(Color.white.opacity(0.05))
                .clipShape(Capsule())
        }
    }
}
