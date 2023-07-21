//
//  Service.swift
//  ToDoList
//
//  Created by Kiet Truong on 28/06/2023.
//

import Foundation

@propertyWrapper
struct Service<Service> {
    
    var service: Service
    
    init(_ serviceType: ServiceType = .newInstance) {
        guard let service = ServiceContainer.resolve(serviceType: serviceType, Service.self) else {
            let serviceName = String(describing: Service.self)
            fatalError("No dependency of type \(serviceName) registered!")
        }
        self.service = service
    }
    
    var wrappedValue: Service {
        get { service }
        mutating set { service = newValue }
    }
}
