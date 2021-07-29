// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class PostsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Posts {
      posts {
        __typename
        id
        title
        image {
          __typename
          url
        }
        tags {
          __typename
          name
        }
        post_type {
          __typename
        }
        is_paid
        published_at
      }
    }
    """

  public let operationName: String = "Posts"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("posts", type: .list(.object(Post.selections))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(posts: [Post?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "posts": posts.flatMap { (value: [Post?]) -> [ResultMap?] in value.map { (value: Post?) -> ResultMap? in value.flatMap { (value: Post) -> ResultMap in value.resultMap } } }])
    }

    public var posts: [Post?]? {
      get {
        return (resultMap["posts"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Post?] in value.map { (value: ResultMap?) -> Post? in value.flatMap { (value: ResultMap) -> Post in Post(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Post?]) -> [ResultMap?] in value.map { (value: Post?) -> ResultMap? in value.flatMap { (value: Post) -> ResultMap in value.resultMap } } }, forKey: "posts")
      }
    }

    public struct Post: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Post"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
          GraphQLField("title", type: .nonNull(.scalar(String.self))),
          GraphQLField("image", type: .object(Image.selections)),
          GraphQLField("tags", type: .list(.object(Tag.selections))),
          GraphQLField("post_type", type: .nonNull(.list(.object(PostType.selections)))),
          GraphQLField("is_paid", type: .nonNull(.scalar(Bool.self))),
          GraphQLField("published_at", type: .scalar(String.self)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID, title: String, image: Image? = nil, tags: [Tag?]? = nil, postType: [PostType?], isPaid: Bool, publishedAt: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Post", "id": id, "title": title, "image": image.flatMap { (value: Image) -> ResultMap in value.resultMap }, "tags": tags.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, "post_type": postType.map { (value: PostType?) -> ResultMap? in value.flatMap { (value: PostType) -> ResultMap in value.resultMap } }, "is_paid": isPaid, "published_at": publishedAt])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID {
        get {
          return resultMap["id"]! as! GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var title: String {
        get {
          return resultMap["title"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "title")
        }
      }

      public var image: Image? {
        get {
          return (resultMap["image"] as? ResultMap).flatMap { Image(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "image")
        }
      }

      public var tags: [Tag?]? {
        get {
          return (resultMap["tags"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Tag?] in value.map { (value: ResultMap?) -> Tag? in value.flatMap { (value: ResultMap) -> Tag in Tag(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Tag?]) -> [ResultMap?] in value.map { (value: Tag?) -> ResultMap? in value.flatMap { (value: Tag) -> ResultMap in value.resultMap } } }, forKey: "tags")
        }
      }

      public var postType: [PostType?] {
        get {
          return (resultMap["post_type"] as! [ResultMap?]).map { (value: ResultMap?) -> PostType? in value.flatMap { (value: ResultMap) -> PostType in PostType(unsafeResultMap: value) } }
        }
        set {
          resultMap.updateValue(newValue.map { (value: PostType?) -> ResultMap? in value.flatMap { (value: PostType) -> ResultMap in value.resultMap } }, forKey: "post_type")
        }
      }

      public var isPaid: Bool {
        get {
          return resultMap["is_paid"]! as! Bool
        }
        set {
          resultMap.updateValue(newValue, forKey: "is_paid")
        }
      }

      public var publishedAt: String? {
        get {
          return resultMap["published_at"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "published_at")
        }
      }

      public struct Image: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["UploadFile"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("url", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(url: String) {
          self.init(unsafeResultMap: ["__typename": "UploadFile", "url": url])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var url: String {
          get {
            return resultMap["url"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "url")
          }
        }
      }

      public struct Tag: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Tag"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("name", type: .scalar(String.self)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(name: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Tag", "name": name])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }
      }

      public struct PostType: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ComponentPostTypeStory", "ComponentPostTypeTheory", "ComponentPostTypeVideo", "ComponentPostTypeVideoCourse"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public static func makeComponentPostTypeStory() -> PostType {
          return PostType(unsafeResultMap: ["__typename": "ComponentPostTypeStory"])
        }

        public static func makeComponentPostTypeTheory() -> PostType {
          return PostType(unsafeResultMap: ["__typename": "ComponentPostTypeTheory"])
        }

        public static func makeComponentPostTypeVideo() -> PostType {
          return PostType(unsafeResultMap: ["__typename": "ComponentPostTypeVideo"])
        }

        public static func makeComponentPostTypeVideoCourse() -> PostType {
          return PostType(unsafeResultMap: ["__typename": "ComponentPostTypeVideoCourse"])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }
      }
    }
  }
}
