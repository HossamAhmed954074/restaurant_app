# Restaurant App 🍽️

A comprehensive Flutter application for restaurant food ordering with modern UI/UX, real-time features, and complete user management system.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-039BE5?style=for-the-badge&logo=Firebase&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)

## 📱 App Overview

This is a feature-rich restaurant application built with Flutter that provides a seamless food ordering experience. The app includes user authentication, menu browsing, cart management, order tracking, and comprehensive user profile management.

## ✨ Key Features

### 🔐 Authentication System
- **User Registration**: Create new accounts with email and password
- **Login/Logout**: Secure authentication with Firebase Auth
- **Password Reset**: Email-based password reset functionality
- **Remember Me**: Option to stay logged in
- **Account Management**: Update profile, change password, delete account

### 🏠 Home & Menu Features
- **Welcome Screen**: Attractive onboarding experience with app introduction
- **Get Started**: Easy entry point for new users
- **Category Navigation**: Browse food by categories (Pizza, Burger, Sushi, Salad, Dessert, Drinks, Pasta, Sandwich)
- **Menu Items Display**: Grid and list view options for menu items
- **Search Functionality**: Search for specific food items
- **Item Details**: Detailed view with description, price, rating, preparation time
- **Promotional Banners**: Featured items and special offers

### 🛒 Shopping Cart & Orders
- **Add to Cart**: Smooth animations when adding items to cart
- **Quantity Selection**: Adjust item quantities (1-99 items)
- **Order Notes**: Add special instructions for orders
- **Cart Management**: View, modify, and remove items from cart
- **Order Tracking**: Three-stage order tracking system:
  - **Pending**: Orders waiting for confirmation
  - **In Progress**: Orders being prepared
  - **Completed**: Finished orders
- **Order History**: View past orders and reorder favorites
- **Swipe Actions**: Delete orders with swipe gestures

### 👤 User Profile Management
- **Profile Information**: Display user name, email, and account status
- **Update Username**: Change display name
- **Change Password**: Secure password updates with current password verification
- **Account Deletion**: Permanently delete account with confirmation
- **Profile Refresh**: Pull-to-refresh profile data
- **Account Status**: Visual indicators for verified/unverified accounts

### 🎨 UI/UX Features
- **Modern Design**: Clean, intuitive interface with smooth animations
- **Responsive Layout**: Optimized for both phones and tablets
- **Dark/Light Theme**: Attractive color schemes
- **Haptic Feedback**: Enhanced user interaction with vibrations
- **Loading States**: Professional loading indicators and animations
- **Error Handling**: User-friendly error messages and recovery options
- **Navigation**: Bottom navigation with animated transitions

## 🏗️ Technical Architecture

### 📁 Project Structure
```
lib/
├── core/
│   ├── config/           # App configuration
│   ├── errors/           # Error handling and custom exceptions
│   ├── helper/           # Helper functions and utilities
│   ├── router/           # Navigation and routing
│   ├── services/         # Backend services (Auth, Orders, Items)
│   └── utils/            # Utilities and common widgets
├── features/
│   ├── auth/             # Authentication screens and logic
│   ├── bottom_nave/      # Bottom navigation system
│   ├── cart/             # Shopping cart and order management
│   ├── details/          # Item details and ordering
│   ├── get_started/      # Welcome screens
│   ├── home/             # Home screen and menu display
│   ├── onboarding/       # App introduction screens
│   └── profile/          # User profile management
└── generated/            # Auto-generated assets and files
```

### 🏛️ Architecture Pattern
- **BLoC (Business Logic Component)**: State management with flutter_bloc
- **Clean Architecture**: Separation of concerns with clear layers
- **Repository Pattern**: Data access abstraction
- **Cubit**: Simplified state management for complex features

### 🔧 State Management
The app uses **BLoC/Cubit** pattern for state management:

- **AuthCubit**: Handles authentication states (login, register, logout)
- **HomeCubit**: Manages menu items and categories
- **OrderCubit**: Controls order creation and management
- **CartOrdersCubit**: Manages cart and order states
- **ProfileCubit**: Handles user profile operations

## 🛠️ Technologies Used

### 📱 Flutter & Dart
- **Flutter SDK**: Cross-platform mobile development
- **Dart**: Programming language

### 🔥 Firebase Services
- **Firebase Auth**: User authentication and management
- **Cloud Firestore**: NoSQL database for menu items and orders
- **Firebase Core**: Core Firebase functionality

### 📦 Key Dependencies
```yaml
dependencies:
  # State Management
  bloc: ^9.0.0
  flutter_bloc: ^9.1.1
  
  # Firebase
  firebase_core: ^3.15.1
  firebase_auth: ^5.6.2
  cloud_firestore: ^5.6.11
  
  # Navigation
  go_router: ^16.0.0
  
  # UI Components
  cached_network_image: ^3.4.1
  google_fonts: ^6.2.1
  smooth_page_indicator: ^1.2.1
  curved_navigation_bar: ^1.0.6
  add_to_cart_animation: ^2.0.4
  flutter_slidable: ^4.0.0
  
  # Utilities
  shared_preferences: ^2.5.3
  connectivity_plus: ^6.1.4
  loading_indicator: ^3.1.1
  font_awesome_flutter: ^10.8.0
```

