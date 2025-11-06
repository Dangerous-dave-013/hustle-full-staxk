# Hustle - Full Stack Udemy Clone

A complete, production-ready mobile learning platform built with Flutter (frontend) and Node.js/Express (backend). Features include user authentication, course browsing, video streaming, shopping cart, and Stripe payment integration.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Node.js](https://img.shields.io/badge/Node.js-18+-339933?logo=node.js)
![MongoDB](https://img.shields.io/badge/MongoDB-Latest-47A248?logo=mongodb)
![Stripe](https://img.shields.io/badge/Stripe-Payment-008CDD?logo=stripe)

## 🎯 Features

### User Features
- ✅ **Authentication System** - Login/Signup with JWT tokens
- 📚 **Course Browsing** - Search and filter courses by category
- 🎥 **Video Player** - Stream course videos with playback controls
- 🛒 **Shopping Cart** - Add multiple courses before checkout
- 💳 **Stripe Payment** - Secure payment processing
- 📖 **My Courses** - Access enrolled courses anytime
- 👤 **User Profile** - Manage account and view stats

### Instructor Features
- 📝 **Course Creation** - Upload courses with lessons
- 🎬 **Video Management** - Add multiple video lessons
- 📊 **Course Analytics** - Track enrollments and ratings

### Technical Features
- 🔐 **JWT Authentication** - Secure token-based auth
- 🎨 **Modern UI/UX** - Beautiful Material Design interface
- 📱 **Responsive Design** - Works on all screen sizes
- ⚡ **Fast Performance** - Optimized loading and caching
- 🔄 **State Management** - Provider pattern
- 🌐 **RESTful API** - Well-structured backend APIs

## 🛠️ Tech Stack

### Frontend (Flutter)
- **Framework:** Flutter 3.0+
- **Language:** Dart
- **State Management:** Provider
- **Routing:** go_router
- **HTTP Client:** dio, http
- **Video Player:** video_player, chewie
- **Payment:** flutter_stripe
- **UI Components:** Material Design 3, Google Fonts
- **Image Caching:** cached_network_image

### Backend (Node.js)
- **Runtime:** Node.js 18+
- **Framework:** Express.js
- **Database:** MongoDB with Mongoose
- **Authentication:** JWT (jsonwebtoken), bcryptjs
- **Payment:** Stripe API
- **Validation:** express-validator
- **Environment:** dotenv

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** (3.0 or higher) - [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Node.js** (18.0 or higher) - [Install Node.js](https://nodejs.org/)
- **MongoDB** (Latest) - [Install MongoDB](https://www.mongodb.com/try/download/community)
- **Git** - [Install Git](https://git-scm.com/downloads)
- **Android Studio** or **Xcode** (for mobile development)
- **Stripe Account** - [Sign up for Stripe](https://stripe.com/)

## 🚀 Installation & Setup

### 1. Clone the Repository

```bash
cd "c:\Users\sandra\Desktop\mini project\new v3"
```

### 2. Backend Setup

#### Install Dependencies
```bash
cd backend
npm install
```

#### Configure Environment Variables
Create a `.env` file in the `backend` folder:

```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/hustle
JWT_SECRET=your_jwt_secret_key_change_this_in_production
STRIPE_SECRET_KEY=sk_test_your_stripe_secret_key_here
```

**Important:** Replace the following:
- `JWT_SECRET`: Generate a secure random string
- `STRIPE_SECRET_KEY`: Get from your [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys)

#### Start MongoDB
Make sure MongoDB is running on your machine:

```bash
# Windows
net start MongoDB

# macOS/Linux
sudo systemctl start mongod
```

#### Seed the Database
Populate the database with sample data:

```bash
node seed.js
```

This creates:
- 3 sample users (1 student, 2 instructors)
- 6 sample courses across different categories

**Test Credentials:**
- **Student:** test@example.com / password123
- **Instructor:** john@example.com / password123

#### Start the Backend Server
```bash
npm start
# or for development with auto-reload
npm run dev
```

Server will run on `http://localhost:3000`

### 3. Flutter Frontend Setup

#### Install Dependencies
```bash
cd ..
flutter pub get
```

#### Configure Environment Variables
Create a `.env` file in the root folder:

```env
API_BASE_URL=http://localhost:3000/api
STRIPE_PUBLISHABLE_KEY=pk_test_your_stripe_publishable_key_here
```

**Important:** 
- Replace `STRIPE_PUBLISHABLE_KEY` with your key from [Stripe Dashboard](https://dashboard.stripe.com/test/apikeys)
- For Android emulator, use `http://10.0.2.2:3000/api`
- For iOS simulator, use `http://localhost:3000/api`
- For physical device, use your computer's IP address (e.g., `http://192.168.1.100:3000/api`)

#### Run the App

**For Android:**
```bash
flutter run
```

**For iOS (macOS only):**
```bash
flutter run
```

**For specific device:**
```bash
flutter devices  # List available devices
flutter run -d <device_id>
```

## 📱 Testing the App

### 1. Register/Login
- Open the app and create a new account or use test credentials
- Email: test@example.com
- Password: password123

### 2. Browse Courses
- Browse through available courses
- Use search and category filters
- View course details and lessons

### 3. Add to Cart & Purchase
- Add courses to your shopping cart
- Go to cart and proceed to checkout
- Use Stripe test card numbers:
  - **Success:** 4242 4242 4242 4242
  - **Decline:** 4000 0000 0000 0002
  - Use any future date for expiry, any 3 digits for CVC

### 4. Watch Courses
- After purchase, go to "My Courses"
- Tap a course to start watching
- Navigate through lessons

## 🔧 Configuration

### Stripe Setup

1. Create a Stripe account at https://stripe.com
2. Get your API keys from the [Dashboard](https://dashboard.stripe.com/test/apikeys)
3. Use **Test mode** keys for development:
   - Publishable key (starts with `pk_test_`)
   - Secret key (starts with `sk_test_`)
4. Add keys to respective `.env` files

### MongoDB Setup

**Local MongoDB:**
```bash
mongod --dbpath /path/to/your/data/folder
```

**MongoDB Atlas (Cloud):**
1. Create account at https://www.mongodb.com/cloud/atlas
2. Create a cluster
3. Get connection string
4. Update `MONGODB_URI` in backend `.env`

### Android Network Configuration

For Android emulator to connect to localhost backend, update the `.env`:

```env
API_BASE_URL=http://10.0.2.2:3000/api
```

For physical Android device, use your computer's local IP:
```env
API_BASE_URL=http://192.168.1.XXX:3000/api
```

## 📁 Project Structure

```
hustle/
├── lib/                          # Flutter app source code
│   ├── core/
│   │   ├── routes/              # Navigation routes
│   │   └── theme/               # App theme and styling
│   ├── features/
│   │   ├── auth/                # Authentication
│   │   │   ├── providers/       # Auth state management
│   │   │   └── screens/         # Login, Register screens
│   │   ├── home/                # Home screen
│   │   ├── courses/             # Course features
│   │   │   ├── providers/       # Course state management
│   │   │   └── screens/         # Course list, detail, player
│   │   ├── cart/                # Shopping cart
│   │   └── profile/             # User profile
│   ├── models/                  # Data models
│   ├── services/                # API services
│   ├── widgets/                 # Reusable widgets
│   └── main.dart               # App entry point
├── backend/
│   ├── models/                  # MongoDB schemas
│   │   ├── User.js
│   │   ├── Course.js
│   │   └── Payment.js
│   ├── routes/                  # API routes
│   │   ├── auth.js
│   │   ├── courses.js
│   │   └── payment.js
│   ├── middleware/              # Express middleware
│   │   └── auth.js
│   ├── seed.js                  # Database seeder
│   ├── server.js                # Express server
│   └── package.json
├── .env                         # Flutter environment variables
├── pubspec.yaml                 # Flutter dependencies
└── README.md                    # This file
```

## 🔌 API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - Login user
- `GET /api/auth/profile` - Get user profile (protected)

### Courses
- `GET /api/courses` - Get all courses (with filters)
- `GET /api/courses/:id` - Get course by ID
- `GET /api/courses/enrolled` - Get enrolled courses (protected)
- `POST /api/courses` - Create course (instructor only)

### Payment
- `POST /api/payment/create-intent` - Create Stripe payment intent (protected)
- `POST /api/payment/confirm` - Confirm payment and enroll (protected)

## 🎨 Screenshots

The app features:
- Modern Material Design 3 UI
- Smooth animations and transitions
- Dark/Light theme support (theme implementation ready)
- Responsive layouts for all screen sizes
- Professional color scheme with purple primary color

## 🐛 Troubleshooting

### Backend Issues

**MongoDB Connection Error:**
```bash
# Check if MongoDB is running
mongo --version
# Start MongoDB service
net start MongoDB  # Windows
sudo systemctl start mongod  # Linux
```

**Port Already in Use:**
```bash
# Change PORT in backend/.env to another port like 3001
PORT=3001
```

### Flutter Issues

**Dependency Errors:**
```bash
flutter clean
flutter pub get
```

**Stripe Not Working:**
- Verify publishable key in `.env`
- Check API_BASE_URL is correct
- Ensure backend is running
- Test with valid test card: 4242 4242 4242 4242

**Video Not Playing:**
- Check internet connection
- Verify video URL is accessible
- Test with sample videos provided in seed data

## 🚀 Deployment

### Backend Deployment (Heroku/Railway/Render)

1. Set environment variables on your hosting platform
2. Update `MONGODB_URI` to production MongoDB
3. Update `STRIPE_SECRET_KEY` to live key
4. Deploy backend

### Flutter App Deployment

**Android:**
```bash
flutter build apk --release
# Or App Bundle
flutter build appbundle --release
```

**iOS:**
```bash
flutter build ios --release
```

Update `.env` with production API URL before building.

## 📝 Future Enhancements

- [ ] Course reviews and ratings
- [ ] Course progress tracking
- [ ] Certificates upon completion
- [ ] Live chat support
- [ ] Push notifications
- [ ] Download videos for offline viewing
- [ ] Course wishlists
- [ ] Instructor analytics dashboard
- [ ] Admin panel
- [ ] Social login (Google, Facebook)

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Built with ❤️ using Flutter and Node.js

## 📧 Support

For issues or questions, please open an issue on GitHub or contact support.

---

**Happy Learning! 🎓**
