//
//  UserDetailView.swift
//  FriendFace
//
//  Created by He Wu on 2021/10/11.
//

import SwiftUI

struct UserKeyValueView: View {
    var key: String
    var value: String
    
    var body: some View {
        HStack {
            Text(key)
                .frame(width: 120, alignment: .leading)
                .font(.headline)
            Text(value)
        }
    }
}

struct UserDetailView: View {
    var user: User
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("User Information")) {
                    UserKeyValueView(
                        key: "Active User?",
                        value: user.isActive ? "YES" : "NO"
                    )
                    
                    UserKeyValueView(
                        key: "Age",
                        value: "\(user.age)"
                    )
                    
                    UserKeyValueView(
                        key: "Company",
                        value: user.company
                    )
                    
                    UserKeyValueView(
                        key: "Email",
                        value: user.email
                    )
                    
                    UserKeyValueView(
                        key: "Address",
                        value: user.address
                    )
                    
                    UserKeyValueView(
                        key: "Registered",
                        value: user.registered
                    )
                }
                
                Section(header: Text("About")) {
                    Text(user.about)
                }
                
                Section(header: Text("Tags")) {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding()
                                    .frame(minWidth: 100)
                                    .foregroundColor(.white)
                                    .font(.headline)
                                    .background(Color(.orange))
                                    .clipShape(Capsule())
                            }
                        }
                    }
                }
                
                Section(header: Text("Friends List")) {
                    List(user.friends, id: \Friend.id) { friend in
                        Text(friend.name)
                    }
                }
            }
        }
        .navigationBarTitle(Text(user.name))
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        UserDetailView(
            user: User(
                id: "eccdf4b8-c9f6-4eeb-8832-28027eb70155",
                isActive: true,
                name: "Gale Dyer",
                age: 28,
                company: "Cemention",
                email: "galedyer@cemention.com",
                address: "652 Gatling Place, Kieler, Arizona, 1705",
                about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.\r\n",
                registered: "2014-07-05T04:25:04-01:00",
                tags: [
                    "irure",
                    "labore",
                    "et",
                    "sint",
                    "velit",
                    "mollit",
                    "et"
                ],
                friends: [
                    Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6292", name: "Daisy Bond"),
                    Friend(id: "a1ef63f3-0eab-49a8-a13a-e538f6d1c4f9", name: "Tanya Roberson"),
                ]
            )
        )
    }
}
