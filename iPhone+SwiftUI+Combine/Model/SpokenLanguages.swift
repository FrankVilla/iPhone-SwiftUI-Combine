
import Foundation

struct SpokenLanguages : Codable {
    let english_name : String?
    let iso_639_1 : String?
    let name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case english_name = "english_name"
        case iso_639_1 = "iso_639_1"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        english_name = try values.decodeIfPresent(String.self, forKey: .english_name)
        iso_639_1 = try values.decodeIfPresent(String.self, forKey: .iso_639_1)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
    
}
