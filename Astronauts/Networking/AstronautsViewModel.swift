
import Foundation

@MainActor
class AstronautsViewModel: ObservableObject {
    
    private var urlString = "https://ll.thespacedevs.com/2.2.0/astronaut/"
    @Published var astronautsArray: [AstronautsList] = []
    @Published var isLoading = false
    
    func getAstronauts() async {
        print("We are accessing the data from main \(urlString)")
        isLoading = true
        
        guard let url = URL(string: urlString) else {
            print("Error: could not create an URL from \(urlString)")
            isLoading = false
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let astronauts = try? JSONDecoder().decode(Astronauts.self, from: data) else {
                print("JSON Error: could not decode returned data")
                isLoading = false
                return
            }

            self.astronautsArray = astronauts.results
            isLoading = false
            
        } catch {
            isLoading = false
            print("Error: could not use url at \(urlString) to get data and response")
        }
    }
}
