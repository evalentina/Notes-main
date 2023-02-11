//
//  UserDefaults.swift
//  Notes
//
//  Created by Валентина Евдокимова on 11.02.2023.
//

import Foundation

extension UserDefaults {
    
  func save<T: Codable>(key: String, obj: T) -> Void {
        let data = try? JSONEncoder().encode(obj)
        self.set(data, forKey: key)
  }

  func load<T: Codable>(key: String, obj: T.Type) -> T? {
      guard let data = self.object(forKey: key) as? Data else { return nil }
      let loadedData = try? JSONDecoder().decode(T.self, from: data)
      return loadedData
  }

  func reset() {
      self.removeObject(forKey: Keys.userDefaultsKey)
  }
}

