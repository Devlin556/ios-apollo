//  This file was automatically generated and should not be edited.

import Apollo

public struct HashedPassword: GraphQLMapConvertible {
  public var graphQLMap: GraphQLMap

  public init(digest: String, algorithm: String) {
    graphQLMap = ["digest": digest, "algorithm": algorithm]
  }

  /// The hashed password
  public var digest: String {
    get {
      return graphQLMap["digest"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "digest")
    }
  }

  /// Algorithm used to hash the password
  public var algorithm: String {
    get {
      return graphQLMap["algorithm"] as! String
    }
    set {
      graphQLMap.updateValue(newValue, forKey: "algorithm")
    }
  }
}

public final class LoginWithPasswordMutation: GraphQLMutation {
  public static let operationString =
    "mutation loginWithPassword($email: String!, $password: HashedPassword!) {\n  loginWithPassword(email: $email, password: $password) {\n    __typename\n    id\n    token\n  }\n}"

  public var email: String
  public var password: HashedPassword

  public init(email: String, password: HashedPassword) {
    self.email = email
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["email": email, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Mutation"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("loginWithPassword", arguments: ["email": GraphQLVariable("email"), "password": GraphQLVariable("password")], type: .object(LoginWithPassword.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(loginWithPassword: LoginWithPassword? = nil) {
      self.init(snapshot: ["__typename": "Mutation", "loginWithPassword": loginWithPassword.flatMap { $0.snapshot }])
    }

    /// Log the user in with a password.
    public var loginWithPassword: LoginWithPassword? {
      get {
        return (snapshot["loginWithPassword"] as? Snapshot).flatMap { LoginWithPassword(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "loginWithPassword")
      }
    }

    public struct LoginWithPassword: GraphQLSelectionSet {
      public static let possibleTypes = ["LoginMethodResponse"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .nonNull(.scalar(String.self))),
        GraphQLField("token", type: .nonNull(.scalar(String.self))),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(id: String, token: String) {
        self.init(snapshot: ["__typename": "LoginMethodResponse", "id": id, "token": token])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Id of the user logged in user
      public var id: String {
        get {
          return snapshot["id"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "id")
        }
      }

      /// Token of the connection
      public var token: String {
        get {
          return snapshot["token"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "token")
        }
      }
    }
  }
}

public final class MeQuery: GraphQLQuery {
  public static let operationString =
    "query Me {\n  me {\n    __typename\n    email\n  }\n}"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("me", type: .object(Me.selections)),
    ]

    public var snapshot: Snapshot

    public init(snapshot: Snapshot) {
      self.snapshot = snapshot
    }

    public init(me: Me? = nil) {
      self.init(snapshot: ["__typename": "Query", "me": me.flatMap { $0.snapshot }])
    }

    public var me: Me? {
      get {
        return (snapshot["me"] as? Snapshot).flatMap { Me(snapshot: $0) }
      }
      set {
        snapshot.updateValue(newValue?.snapshot, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes = ["User"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("email", type: .scalar(String.self)),
      ]

      public var snapshot: Snapshot

      public init(snapshot: Snapshot) {
        self.snapshot = snapshot
      }

      public init(email: String? = nil) {
        self.init(snapshot: ["__typename": "User", "email": email])
      }

      public var __typename: String {
        get {
          return snapshot["__typename"]! as! String
        }
        set {
          snapshot.updateValue(newValue, forKey: "__typename")
        }
      }

      public var email: String? {
        get {
          return snapshot["email"] as? String
        }
        set {
          snapshot.updateValue(newValue, forKey: "email")
        }
      }
    }
  }
}