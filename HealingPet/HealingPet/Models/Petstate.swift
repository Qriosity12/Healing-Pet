import Foundation

enum PetState {
    case idle
    case happy
    case comfort
}

extension PetState {
    var imageName: String {
        switch self {
        case .idle:
            return "pet_neutral"
        case .happy:
            return "pet_happy"
        case .comfort:
            return "pet_neutral"
        }
    }
}
