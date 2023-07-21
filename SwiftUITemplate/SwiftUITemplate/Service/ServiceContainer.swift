//
//  ServiceContainer.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import Foundation

class ServiceContainer {
    
    private static var generators: [String: () -> Any] = [:]
    private static var cache: [String: Any] = [:]
    
    static func register<Service>(type: Service.Type, _ factory: @autoclosure @escaping () -> Service) {
        generators[String(describing: type.self)] = factory
    }
    
    static func resolve<Service>(serviceType: ServiceType = .automatic, _ type: Service.Type) -> Service? {
        let key = String(describing: type.self)
        
        switch serviceType {
        case .singleton:
            if let cachedService = cache[key] as? Service {
                return cachedService
            } else {
                fatalError("\(String(describing: type.self)) is not registeres as singleton")
            }
            
        case .automatic:
            if let cachedService = cache[key] as? Service {
                return cachedService
            }
            fallthrough
            
        case .newInstance:
            if let service = generators[key]?() as? Service {
                cache[String(describing: type.self)] = service
                return service
            } else {
                return nil
            }
        }
    }
}

