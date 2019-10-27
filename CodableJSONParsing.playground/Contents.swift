//: Playground - noun: a place where people can play

import UIKit





import Foundation

// See GitHubServiceManager Class and Job Model Class
// They illustrate downloading a file and turning JSON into a concrete object

// Codable and JSON Parsing was added in Swift 4


// ----------------------------------   THE OLD WAY   ----------------------------------
enum SerializationError: Error {
    case missing(String)
    case invalid(String, Any)
}



// Note: Multiline string introduced in Swift 4 also

// This simulates the JSON Data as we would get it from a server
let blogPost = """
{
  "post1": {
     "title": "The Complete Understanding of Delegate",
     "subtitle": "No more guessing",
     "markdown": "# Title",
     "author: "Bob Lee",
     "tags: ["delegate", "object"]
  },
}
""".data(using: .utf8)! // our data in native (JSON) format

//: Model
struct Post {
    let title: String
    let subtitle: String
    let markdown: String
    let author: String
    let tags: [String]
    
    public init(json: [String: Any]) throws {
        guard let title = json["title"] as? String else {
            throw SerializationError.missing("title")
        }
        
        guard let subtitle = json["subtitle"] as? String else {
            throw SerializationError.missing("subtitle")
        }
        guard let markdown = json["markdown"] as? String else {
            throw SerializationError.missing("markdown")
        }
        
        guard let author = json["author"] as? String else {
            throw SerializationError.missing("author")
        }
        
        guard let tags = json["tags"] as? [String] else {
            throw SerializationError.missing("tags")
        }
        
        self.title = title
        self.subtitle = subtitle
        self.markdown = markdown
        self.author = author
        self.tags = tags
    }
}


// ----------------------------------   THE OLD WAY   ----------------------------------

// ----------------------------------   THE NEW WAY   ----------------------------------


//: Design Model that conforms to Codable Protocol
struct User: Codable {
    var name: String
    var loginMethods: [LoginMethods]
    var numberOfFriends: Int
    
    enum LoginMethods: String, Codable {
        case facebook, instagram, linkedin, twitter
    }
}

// This is a SIMILAR model to User
struct AnotherUser: Codable {
    var fullName: String
    var loginMethods: [LoginMethods]
    var numberOfFriends: Int
    
    enum LoginMethods: String, Codable {
        case facebook, instagram, linkedin, twitter
    }
}
//: Create Object
let bob = User(name: "Bob Lee", loginMethods: [.facebook, .instagram], numberOfFriends : 4)

let newBob = AnotherUser(fullName: "Bob Lee", loginMethods: [.facebook, .instagram], numberOfFriends : 4)





//: ### Encode (Object to JSON)
//: Create Encoder
let jsonEncoder = JSONEncoder()
jsonEncoder.outputFormatting = .prettyPrinted


var data: Data?

do {
    // Here we are doing the MAGIC - converting the bob object into a JSON data stream
    let jsonData = try jsonEncoder.encode(bob)
    data = jsonData
    
    // This is just to see that our conversion actually worked, by printing out the data as a string
    if let jsonString = String(data: jsonData, encoding: .utf8) {
        print("bob : " + jsonString)
    }
    
}

//: ### Decode (JSON to Object)
//: Create Decoder
let jsonDecoder = JSONDecoder()

//: Decode
do {
    // Here we are doing the MAGIC of decoding
    let bob = try jsonDecoder.decode(User.self, from: data!) // See meaning of self below
    
    
    print("Name : \(bob.name)")
    print("Number of friends: \(bob.numberOfFriends)")
} catch(let error) {
    print(error)
}

//: Meaning of `self`
let userType = User.self
userType.init(name: "Bob", loginMethods: [.facebook], numberOfFriends: 4)


//: > It has to look identical --> Less flexible

// ----------------------------------   Another Example with a collection  ----------------------------------
struct Geek: Codable {
    let stackOverFlowId: String
    let name: String
    let platform: String
}

// This JSON has only ONE object
let geek = """
{
 "stackOverFlowId": "bobthedev",
 "name": "bob",
 "platform": "iOS"
}
""".data(using: .utf8)! // our data in native (JSON) format


