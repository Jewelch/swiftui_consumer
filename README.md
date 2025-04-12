# SwiftUI_Consumer

A lightweight, protocol-oriented networking layer for iOS applications that enforces clean architecture principles.

## Features

- 🏗 Clean Architecture Support
- 🔄 Built-in DAO/DTO Pattern
- 🌐 RESTful API Integration
- 💉 Dependency Injection Ready
- 🧩 Protocol-Oriented Design
- 🔒 Type-Safe Data Mapping
- ⚡️ Combine Framework Integration

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "your-repository-url", from: "1.0.0")
]
```

## Core Components

### Data Layer

#### Model (DAO)
```swift
public protocol Model: Codable & Hashable {}

// Example
struct UserModel: Model {
    let id: Int
    let name: String
}
```

#### Entity (DTO)
```swift
public protocol Entity: Equatable & Identifiable {
    associatedtype M: Model
    static func fromModel(_ model: M?) -> Self
}

// Example
struct User: Entity {
    let id: String
    let name: String
    
    static func fromModel(_ model: UserModel?) -> User {
        User(id: UUID().uuidString, 
             name: model?.name ?? "")
    }
}
```

#### DataSource
```swift
struct UserDataSource: DataSource {
    typealias M = UserModel
    
    func getUser(id: Int) -> DataSourceResult<M> {
        perform(urlComponents: .init(
            path: "users/\(id)",
            method: .get
        ))
    }
}
```

### Domain Layer

#### UseCase
```swift
final class GetUserUC: UseCase<UserModel, User> {
    init(dataSource: UserDataSource) {
        super.init(
            dataSourceFetcher: { params in
                guard let id = params as? Int else {
                    return Fail(error: NSError()).eraseToAnyPublisher()
                }
                return dataSource.getUser(id: id)
            }
        )
    }
}
```

## Usage Example

```swift
// 1. Create your Model (DAO)
struct ProductModel: Model {
    let id: Int
    let name: String
    let price: Double
}

// 2. Create your Entity (DTO)
struct Product: Entity {
    let id: String
    let name: String
    let price: Double
    
    static func fromModel(_ model: ProductModel?) -> Product {
        Product(
            id: UUID().uuidString,
            name: model?.name ?? "",
            price: model?.price ?? 0.0
        )
    }
}

// 3. Create your DataSource
struct ProductDataSource: DataSource {
    typealias M = ProductModel
    
    func getProduct(id: Int) -> DataSourceResult<M> {
        perform(urlComponents: .init(
            path: "products/\(id)",
            method: .get
        ))
    }
}

// 4. Create your UseCase
final class GetProductUC: UseCase<ProductModel, Product> {
    init(dataSource: ProductDataSource) {
        super.init(
            dataSourceFetcher: { params in
                guard let id = params as? Int else {
                    return Fail(error: NSError()).eraseToAnyPublisher()
                }
                return dataSource.getProduct(id: id)
            }
        )
    }
}

// 5. Use in your ViewModel
class ProductViewModel: ObservableObject {
    private let getProduct: GetProductUC
    @Published var product: Product?
    
    init(getProduct: GetProductUC) {
        self.getProduct = getProduct
    }
    
    func loadProduct(id: Int) {
        getProduct.call(id)
            .receive(on: DispatchQueue.main)
            .assign(to: &$product)
    }
}
```

## Configuration

### Environment Setup
```swift
class ConsumerConfig: ConsumerConfiguration {
    var baseApiHost: String {
        switch Application.environment {
        case .prod: return "api.production.com"
        case .staging: return "api.staging.com"
        case .dev: return "api.dev.com"
        }
    }
    
