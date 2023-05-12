
import Foundation

@MainActor
class AstronautDetailsViewModel: ObservableObject {
    
    private var urlString = "https://ll.thespacedevs.com/2.2.0/astronaut/"
    @Published var name = ""
    @Published var profile_image = ""
    @Published var flightsArray: [Flights] = []
    @Published var isLoading = false
    
    func getAstronautDetails(id: Int) async {
        urlString = urlString + String("\(id)")
        print("We are accessing the data from \(urlString)")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create an URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let astronaut = try? JSONDecoder().decode(AstronautDetails.self, from: data) else {
                print("JSON Error: could not decode returned data")
                isLoading = false
                return
            }
            self.name = astronaut.name
            self.profile_image = astronaut.profile_image
            self.flightsArray = astronaut.flights
            isLoading = false
            
        } catch {
            isLoading = false
            print("Error: could not use url at \(urlString) to get data and response")
        }
    }
}