do {
    let geekBob = try JSONDecoder().decode(Geek.self, from: geek) // Decoding our data
    print(geekBob)
} catch(let error) {
    print(error)
}


//: ### Working with Array Type JSON
//: Create JSON in Array
let geeks = """
[{
 "stackOverFlowId": "bobthedev",
 "name": "Bob",
 "platform": "iOS"
},{
 "stackOverFlowId": "robthedev",
 "name": "Rob",
 "platform": "Android"
},{
 "stackOverFlowId": "nobthedev",
 "name": "Nob",
 "platform": "Backend"
}]
""".data(using: .utf8)! // our data in native format

//: Data to Object (Encode)
do {
    let developers = try JSONDecoder().decode([Geek].self, from: geeks)
    developers.forEach { print($0) }
} catch (let error) {
    print(error)
}


//: Create JSON in Diciontary
let geeksDict = """
{
  "1": {
     "stackOverFlowId": "bobthedev",
     "name": "Bob",
     "platform": "iOS"
  },
  "2": {
     "stackOverFlowId": "robthedev",
     "name": "Rob",
     "platform": "Android"
  },
  "3": {
     "stackOverFlowId": "nobthedev",
     "name": "Nob",
     "platform": "Backend"
  }
}
""".data(using: .utf8)! // our data in native format


//: Data to Object (Encode)
do {
    let geekDictionary = try JSONDecoder().decode([String: Geek].self, from: geeksDict)
    geekDictionary.forEach { print("\($0.key): \($0.value)") } // decoded!!!!!
} catch(let error) {
    print(error)
}

// ----------------------------------  ADVANCED   ----------------------------------
let geek2 = """
{
 "stackOverFlowId": "bobthedev",
 "name": "Bob",
 "platform": "iOS"
}
""".data(using: .utf8)! // our native (JSON) data

//: Customize Coding Keys
struct Geek2: Codable {
    var username: String
    var name: String
    var platform: String
    
    enum CodingKeys: String, CodingKey {
        case username = "stackOverFlowId"
        case name
        case platform
    }
    
}


let geekObject = Geek2(username: "bobthedev", name: "Bob Lee", platform: "iOS")
let encoder = JSONEncoder()
//: Encode Object to JSON
do {
    let data = try encoder.encode(geekObject)
    print(String(data: data, encoding: .utf8)!)
} catch (let error) {
    print(error)
}


//: Fully Customize by conforming to `Encodable`
struct Blog {
    let author: String
    let id: Int
    let url: URL
    
    enum BlogCodingKeys: String, CodingKey { // declaring our keys
        case author
        case id
        case url
    }
}

extension Blog: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlogCodingKeys.self)
        try container.encode(author, forKey: .author)
        try container.encode(id, forKey: .id)
        try container.encode(url, forKey: .url)
    }
}
//: Create Object
let post = Blog(author: "Bob", id: 1, url: URL(string: "https://www.bobthedeveloper.io")!)

//: Encode (Object to JSON)
do {
    let myBlog = try JSONEncoder().encode(post)
    
    
    let string = String(data: myBlog, encoding: .utf8)
    print(string ?? "NO STRING")
} catch(let error) {
    print(error)
}

//: Customizing Decode
struct User2 {
    let name: String
    let citizenship: String
    let id: Int
    
    init(name: String, citizenship: String, id: Int) {
        self.name = name
        self.citizenship = citizenship
        self.id = id
    }
}

extension User2: Decodable {
    enum UserCodingKeys: String, CodingKey {
        case name
        case id
        case citizenship
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        // let citizenship: String = try container.decode(String.self, forKey: .citizenship)  // Commented out because it is not used
        let id: Int = try container.decode(Int.self, forKey: .id)
        self.init(name: name, citizenship: "Republic of Korea", id: id)
    }
}



let userBobData = """
{
 "name": "Bob Lee",
 "id": 1,
 "citizenship": "Republic of Korea"
}
""".data(using: .utf8)!

do {
    let userBob = try JSONDecoder().decode(User2.self, from: userBobData)
    print(userBob)
} catch (let error) {
    print(error)
}

