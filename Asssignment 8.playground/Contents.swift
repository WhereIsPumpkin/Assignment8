class Book {
    var bookID: Int
    var title: String
    var author: String
    var isBorrowed: Bool
    
    init(bookID: Int, title: String, author: String, isBorrowed: Bool = false) {
        self.bookID = bookID
        self.title = title
        self.author = author
        self.isBorrowed = isBorrowed
    }
    
    func markAsBorrowed() {
        if !isBorrowed {
            isBorrowed = true
            print("\(title) has been borrowed.")
        } else {
            print("\(title) is already borrowed.")
        }
    }
    
    func markAsReturned() {
        if isBorrowed {
            isBorrowed = false
            print("\(title) has been returned.")
        } else {
            print("\(title) is not currently borrowed.")
        }
    }
}

class Owner {
    var ownerId: Int
    var name: String
    var borrowedBooks: [Book]
    
    init(ownerId: Int, name: String) {
        self.ownerId = ownerId
        self.name = name
        self.borrowedBooks = []
    }
    
    func borrowBook(_ book: Book) {
        if !book.isBorrowed {
            book.markAsBorrowed()
            borrowedBooks.append(book)
            print("\(name) has borrowed \(book.title).")
        } else {
            print("\(book.title) is already borrowed by someone else.")
        }
    }
    
    func returnBook(_ book: Book) {
        if let index = borrowedBooks.firstIndex(where: { $0.bookID == book.bookID }) {
            borrowedBooks.remove(at: index)
            book.markAsReturned()
            print("\(name) has returned \(book.title).")
        } else {
            print("\(name) does not have \(book.title) to return.")
        }
    }
}

class Library {
    var books: [Book]
    var owners: [Owner]
    
    init() {
        self.books = []
        self.owners = []
    }
    
    func addBook(_ book: Book) {
        books.append(book)
        print("\(book.title) has been added to the library.")
    }
    
    func addOwner(_ owner: Owner) {
        owners.append(owner)
        print("\(owner.name) has been added as an owner to the library.")
    }
    
    func findAvailableBooks() -> [Book] {
        return books.filter { !$0.isBorrowed }
    }
    
    func findBorrowedBooks() -> [Book] {
        return books.filter { $0.isBorrowed }
    }
    
    func findOwnerById(_ ownerId: Int) -> Owner? {
        return owners.first { $0.ownerId == ownerId }
    }
    
    func findBooksBorrowedByOwner(_ owner: Owner) -> [Book] {
        return owner.borrowedBooks
    }
    
    func allowBorrowBook(_ owner: Owner, _ book: Book) {
        if owner.borrowedBooks.count >= 3 {
            print("\(owner.name) has reached the maximum limit for borrowed books (3).")
            return
        }
        
        if let index = books.firstIndex(where: { $0.bookID == book.bookID }) {
            owner.borrowBook(books[index])
        } else {
            print("\(book.title) is not available in the library.")
        }
    }
}

// შევქმნათ წიგნები
let book1 = Book(bookID: 1, title: "Book 1", author: "Author 1")
let book2 = Book(bookID: 2, title: "Book 2", author: "Author 2")
let book3 = Book(bookID: 3, title: "Book 3", author: "Author 3")

//  შევქმნათ owner
let owner1 = Owner(ownerId: 101, name: "Owner 1")
let owner2 = Owner(ownerId: 102, name: "Owner 2")

// გავაკეთოთ ბიბლიოთეკა
let library = Library()

// დავამატოთ წიგნები ბიბლიოთეკაში
library.addBook(book1)
library.addBook(book2)
library.addBook(book3)
library.addOwner(owner1)
library.addOwner(owner2)

// allow owners to borrow books
library.allowBorrowBook(owner1, book1)
library.allowBorrowBook(owner2, book2)
library.allowBorrowBook(owner1, book3)

// დავაბრუნოთ წიგნები
owner1.returnBook(book1)
owner2.returnBook(book2)

// ინფორმაციის დაბეჭდვა
print("Available Books:")
let availableBooks = library.findAvailableBooks()
for book in availableBooks {
    print("\(book.title) by \(book.author)")
}

print("\nBorrowed Books:")
let borrowedBooks = library.findBorrowedBooks()
for book in borrowedBooks {
    print("\(book.title) by \(book.author)")
}

if let owner = library.findOwnerById(101) {
    print("\nBooks borrowed by Owner 1:")
    let ownerBooks = library.findBooksBorrowedByOwner(owner)
    for book in ownerBooks {
        print("\(book.title) by \(book.author)")
    }
}



// Task #2  ავაწყოთ პატარა E-commerce სისტემა.
print()
print("Task #2 ----------------------------------")
print()

class Product {
    var productID: Int
    var name: String
    var price: Double
    
    init(productID: Int, name: String, price: Double) {
        self.productID = productID
        self.name = name
        self.price = price
    }
}

class Cart {
    var cartID: Int
    var items: [Product]
    
    init(cartID: Int) {
        self.cartID = cartID
        self.items = []
    }
    
    func addProduct(_ product: Product) {
        items.append(product)
    }
    
    func removeProduct(by productID: Int) {
        if let index = items.firstIndex(where: { $0.productID == productID }) {
            items.remove(at: index)
        }
    }
    
    func calculateTotalPrice() -> Double {
        let totalPrice = items.reduce(0.0) { $0 + $1.price }
        return totalPrice
    }
}

class User {
    var userID: Int
    var username: String
    var cart: Cart
    
    init(userID: Int, username: String) {
        self.userID = userID
        self.username = username
        self.cart = Cart(cartID: userID)
    }
    
    func addToCart(_ product: Product) {
        cart.addProduct(product)
    }
    
    func removeFromCart(_ productID: Int) {
        cart.removeProduct(by: productID)
    }
    
    func checkout() -> Double {
        let totalPrice = cart.calculateTotalPrice()
        print("\(username) is checking out. Total amount to pay: $\(totalPrice)")
        cart.items.removeAll()
        return totalPrice
    }
}

// გავაკეთოთ იმიტაცია და ვამუშაოთ ჩვენი ობიექტები ერთად.

let product1 = Product(productID: 1, name: "Product 1", price: 10.99)
let product2 = Product(productID: 2, name: "Product 2", price: 5.99)
let product3 = Product(productID: 3, name: "Product 3", price: 7.49)

let user1 = User(userID: 101, username: "User 1")
let user2 = User(userID: 102, username: "User 2")

user1.addToCart(product1)
user1.addToCart(product2)
user2.addToCart(product2)
user2.addToCart(product3)

print("User 1 Cart Total Price: $\(user1.cart.calculateTotalPrice())")
print("User 2 Cart Total Price: $\(user2.cart.calculateTotalPrice())")

let totalAmountUser1 = user1.checkout()
let totalAmountUser2 = user2.checkout()

print("User 1 paid: $\(totalAmountUser1)")
print("User 2 paid: $\(totalAmountUser2)")

