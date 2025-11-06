# 🎓 Hustle - Full Stack Course Learning Platform

## 📋 Project Overview

**Hustle** is a complete, production-ready Udemy clone built from scratch with modern technologies. It's a full-stack mobile application that allows users to browse courses, make purchases, and learn through video content.

### 🌟 What Makes This Project Special

- ✅ **100% Functional** - Not a demo, fully working end-to-end
- 🎨 **Professional UI/UX** - Material Design 3 with beautiful animations
- 💳 **Real Payment Integration** - Stripe payment gateway
- 🔐 **Secure Authentication** - JWT-based auth system
- 📱 **Production Ready** - Can be deployed to app stores
- 🎥 **Video Streaming** - Full-featured video player
- 🛒 **E-commerce Features** - Shopping cart and checkout flow

## 🏗️ Architecture

### Frontend (Flutter)
```
Mobile App (Flutter/Dart)
├── Authentication (Login/Register)
├── Course Browsing (Search/Filter)
├── Course Details (Preview)
├── Shopping Cart
├── Stripe Payment
├── Video Player (Enrolled Courses)
└── User Profile
```

### Backend (Node.js/Express)
```
REST API (Node.js/Express)
├── Auth Routes (JWT)
├── Course Routes (CRUD)
├── Payment Routes (Stripe)
├── MongoDB Database
└── Middleware (Auth, Validation)
```

## 📊 Database Schema

### Users Collection
- Personal info (name, email, password hash)
- Enrolled courses (references)
- Instructor flag
- Profile image

### Courses Collection
- Course details (title, description, price)
- Instructor (reference to User)
- Lessons (embedded documents)
- Category, level, ratings
- Requirements & learning outcomes

### Payments Collection
- User reference
- Course references
- Payment intent ID (Stripe)
- Amount & status

## 🎯 Key Features Breakdown

### 1. Authentication System
- **Registration**: Email validation, password hashing (bcrypt)
- **Login**: JWT token generation (30-day expiry)
- **Protected Routes**: Middleware-based authorization
- **State Persistence**: Tokens stored securely

### 2. Course Management
- **Browse**: Grid view with search and category filters
- **Details**: Comprehensive course information page
- **Lessons**: Organized video content with metadata
- **Instructor Info**: Profile and course count

### 3. Payment System
- **Cart**: Add/remove courses, calculate totals
- **Stripe Integration**: Payment intents API
- **Secure Checkout**: PCI-compliant payment flow
- **Enrollment**: Automatic course access after payment

### 4. Video Player
- **Streaming**: Network video playback
- **Controls**: Play/pause, seek, fullscreen
- **Lesson Navigation**: Switch between videos
- **Progress Tracking**: Track watched lessons

## 📦 Project Files

### Flutter App (31 files)
```
lib/
├── main.dart                           # App entry point
├── core/
│   ├── routes/app_router.dart         # Navigation
│   └── theme/app_theme.dart           # Styling
├── models/
│   ├── user_model.dart
│   ├── course_model.dart
│   └── cart_model.dart
├── services/
│   └── api_service.dart               # HTTP client
├── features/
│   ├── auth/
│   │   ├── providers/auth_provider.dart
│   │   ├── screens/login_screen.dart
│   │   └── screens/register_screen.dart
│   ├── home/
│   │   └── screens/home_screen.dart
│   ├── courses/
│   │   ├── providers/course_provider.dart
│   │   ├── screens/course_detail_screen.dart
│   │   ├── screens/my_courses_screen.dart
│   │   └── screens/course_player_screen.dart
│   ├── cart/
│   │   ├── providers/cart_provider.dart
│   │   └── screens/cart_screen.dart
│   └── profile/
│       └── screens/profile_screen.dart
└── widgets/
    └── course_card.dart
```

### Backend API (10 files)
```
backend/
├── server.js                          # Express server
├── seed.js                            # Sample data
├── models/
│   ├── User.js
│   ├── Course.js
│   └── Payment.js
├── routes/
│   ├── auth.js
│   ├── courses.js
│   └── payment.js
└── middleware/
    └── auth.js
```

### Configuration & Documentation (8 files)
```
├── README.md                          # Main documentation
├── QUICK_START.md                     # Fast setup guide
├── API_DOCUMENTATION.md               # API reference
├── .env                              # Flutter config
├── backend/.env                       # Backend config
├── pubspec.yaml                       # Flutter dependencies
├── backend/package.json               # Node dependencies
└── setup-backend.ps1                  # Setup script
```

## 🔒 Security Features

