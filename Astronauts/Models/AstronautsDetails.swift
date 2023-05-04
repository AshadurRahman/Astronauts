
import Foundation

struct AstronautDetails: Decodable {
    var name: String
    var profile_image: String
    var flights: [Flights]
}

struct Flights: Hashable, Decodable {
    var name: String
}
