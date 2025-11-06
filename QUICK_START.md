# Quick Start Guide - Hustle App

## ⚡ Fast Setup (5 minutes)

### Step 1: Install Backend Dependencies
```powershell
cd backend
npm install
```

### Step 2: Configure Backend
Create `backend/.env`:
```env
PORT=3000
MONGODB_URI=mongodb://localhost:27017/hustle
JWT_SECRET=my_super_secret_jwt_key_change_in_production
STRIPE_SECRET_KEY=sk_test_51xxxxx
```

### Step 3: Start MongoDB
```powershell
# Make sure MongoDB is installed and running
net start MongoDB
```

### Step 4: Seed Database with Sample Data
```powershell
# Still in backend folder
node seed.js
```

### Step 5: Start Backend Server
```powershell
npm start
```
✅ Backend running at http://localhost:3000

### Step 6: Configure Flutter App
Create `.env` in root folder:
```env
API_BASE_URL=http://localhost:3000/api
STRIPE_PUBLISHABLE_KEY=pk_test_51xxxxx
```

**Important for Android Emulator:** Use `http://10.0.2.2:3000/api`

### Step 7: Install Flutter Dependencies
```powershell
# Open new terminal in project root
flutter pub get
```

### Step 8: Run the App
```powershell
flutter run
```

## 🎉 You're Done!

### Test Credentials
- **Email:** test@example.com
- **Password:** password123

### Test Payment Card
- **Card Number:** 4242 4242 4242 4242
- **Expiry:** Any future date (e.g., 12/25)
- **CVC:** Any 3 digits (e.g., 123)

## 🔧 Common Issues

### "MongoDB connection failed"
```powershell
# Start MongoDB
net start MongoDB
```

### "Cannot connect to backend from Android emulator"
Update `.env`:
```env
API_BASE_URL=http://10.0.2.2:3000/api
```

### "Flutter build failed"
```powershell
flutter clean
flutter pub get
flutter run
```

## 📱 Next Steps

1. **Browse Courses** - Explore the 6 sample courses
2. **Add to Cart** - Add courses you like
3. **Make Payment** - Use test card to purchase
4. **Watch Videos** - Access your courses from "My Courses"

## 🚀 Advanced

### Change Backend Port
Update `backend/.env`:
```env
PORT=8000
```

Update root `.env`:
```env
API_BASE_URL=http://localhost:8000/api
```

### Use Real MongoDB Atlas
1. Create free cluster at https://www.mongodb.com/cloud/atlas
2. Get connection string
3. Update `MONGODB_URI` in `backend/.env`

### Deploy to Production
See full README.md for deployment instructions

## 📚 More Information

- Full documentation: README.md
- API documentation: API_DOCUMENTATION.md
- Stripe testing: https://stripe.com/docs/testing

---

**Need help?** Check the Troubleshooting section in README.md