1. **Password Hashing**: bcryptjs with salt rounds
2. **JWT Tokens**: Signed with secret key
3. **Protected Routes**: Middleware validation
4. **Input Validation**: express-validator
5. **CORS**: Configured for security
6. **Stripe**: PCI-compliant payment processing
7. **Environment Variables**: Sensitive data protection

## 🚀 Performance Optimizations

1. **Image Caching**: cached_network_image package
2. **Lazy Loading**: Pagination support in API
3. **State Management**: Efficient Provider pattern
4. **Database Indexing**: MongoDB indexes on queries
5. **JWT Expiry**: 30-day tokens to reduce auth calls
6. **Video Streaming**: Network URLs (no local storage)

## 📱 Supported Platforms

- ✅ Android (API 21+)
- ✅ iOS (iOS 11+)
- ✅ Web (with minor adjustments)

## 🛠️ Technologies Used

### Frontend
| Technology | Purpose |
|-----------|---------|
| Flutter 3.0+ | Cross-platform framework |
| Dart | Programming language |
| Provider | State management |
| go_router | Navigation |
| http/dio | API calls |
| flutter_stripe | Payment processing |
| video_player | Video playback |
| chewie | Video player UI |
| cached_network_image | Image caching |
| google_fonts | Typography |

### Backend
| Technology | Purpose |
|-----------|---------|
| Node.js 18+ | Runtime environment |
| Express.js | Web framework |
| MongoDB | Database |
| Mongoose | ODM |
| JWT | Authentication |
| bcryptjs | Password hashing |
| Stripe | Payment gateway |
| express-validator | Input validation |
| CORS | Cross-origin requests |

## 📈 Scalability Considerations

### Current Setup (Development)
- Single server instance
- Local MongoDB
- File-based environment config

### Production Ready
- Can deploy to Heroku, Railway, AWS, etc.
- MongoDB Atlas for cloud database
- Environment-based configuration
- Ready for horizontal scaling

### Future Enhancements
- Redis caching layer
- CDN for video streaming
- Microservices architecture
- Load balancing
- Analytics integration

## 💡 Learning Outcomes

By studying this project, you'll learn:

1. **Full-Stack Development**: End-to-end app creation
2. **REST API Design**: Best practices and patterns
3. **Authentication**: JWT implementation
4. **Payment Integration**: Stripe API usage
5. **State Management**: Provider pattern in Flutter
6. **Database Design**: MongoDB schemas and relationships
7. **Video Streaming**: Network video implementation
8. **Security**: Best practices for auth and payments
9. **Error Handling**: User-friendly error management
10. **Production Deployment**: Real-world deployment steps

## 🎓 Use Cases

This codebase can be adapted for:

- **Online Course Platforms** (current use)
- **Fitness Training Apps** (workout videos)
- **Music Learning** (instrument tutorials)
- **Cooking Classes** (recipe videos)
- **Language Learning** (lesson videos)
- **Professional Training** (corporate learning)

## 📊 Sample Data Included

The seed script creates:
- 3 Users (1 student, 2 instructors)
- 6 Courses across different categories:
  - Flutter Development
  - React Native
  - UI/UX Design
  - Digital Marketing
  - Python for Data Science
  - Photography Masterclass
- Sample video URLs (public domain videos)
- Realistic pricing, ratings, and metadata

## 🔗 API Integration Points

The app integrates with:
1. **Custom Backend API** (your Node.js server)
2. **Stripe Payment API** (payment processing)
3. **Video CDN** (external video hosting - URLs provided)
4. **Image CDN** (Unsplash for sample thumbnails)

## 📞 Support & Resources

### Documentation
- Main README: Setup and features
- Quick Start Guide: 5-minute setup
- API Documentation: Complete API reference

### Test Credentials
- Student: test@example.com / password123
- Instructor: john@example.com / password123

### Test Payment
- Card: 4242 4242 4242 4242
- Expiry: Any future date
- CVC: Any 3 digits

## 🏆 Project Highlights

- ⚡ **Fast Setup**: Working in 5 minutes
- 📚 **Well Documented**: Comprehensive guides
- 🎨 **Beautiful UI**: Modern design system
- 🔒 **Secure**: Industry-standard practices
- 💼 **Professional**: Production-quality code
- 🧪 **Tested**: Sample data for testing
- 🚀 **Deployable**: Ready for app stores

## 📝 License

MIT License - Free to use for learning and commercial projects

---

**Built with ❤️ using Flutter & Node.js**

Start learning, start building, start hustling! 🚀
