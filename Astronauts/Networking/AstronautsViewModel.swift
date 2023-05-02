
import Foundation

@MainActor
class AstronautsViewModel: ObservableObject {
    struct Astronauts: Codable {
        var count: Int
        var next: String
        var results: [AstronautsList]
    }
    
    @Published var urlString = "https://ll.thespacedevs.com/2.2.0/astronaut/"
    @Published var count = 0
    @Published var astronautsArray: [AstronautsList] = []
    
    func getAstronauts() async {
        print("We are accessing the data from main \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create an URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let astronauts = try? JSONDecoder().decode(Astronauts.self, from: data) else {
                print("JSON Error: could not decode returned data")
                return
            }

            self.count = astronauts.count
            self.urlString = astronauts.next
            self.astronautsArray = astronauts.results
            
        } catch {
            print("Error: could not use url at \(urlString) to get data and response")
        }
    }
}
