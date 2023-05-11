
import Foundation
import CoreData

@MainActor
class AstronautsViewModel: ObservableObject {
    
    private var urlString = "https://ll.thespacedevs.com/2.2.0/astronaut/"
    @Published var astronautsArray: [AstronautsList] = []
    @Published var isLoading = false
    
    func saveData(context: NSManagedObjectContext) {
        
        astronautsArray.forEach { (data) in
            
            let entity = AstronautsDataModel(context: context)
            entity.id = Int64(data.id)
            entity.name = data.name
            entity.age = Int64(data.age)
            entity.profile_image_thumbnail = data.profile_image_thumbnail
        }
        
        do {
            try context.save()
            print("Success")
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func getAstronauts(context: NSManagedObjectContext) async {
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
            self.saveData(context: context)
            isLoading = false
            
        } catch {
            isLoading = false
            print("Error: could not use url at \(urlString) to get data and response")
        }
    }
}
