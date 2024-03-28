import Foundation

public struct WeatherData: Codable {
   public let temperature: Double
   public let weatherDescription: String

    enum CodingKeys: String, CodingKey {
        case main
        case weather
        case name
    }

    enum MainKeys: String, CodingKey {
        case temperature = "temp"
    }

    enum WeatherKeys: String, CodingKey {
        case description
    }
    
//    public init(name: String){
//        self.name = name
//    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let main = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temperature = try main.decode(Double.self, forKey: .temperature)
        
        var weatherArray = try container.nestedUnkeyedContainer(forKey: .weather)
        let weather = try weatherArray.nestedContainer(keyedBy: WeatherKeys.self)
        weatherDescription = try weather.decode(String.self, forKey: .description)
        //self.name = name
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        var main = container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        try main.encode(temperature, forKey: .temperature)
        
        var weatherArray = container.nestedUnkeyedContainer(forKey: .weather)
        var weather = weatherArray.nestedContainer(keyedBy: WeatherKeys.self)
        try weather.encode(weatherDescription, forKey: .description)
//        var nameConatined = encoder.container(keyedBy: CodingKeys.self)
//        var names = nameConatined.superEncoder(forKey: .name)
//        try names.encode(weatherDescription, forKey: .description)
        
    }
}
