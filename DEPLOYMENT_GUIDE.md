# Hustle App - Deployment Guide

## 📱 Making Your App Standalone (No Localhost Needed!)

Follow these steps to deploy your backend to the cloud and build a standalone mobile app that works on any phone.

---

## Step 1️⃣: Prepare Backend for Deployment

### Option A: Deploy to Render.com (Recommended - FREE!)

1. **Create a GitHub account** (if you don't have one)
   - Go to https://github.com/signup

2. **Install Git** (if not installed)
   - Download from https://git-scm.com/download/win
   - Or use GitHub Desktop: https://desktop.github.com/

3. **Initialize Git in your backend folder**
   ```powershell
   cd "c:\Users\sandra\Desktop\mini project\new v3\backend"
   git init
   git add .
   git commit -m "Initial commit - Hustle backend with fake payment gateway"
   ```

4. **Create a new GitHub repository**
   - Go to https://github.com/new
   - Repository name: `hustle-backend`
   - Make it **Public** or **Private** (your choice)
   - Click "Create repository"

5. **Push your code to GitHub**
   ```powershell
   git remote add origin https://github.com/YOUR_USERNAME/hustle-backend.git
   git branch -M main
   git push -u origin main
   ```

6. **Deploy to Render.com**
   - Go to https://render.com/
   - Sign up with your GitHub account
   - Click "New +" → "Web Service"
   - Connect your `hustle-backend` repository
   - Render will auto-detect the `render.yaml` file
   - Click "Create Web Service"

7. **Set Environment Variables in Render Dashboard**
   - Go to your service → "Environment" tab
   - Add these variables:
     - `MONGODB_URI`: Your MongoDB Atlas connection string
     - `JWT_SECRET`: Any random secure string (e.g., `hustle_jwt_secret_2024_prod`)
     - `NODE_ENV`: production
   - Click "Save Changes"

8. **Wait for deployment** (5-10 minutes)
   - You'll get a URL like: `https://hustle-backend.onrender.com`
   - Test it: Open `https://hustle-backend.onrender.com/api/health` in browser
   - Should see: `{"status":"OK","message":"Hustle API is running"}`

---

### Option B: Deploy to Railway.app (Alternative - Also FREE!)

1. **Go to https://railway.app/**
2. Sign up with GitHub
3. Click "New Project" → "Deploy from GitHub repo"
4. Select your backend repository
5. Add environment variables (same as above)
6. Get your Railway URL (e.g., `https://hustle-backend.railway.app`)

---

## Step 2️⃣: Update Flutter App with Production URL

1. **Update the `.env` file**
   ```powershell
   cd "c:\Users\sandra\Desktop\mini project\new v3"
   notepad .env
   ```

2. **Change the API_BASE_URL**
   Replace:
   ```
   API_BASE_URL=http://localhost:3000/api
   ```
   
   With your production URL:
   ```
   API_BASE_URL=https://hustle-backend.onrender.com/api
   ```
   (Or use your Railway URL if you chose that option)

3. **Clean and rebuild**
   ```powershell
   flutter clean
   flutter pub get
   ```

---

## Step 3️⃣: Build Release APK for Android

1. **Build the release APK**
   ```powershell
   cd "c:\Users\sandra\Desktop\mini project\new v3"
   flutter build apk --release
   ```

2. **Wait for build to complete** (5-10 minutes)
   - You'll see: "✓ Built build\app\outputs\flutter-apk\app-release.apk"

3. **Find your APK**
   - Location: `c:\Users\sandra\Desktop\mini project\new v3\build\app\outputs\flutter-apk\app-release.apk`
   - File size: ~50-80 MB

4. **Transfer APK to your phone**
   - Option 1: USB cable → Copy to phone storage
   - Option 2: Email it to yourself
   - Option 3: Upload to Google Drive and download on phone
   - Option 4: Use file-sharing app (ShareIt, Xender, etc.)

5. **Install on Android phone**
   - Open the APK file on your phone
   - Enable "Install from unknown sources" if prompted
   - Install the app
   - Open and test!

---

## Step 4️⃣: Test Your Standalone App

### ✅ Checklist:
- [ ] Open app without running backend locally
- [ ] Register a new account
- [ ] Login works
- [ ] Can browse 80 courses
- [ ] Search and filter work
- [ ] Add courses to cart
- [ ] Payment gateway opens
- [ ] Fake payment processes successfully
- [ ] Enrolled courses show up
- [ ] Course content loads properly

---

## 🚨 Troubleshooting

### Issue: "Network error" or "Failed to connect"
- **Solution**: Check your `.env` file has the correct production URL
- Make sure your phone has internet connection
- Test the backend URL in a browser: `https://your-url.onrender.com/api/health`

### Issue: Render app goes to sleep (free tier)
- **Symptom**: First API call takes 30-60 seconds
- **Solution**: This is normal for Render free tier. The app "wakes up" after first request.
- **Alternative**: Use Railway (doesn't sleep) or upgrade to Render paid plan ($7/month)

### Issue: APK won't install on phone
- **Solution**: Enable "Install from unknown sources" in phone settings
- Go to: Settings → Security → Unknown Sources → Enable

### Issue: "App not installed" error
- **Solution**: Uninstall old version first if you installed before
- Make sure your phone has enough storage (at least 200 MB free)

---

## 📝 Important Notes

1. **Backend URL**: Save your production URL! You'll need it if you rebuild the app.

2. **Free Tier Limits**:
   - Render: 750 hours/month (enough for 24/7), sleeps after 15 min idle
   - Railway: $5 credit/month, no sleep

3. **APK Distribution**:
   - You can share the APK file with anyone
   - They don't need Android Studio or Flutter
   - Just install and use!

4. **Future Updates**:
   - To update the app: Make changes → `flutter build apk --release` → Get new APK
   - To update backend: Push to GitHub → Render auto-deploys

---

## 🎉 Congratulations!

Your app is now a **standalone mobile application** that:
- ✅ Works on any Android phone
- ✅ Doesn't need localhost or your computer running
- ✅ Connects to cloud backend automatically
- ✅ Has 80 real courses
- ✅ Has working fake payment gateway
- ✅ Can be shared with friends!

---

## Need Help?

If you run into any issues:
1. Check the backend is running: Visit `https://your-url.onrender.com/api/health`
2. Verify `.env` has correct URL
3. Run `flutter clean && flutter pub get`
4. Rebuild APK
5. Try on a different phone to isolate the issue
