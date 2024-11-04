//
//  TestData.swift
//  LeagueMobileChallenge
//
//  Created by Steven Rockarts on 2024-11-03.
//
@testable import LeagueMobileChallenge

// Test Data Helper
struct TestData {
    static let users: [User] = [
        User(
            id: 1,
            avatar: "https://i.pravatar.cc/150?u=1",
            name: "Leanne Graham",
            username: "Bret",
            email: "Sincere@april.biz",
            address: User.Address(
                street: "Kulas Light",
                suite: "Apt. 556",
                city: "Gwenborough",
                zipcode: "92998-3874",
                geo: User.Address.Geo(lat: "-37.3159", lng: "81.1496")
            ),
            phone: "1-770-736-8031 x56442",
            website: "hildegard.org",
            company: User.Company(
                name: "Romaguera-Crona",
                catchPhrase: "Multi-layered client-server neural-net",
                bs: "harness real-time e-markets"
            )
        ),
        User(
            id: 2,
            avatar: "https://i.pravatar.cc/150?u=2",
            name: "Ervin Howell",
            username: "Antonette",
            email: "Shanna@melissa.tv",
            address: User.Address(
                street: "Victor Plains",
                suite: "Suite 879",
                city: "Wisokyburgh",
                zipcode: "90566-7771",
                geo: User.Address.Geo(lat: "-43.9509", lng: "-34.4618")
            ),
            phone: "010-692-6593 x09125",
            website: "anastasia.net",
            company: User.Company(
                name: "Deckow-Crist",
                catchPhrase: "Proactive didactic contingency",
                bs: "synergize scalable supply-chains"
            )
        ),
        User(
            id: 3,
            avatar: "https://i.pravatar.cc/150?u=3",
            name: "Clementine Bauch",
            username: "Samantha",
            email: "Nathan@yesenia.net",
            address: User.Address(
                street: "Douglas Extension",
                suite: "Suite 847",
                city: "McKenziehaven",
                zipcode: "59590-4157",
                geo: User.Address.Geo(lat: "-68.6102", lng: "-47.0653")
            ),
            phone: "1-463-123-4447",
            website: "ramiro.info",
            company: User.Company(
                name: "Romaguera-Jacobson",
                catchPhrase: "Face to face bifurcated interface",
                bs: "e-enable strategic applications"
            )
        )
    ]
    
    static let posts: [Post] = [
        Post(
            userId: 1,
            id: 1,
            title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            body: "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
        ),
        Post(
            userId: 1,
            id: 2,
            title: "qui est esse",
            body: "est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla"
        ),
        Post(
            userId: 2,
            id: 11,
            title: "et ea vero quia laudantium autem",
            body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus accusamus in eum beatae sit vel qui neque voluptates ut commodi qui incidunt ut animi commodi"
        ),
        Post(
            userId: 2,
            id: 12,
            title: "in quibusdam tempore odit est dolorem",
            body: "itaque id aut magnam praesentium quia et ea odit et ea voluptas et sapiente quia nihil amet occaecati quia id voluptatem incidunt ea est distinctio odio"
        ),
        Post(
            userId: 3,
            id: 21,
            title: "asperiores ea ipsam voluptatibus modi minima quia sint",
            body: "repellat aliquid praesentium dolorem quo sed totam minus non itaque nihil labore molestiae sunt dolor eveniet hic recusandae veniam tempora et tenetur expedita sunt"
        )
    ]
    
    static let userPosts: [UserPosts] = [
        UserPosts(
            postId: 1,
            userId: 1,
            title: "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            body: "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto",
            username: "Leanne Graham",
            avatarImage: "https://i.pravatar.cc/150?u=1"
        ),
        UserPosts(
            postId: 2,
            userId: 1,
            title: "qui est esse",
            body: "est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla",
            username: "Leanne Graham",
            avatarImage: "https://i.pravatar.cc/150?u=1"
        ),
        UserPosts(
            postId: 11,
            userId: 2,
            title: "et ea vero quia laudantium autem",
            body: "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus accusamus in eum beatae sit vel qui neque voluptates ut commodi qui incidunt ut animi commodi",
            username: "Ervin Howell",
            avatarImage: "https://i.pravatar.cc/150?u=2"
        ),
        UserPosts(
            postId: 12,
            userId: 2,
            title: "in quibusdam tempore odit est dolorem",
            body: "itaque id aut magnam praesentium quia et ea odit et ea voluptas et sapiente quia nihil amet occaecati quia id voluptatem incidunt ea est distinctio odio",
            username: "Ervin Howell",
            avatarImage: "https://i.pravatar.cc/150?u=2"
        ),
        UserPosts(
            postId: 21,
            userId: 3,
            title: "asperiores ea ipsam voluptatibus modi minima quia sint",
            body: "repellat aliquid praesentium dolorem quo sed totam minus non itaque nihil labore molestiae sunt dolor eveniet hic recusandae veniam tempora et tenetur expedita sunt",
            username: "Clementine Bauch",
            avatarImage: "https://i.pravatar.cc/150?u=3"
        )
    ]
    
    // JSON string representations for testing
    static let usersJSON = """
    [
        {
            "id": 1,
            "avatar": "https://i.pravatar.cc/150?u=1",
            "name": "Leanne Graham",
            "username": "Bret",
            "email": "Sincere@april.biz",
            "address": {
                "street": "Kulas Light",
                "suite": "Apt. 556",
                "city": "Gwenborough",
                "zipcode": "92998-3874",
                "geo": {
                    "lat": "-37.3159",
                    "lng": "81.1496"
                }
            },
            "phone": "1-770-736-8031 x56442",
            "website": "hildegard.org",
            "company": {
                "name": "Romaguera-Crona",
                "catchPhrase": "Multi-layered client-server neural-net",
                "bs": "harness real-time e-markets"
            }
        },
        {
            "id": 2,
            "avatar": "https://i.pravatar.cc/150?u=2",
            "name": "Ervin Howell",
            "username": "Antonette",
            "email": "Shanna@melissa.tv",
            "address": {
                "street": "Victor Plains",
                "suite": "Suite 879",
                "city": "Wisokyburgh",
                "zipcode": "90566-7771",
                "geo": {
                    "lat": "-43.9509",
                    "lng": "-34.4618"
                }
            },
            "phone": "010-692-6593 x09125",
            "website": "anastasia.net",
            "company": {
                "name": "Deckow-Crist",
                "catchPhrase": "Proactive didactic contingency",
                "bs": "synergize scalable supply-chains"
            }
        }
    ]
    """
    
    static let postsJSON = """
    [
        {
            "userId": 1,
            "id": 1,
            "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
            "body": "quia et suscipit suscipit recusandae consequuntur expedita et cum reprehenderit molestiae ut ut quas totam nostrum rerum est autem sunt rem eveniet architecto"
        },
        {
            "userId": 1,
            "id": 2,
            "title": "qui est esse",
            "body": "est rerum tempore vitae sequi sint nihil reprehenderit dolor beatae ea dolores neque fugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis qui aperiam non debitis possimus qui neque nisi nulla"
        },
        {
            "userId": 2,
            "id": 11,
            "title": "et ea vero quia laudantium autem",
            "body": "delectus reiciendis molestiae occaecati non minima eveniet qui voluptatibus accusamus in eum beatae sit vel qui neque voluptates ut commodi qui incidunt ut animi commodi"
        }
    ]
    """
    
    static let apiKeyJSON = """
    {
        "api_key": "5ECDDC3A21CE53428227A2125B7FCC71"
    }
    """
}
