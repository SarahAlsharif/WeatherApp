//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sarah Alsharif on 5/2/20.
//  Copyright © 2020 Raqmia. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var imgData = Data()
    @State var getTemp = false
    @State var city = ""
    @State var temperature = 0
    @State var description = ""
    
    //---------
    let bgColors = [
        "Clear":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6544341662, green: 0.9271220419, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Sunny":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)), Color(#colorLiteral(red: 0.9529411793, green: 0.8685067713, blue: 0.1800223484, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Partly cloudy":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5644291786, green: 0.6156922265, blue: 0.8125274491, alpha: 1)), Color(#colorLiteral(red: 0.3611070699, green: 0.3893437324, blue: 0.5149981027, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Cloudy":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5088317674, green: 0.5486197199, blue: 0.7256778298, alpha: 1)), Color(#colorLiteral(red: 0.3843137255, green: 0.4117647059, blue: 0.5450980392, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Overcast":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4714559888, green: 0.41813849, blue: 0.4877657043, alpha: 1)), Color(#colorLiteral(red: 0.3823538819, green: 0.3384427864, blue: 0.3941545051, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Mist":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8536048541, green: 0.8154317929, blue: 0.6934956985, alpha: 1)), Color(#colorLiteral(red: 0.5, green: 0.3992742327, blue: 0.3267588525, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Patchy rain possible":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.422871705, green: 0.486337462, blue: 0.7241632297, alpha: 1)), Color(#colorLiteral(red: 0.3826735404, green: 0.4012053775, blue: 0.9529411793, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Patchy snow possible":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8229460361, green: 0.8420813229, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.6424972056, green: 0.9015246284, blue: 0.9529411793, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Patchy sleet possible":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9764705896, green: 0.7979655136, blue: 0.9493740175, alpha: 1)), Color(#colorLiteral(red: 0.6843526756, green: 0.7806652456, blue: 0.9529411793, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Patchy freezing drizzle possible":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6207757569, green: 0.9686274529, blue: 0.9110963382, alpha: 1)), Color(#colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Thundery outbreaks possible":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Blowing snow":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)), Color(#colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Blizzard":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9551106616, green: 0.9764705896, blue: 0.9351792135, alpha: 1)), Color(#colorLiteral(red: 0.6891936611, green: 0.7095901305, blue: 0.9529411793, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Fog":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.6324083141, green: 0.8039215803, blue: 0.7850640474, alpha: 1)), Color(#colorLiteral(red: 0.4545597353, green: 0.393878495, blue: 0.5369011739, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Freezing fog":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 0.4545597353, green: 0.393878495, blue: 0.5369011739, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Patchy light drizzle":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.5892893535, green: 0.7170531098, blue: 0.9764705896, alpha: 1)), Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Light rain":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)), Color(#colorLiteral(red: 0.2854045624, green: 0.4267300284, blue: 0.6992385787, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Moderate rain at times":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.3437546921, green: 0.6157113381, blue: 0.7179171954, alpha: 1)), Color(#colorLiteral(red: 0.4118283819, green: 0.5814552154, blue: 0.6975531409, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Heavy rain":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.1596036421, green: 0, blue: 0.5802268401, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Light freezing rain":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7433765433, green: 0.9529411793, blue: 0.8886958889, alpha: 1)), Color(#colorLiteral(red: 0.4561494407, green: 0.6342332627, blue: 0.7568627596, alpha: 1))]), startPoint: .top, endPoint: .bottom),
        "Heavy rain at times":LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)), Color(#colorLiteral(red: 0.1596036421, green: 0, blue: 0.5802268401, alpha: 1))]), startPoint: .top, endPoint: .bottom)
    ]
    
    let icon = [
        "Clear": "moon.stars.fill",
        "Sunny": "sun.max.fill",
        "Partly cloudy Moon": "cloud.moon.fill",
        "Partly cloudy": "cloud.sun.fill",
        "Cloudy": "cloud.fill",
        "Overcast": "smoke.fill",
        "Mist": "cloud.fog.fill",
        "Patchy rain possible": "cloud.drizzle.fill",
        "Patchy snow possible": "cloud.hail.fill",
        "Patchy sleet possible": "cloud.sleet.fill",
        "Patchy freezing drizzle possible": "cloud.hail.fill",
        "Thundery outbreaks possible": "cloud.bolt.rain.fill",
        "Blowing snow": "cloud.snow.fill",
        "Blizzard": "wind.snow",
        "Fog": "cloud.fog.fill",
        "Freezing fog": "cloud.fog",
        "Patchy light drizzle": "cloud.drizzle.fill",
        "Light rain": "cloud.rain.fill",
        "Moderate rain at times": "cloud.rain.fill",
        "Heavy rain": "cloud.heavyrain.fill",
        "Light freezing rain": "cloud.hail.fill",
        "Heavy rain at times": "cloud.heavyrain.fill"
    ]
    //-------------------
    @State var weatherDescription = "Clear"
    var body: some View {
        ZStack {
            bgColors[weatherDescription]
            VStack {
                if getTemp {
                    Text("\(city)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 40))
                    
                    Text("\(description)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 25)).padding(.bottom, 60)
                        .frame(maxWidth: .infinity)
                    
                    Image(systemName: icon[weatherDescription]!)
                        .foregroundColor(Color.white)
                        .font(.system(size: 120))
                    
                    Text("\(self.temperature)")
                        .foregroundColor(Color.white)
                        .font(.system(size: 90))
                }
            }
        }.edgesIgnoringSafeArea(.all)
            .onAppear() {
                self.getWeatherData()
        }
    }
    //MARK: - JSON
    func getWeatherData() {
        let jsonURLString = "http://api.weatherstack.com/current?access_key=0464ea1313d183fbc867d642ebdd7ec0&query=New%20York"
        // make URL
        guard let url = URL(string: jsonURLString) else { return }
        // start a session
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            // check for error
            if error != nil {
                print(error!.localizedDescription)
            }
            // check for 200 OK status
            
            guard let data = data else { return }
            do {
                let weather = try JSONDecoder().decode(Weather.self, from: data)
                self.city = weather.location?.region ?? ""
                self.temperature = (weather.current?.temperature) ?? 0
                self.description = weather.current?.weather_descriptions[0] ?? ""
                let code = weather.current?.weather_code
                self.weatherDescription = self.getWeatherDescription(code: code ?? 113)
                let url = URL(string: (weather.current?.weather_icons[0]!)!)
                if let data = try? Data(contentsOf: url!) {
                    self.imgData = data
                }
                self.getTemp.toggle()
            } catch let err {
                print ("Json Err", err)
            }
        }.resume()
    }
    
    
    func getWeatherDescription (code : Int) -> String {
        switch code {
        case 113: return "Clear" // or Sunny
        case 116: return "Partly cloudy"
        case 119: return "Cloudy"
        case 122: return "Overcast"
        case 143: return "Mist"
        case 176: return "Patchy rain possible"
        case 179: return "Patchy snow possible"
        case 182: return "Patchy sleet possible"
        case 185: return "Patchy freezing drizzle possible"
        case 200: return "Thundery outbreaks possible"
        case 227: return "Blowing snow"
        case 230: return "Blizzard"
        case 248: return "Fog"
        case 260: return "Freezing fog"
        case 263: return "Patchy light drizzle"
        case 266: return "Light drizzle"
        case 281: return "Freezing drizzle"
        case 284: return "Heavy freezing drizzle"
        case 293: return "Patchy light rain"
        case 296: return "Light rain"
        case 299: return "Moderate rain at times"
        case 302: return "Moderate rain"
        case 305: return "Heavy rain at times"
        case 308: return "Heavy rain"
        case 311: return "Light freezing rain"
        default:
            return "Clear"
        }
    }
}

