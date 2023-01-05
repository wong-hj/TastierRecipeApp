

import Foundation

public enum RegisterAlert {
    case empty, unmatch, error, success
}

public enum LoginAlert {
    case success, error, empty
}

public enum Categories: String, CaseIterable {
    case dessert, western, fried, beverage, eastern
}
