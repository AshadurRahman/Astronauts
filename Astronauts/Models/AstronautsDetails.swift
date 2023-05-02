
import Foundation

struct AstronautDetails: Codable {
    var name: String
    var profile_image: String
    var flights: [Flights]
}

struct Flights: Hashable, Codable {
    var name: String
}
