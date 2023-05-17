//
//  ContentView.swift
//  WeatherApp-1
//
//  Created by Shubham Mittal on 20/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var locationManager = LocationManager()
    var weatherManager = WeatherManager()
    @State var weather: ResponseBody?
    
    var body: some View {
        
        
        VStack{
            if let location = locationManager.location {
                if let weather = weather {
                    WeatherView(weather: weather)
                }else {
                    LoadingView()
                        .task {
                            do{
                               weather = try await weatherManager.getCurrentWeather(latitute: location.latitude, longitute: location.longitude)
                            }catch {
                            print("Error getting weather: \(error)")
                        }
                    }
                }
            }else{
                if locationManager.isLoading {
                    LoadingView()
                }else {
                    WelcomeView()
                        .environmentObject(locationManager)
                }
            }
        }
        .frame(width: 5000, height: 5000)
        .background(Color(hue: 0.559, saturation: 0.756, brightness: 0.663))
        .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