// MAKE STRUCT VARIABLES OPTIONAL TO PREVENT CRASHING WHEN VARIABLE IS EMPTY
struct Current : Decodable {
    let observation_time : String?
    let temperature : Int?
    let weather_code : Int?
    let weather_icons : [String?]
    let weather_descriptions : [String?]
    let wind_speed : Int?
    let wind_degree : Int?
    let wind_dir : String?
    let pressure : Int?
    let precip : Double?
    let humidity : Int?
    let cloudcover : Int?
    let feelslike : Int?
    let uv_index : Int?
    let visibility : Int?
}

struct Location : Decodable {
    let name : String?
    let country : String?
    let region : String?
    let lat : String?
    let lon : String?
    let timezone_id : String?
    let localtime : String?
    let localtime_epoch : Int?
    let utc_offset : String?
}

struct Weather : Decodable {
    let request : Request?
    let location : Location?
    let current : Current?
}

struct Request : Decodable {
    let type : String?
    let query : String?
    let language : String?
    let unit : String?
}



/* let icon = [
     "Clear": UIImage(systemName: "moon.stars.fill"),
     "Sunny": UIImage(systemName: "sun.max.fill"),
     "Partly cloudy Moon": UIImage(systemName: "cloud.moon.fill"),
     "Partly cloudy Sun": UIImage(systemName: "cloud.sun.fill"),
     "Cloudy": UIImage(systemName: "cloud.fill"),
     "Overcast": UIImage(systemName: "smoke.fill"),
     "Mist": UIImage(systemName: "cloud.fog.fill"),
     "Patchy rain possible": UIImage(systemName: "cloud.drizzle.fill"),
     "Patchy snow possible": UIImage(systemName: "cloud.hail.fill"),
     "Patchy sleet possible": UIImage(systemName: "cloud.sleet.fill"),
     "Patchy freezing drizzle possible": UIImage(systemName: ""), /// idk
     "Thundery outbreaks possible": UIImage(systemName: "cloud.bolt.fill"),
     "Blowing snow": UIImage(systemName: "cloud.snow.fill"),
     "Blizzard": UIImage(systemName: "wind.snow"),
     "Fog": UIImage(systemName: "cloud.fog.fill"),
     "Freezing fog": UIImage(systemName: "cloud.fog"),
     "Patchy light drizzle": UIImage(systemName: "cloud.drizzle.fill"),
     "Light rain": UIImage(systemName: "cloud.rain.fill"),
     "Moderate rain at times": UIImage(systemName: "cloud.rain.fill"),
     "Heavy rain": UIImage(systemName: "cloud.heavyrain.fill"),
     "Light freezing rain": UIImage(systemName: "cloud.hail.fill"),
     "Heavy rain at times": UIImage(systemName: "cloud.heavyrain.fill")
 ]*/