    var requestTimeoutInterval: TimeInterval {
        return 30
    }
}
```

## Best Practices

1. **DAO/DTO Pattern**
   - Models (DAOs) handle data access and JSON decoding
   - Entities (DTOs) represent clean domain objects for UI

2. **Error Handling**
   - Use proper error types and handling in DataSources
   - Provide meaningful error messages

3. **Memory Management**
   - Use weak self in closures when needed
   - Properly manage Combine subscriptions

4. **Testing**
   - Mock DataSources for unit testing
   - Test error scenarios
   - Validate DTO mapping

## Requirements

- iOS 13.0+
- macOS 10.15+
- tvOS 13.0+
- watchOS 6.0+
- Swift 5.5+


## License & Contact

**Jewel Cheriaa**
- Email: jewelcheriaa@gmail.com
- LinkedIn: [Jewel Cheriaa](https://www.linkedin.com/in/jewel-cheriaa/)
- Mobile: +216 24 226 712
- WhatsApp: +33 7 43 10 44 25

For more information about my Flutter expertise, check out my [Generic Requester](https://github.com/Jewelch/generic_requester) project.

## 6. Developer Profile

### Introduction
Senior iOS & Flutter Developer (TUNISIA) - Bilingual in French and English  
Tech Lead and Software Architect  
Certified Trainer at IQClass and VosCours  
9 years of experience | 50+ applications created | 35+ still available on the App Store

### Technical Expertise
Passionate and results-driven with a strong track record of creating high-quality applications. Expert in:
- Generic programming
- Clean Architecture
- UIKit, SwiftUI, Combine, Swift Concurrency (iOS)
- State Management Patterns (BLoC, Riverpod, Provider, Getx, Mobx, Modular)
- Automation and testing (Unit, UI, Integration, E2E)
- Performance optimization
- Code maintainability
- Complex system integration

### Notable Applications
* My Swiss Keeper (Swisse) - [App Store](https://apps.apple.com/fr/app/my-swiss-keeper/id1617620449)
* RTA Dubai (UAE Roads & Transport Authority) (+1M users) - [App Store](https://apps.apple.com/ae/app/rta-dubai/id426109507)
* Maskan (UAE Federal Tax Authority) (+1K users) - [App Store](https://apps.apple.com/us/app/maskan-fta/id6478710219)
* IRP AUTO Santé (FRANCE) (+100K users) - [App Store](https://apps.apple.com/fr/app/irp-auto-sant%C3%A9/id948623366?l=en) | [Play Store](https://play.google.com/store/apps/details?id=com.irpauto.sante&hl=en_US)
* Ville de Marseille (FRANCE) (+10K users) - [App Store](https://apps.apple.com/fr/app/ville-de-marseille/id1267540404?platform=iphone)
* Zenpark - Parkings (FRANCE) (+500K users) - [App Store](https://apps.apple.com/fr/app/zenpark-parkings/id757934388)
* iHealth MyVitals (FRANCE) (+100K users) - [App Store](https://apps.apple.com/us/app/ihealth-myvitals/id1532014748)
* Rides2U (USA) (+4K users) - [App Store](https://apps.apple.com/us/developer/rides2u-llc/id1616957681) | [Play Store](https://play.google.com/store/apps/dev?id=7213610952804159810)
* Halal App (KSA) - [App Store](https://apps.apple.com/us/app/halal-app-%D8%AD%D9%84%D8%A7%D9%84/id1570293278)
* WALLPOST Software (USA) (+2K users) - [App Store](https://apps.apple.com/fr/app/wallpost-software/id1044979110)
* TLFnet (+2K users) - [Play Store](https://play.google.com/store/apps/details?id=com.tlfnet)
* Sketch AI: Drawing to Art (TURKEY) - [App Store](https://apps.apple.com/us/app/sketch-ai-drawing-to-art/id6447612551)
* Aligneurs Français (FRANCE) - [App Store](https://apps.apple.com/fr/app/aligneurs-francais/id1630781596?platform=iphone)
* Turaqi Captain & Client (KSA) - [App Store](https://apps.apple.com/fr/developer/atallah-almotairi/id1535395336)
* CODE: QR & Barcode Reader (FRANCE) - [App Store](https://apps.apple.com/us/app/code-qr-and-barcode-reader/id1073953713)
* KingaSafety (USA) - [App Store](https://apps.apple.com/us/app/kinga-safety/id6443869502)

### Leadership and Expertise
In addition to my technical expertise, I bring strong leadership and teamwork capabilities, having held key positions in several organizations:
- QoreVirtual (USA) - iOS, Android and Flutter Software Architect
- BMW (Germany) - Senior Android Developer
- SCUB (France) - Flutter Tech Lead
- Be-ys Software (France) - Flutter & iOS Tech Lead
- WiMobi (Tunisia) - iOS Tech Lead

### Contact
Senior Mobile App Developer  
Tech Lead / Software Architect / Certified Trainer  
Mobile: +216 24 226 712  
WhatsApp: +33 7 43 10 44 25  
Email: jewelcheriaa@gmail.com 