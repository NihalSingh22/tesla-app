//
//  LocationMap.swift
//  TeslaApp
//
//  Created by Nihal Singh on 02/09/2023.
//

import SwiftUI
import MapKit



struct CarLocation: Identifiable{
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D{
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let carLocations = [CarLocation(latitude: 25.1972, longitude: 55.2744)]

struct LocationMap: View {
    
    
    @Environment(\.presentationMode) var presentationMode
    @State private var location = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 25.1972, longitude: 55.2744), span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
    
    var body: some View {
        ZStack{
            Map(coordinateRegion: $location , annotationItems: carLocations , annotationContent: {location in MapAnnotation(coordinate: location.coordinate,  content: {CarPin()})
                
            })
            
            
            NewCarMap()
            
            LinearGradient(gradient: Gradient(colors: [Color("Dark Grey"), Color.clear, Color.clear, Color.clear]), startPoint: .top, endPoint: .bottom)
                .allowsHitTesting(false)
            
            VStack {
                HStack{
                    Button(action: {presentationMode.wrappedValue.dismiss()}){
                        Buttons(icon: "chevron.left")
                    }
                    
                    
                    Spacer()
                    Button(action:{}){
                        Buttons(icon: "speaker.wave.3.fill")
                    }
                }
                .padding()
                Spacer()
            }
            
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("Dark Grey"))
        .foregroundColor(Color.white)
        .navigationTitle("SUV")
        .navigationBarHidden(true)
    }
}


struct CarPin: View {
    var body: some View{
        VStack(alignment: .center, spacing: 4){
            Image(systemName: "car.fill")
                .frame(width: 32, height: 32, alignment: .center)
                .background(Color("Red"))
                .foregroundColor(Color.white)
                .clipShape(Circle())
            Text("SUV")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal,8)
                .padding(.vertical,4)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.black.opacity(0.1),lineWidth: 1  ))
        }
    }
}



struct LocationMap_Previews: PreviewProvider {
    static var previews: some View {
        LocationMap()
    }
}

struct NewCarMap: View {
    var body: some View {
        VStack{
            Spacer()
            VStack(alignment: .leading , spacing: 20){
                VStack(alignment: .leading , spacing: 10){
                    Text("Current Location")
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Divider()
                    Label("Burj Khalifa Blvd, Downtown Dubai - Dubai, United Arab Emirates", systemImage: "location.fill")
                        .opacity(0.5)
                        .font(.footnote)
                }
                VStack(alignment: .leading , spacing: 10){
                    VStack(alignment: .leading , spacing: 5){
                        Text("Summon")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Place the icon on the location you want to go").font(.footnote).opacity(0.5)
                    }
                    Divider()
                    FullLockedCar(text:"Go to Target")
                        .background(Color("Red"))
                        .foregroundColor(Color.white)
                        .clipShape(Capsule())
                    Label("Enter the address manually", systemImage: "mappin.and.ellipse")
                    
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("Dark Grey"))
            .foregroundColor(Color.white)
            
        }
    }
}