## 🍕 Menu Categories

The app features 8 main food categories:

1. **🍕 Pizza** - Margherita, Pepperoni, BBQ Chicken, Veggie Supreme, Hawaiian, Meat Lovers
2. **🍔 Burger** - Cheeseburger, Double Cheeseburger, Veggie Burger, Spicy Chicken, Bacon, Fish
3. **🍣 Sushi** - California Roll, Spicy Tuna Roll, Salmon Nigiri, Ebi Nigiri, Dragon Roll, Tempura Roll
4. **🥗 Salad** - Garden Salad, Caesar Salad, Greek Salad, Caprese Salad, Quinoa Salad, Fruit Salad
5. **🍰 Dessert** - Chocolate Cake, Cheesecake, Apple Pie, Ice Cream Sundae, Brownies, Fruit Tart
6. **🥤 Drinks** - Coca Cola, Lemonade, Iced Tea, Orange Juice, Coffee, Smoothie
7. **🍝 Pasta** - Spaghetti Carbonara, Penne Arrabbiata, Fettuccine Alfredo, Lasagna, Pesto Pasta, Seafood Linguine
8. **🥪 Sandwich** - Club Sandwich, BLT, Grilled Cheese, Turkey Avocado, Caprese, Pulled Pork

## 📱 App Screens

### Authentication Flow
- **Onboarding**: 3-screen introduction to app features
- **Get Started**: Welcome screen with app overview
- **Authentication**: Tabbed interface with Login, Register, and Password Reset

### Main Application
- **Home**: Category selection, menu items, search, promotional banners
- **Cart**: Order management with pending, in-progress, and completed sections
- **Profile**: User information, account settings, and app preferences

### Item Management
- **Item Details**: Comprehensive item view with quantity selection and notes
- **Cart Animation**: Smooth add-to-cart animations with visual feedback

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (version 3.8.1 or later)
- Dart SDK
- Android Studio / VS Code
- Firebase project setup

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd resturant_app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a new Firebase project
   - Add Android/iOS apps to your Firebase project
   - Download and add `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Enable Authentication and Firestore in Firebase Console

4. **Run the app**
   ```bash
   flutter run
   ```

### Firebase Configuration

1. **Authentication**
   - Enable Email/Password authentication in Firebase Console
   - Configure password reset templates

2. **Firestore Database**
   - Create collections: `users`, `ListOfMenuItems`
   - Set up security rules for data access

3. **Storage (if using images)**
   - Configure Firebase Storage for menu item images
   - Set up appropriate storage rules

## 🎯 App Flow

### First Time Users
1. **Onboarding**: Introduction to app features
2. **Get Started**: App overview and welcome
3. **Authentication**: Register or login
4. **Home**: Browse menu and categories
5. **Order**: Add items to cart and place orders

### Returning Users
1. **Auto-Login**: Automatic authentication if remembered
2. **Home**: Direct access to menu
3. **Profile**: Manage account and view order history

## 🔒 Security Features

- **Secure Authentication**: Firebase Auth with email verification
- **Password Validation**: Strong password requirements
- **Account Protection**: Re-authentication required for sensitive operations
- **Data Encryption**: All data transmitted securely via HTTPS
- **User Privacy**: Minimal data collection with user consent

## 🎨 Design System

### Color Palette
- **Primary**: Orange (#FF6B35) - Food and appetite stimulating
- **Secondary**: Blue tones for trust and reliability  
- **Success**: Green for confirmations
- **Error**: Red for warnings and errors
- **Background**: Light gray (#F8F9FA) for content areas

### Typography
- **Google Fonts**: Poppins for modern, readable text
- **Font Weights**: Light, Regular, Medium, SemiBold, Bold
- **Responsive Sizing**: Adapts to different screen sizes

### Animations
- **Page Transitions**: Smooth navigation between screens
- **Cart Animations**: Engaging add-to-cart visual feedback
- **Loading States**: Professional loading indicators
- **Micro-interactions**: Button presses, swipes, and haptic feedback

## 📈 Performance Optimizations

- **Image Caching**: Cached network images for faster loading
- **Lazy Loading**: Efficient list rendering for large menus
- **State Management**: Optimized BLoC pattern for minimal rebuilds
- **Memory Management**: Proper disposal of controllers and streams
- **Network Optimization**: Efficient Firebase queries and offline support

## 🧪 Testing & Quality

### Code Quality
- **Linting**: Flutter lints for code consistency
- **Error Handling**: Comprehensive error catching and user feedback
- **Null Safety**: Full null safety implementation
- **Documentation**: Well-documented code with clear comments

### Testing Strategy
- **Widget Tests**: UI component testing
- **Unit Tests**: Business logic validation
- **Integration Tests**: End-to-end user flows

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Hossam Ahmed**
- GitHub: [@HossamAhmed954074](https://github.com/HossamAhmed954074)

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Firebase for backend services
- Open source community for packages and inspiration
- Food industry for design inspiration

---

## 📞 Support

If you have any questions or need support, please:
1. Check the [Issues](../../issues) section
2. Create a new issue with detailed description
3. Contact the developer directly

---

**Made with ❤️ and Flutter**
