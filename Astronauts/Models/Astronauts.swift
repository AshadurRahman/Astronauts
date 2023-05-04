
import Foundation

struct Astronauts: Decodable {
    var results: [AstronautsList]
}

struct AstronautsList: Decodable {
    var id: Int
    var name: String
    var age: Int
    var profile_image_thumbnail: String
}
