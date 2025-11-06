# MongoDB Setup Guide

Your backend needs a MongoDB database. Here are your options:

---

## ✅ Option 1: MongoDB Atlas (Cloud) - RECOMMENDED

**Why?** No installation, free tier, works everywhere, production-ready

### Steps:

1. **Create Account**
   - Go to https://www.mongodb.com/cloud/atlas/register
   - Sign up (free, no credit card required)

2. **Create Cluster**
   - Click "Build a Database"
   - Choose "FREE" tier (M0 Sandbox)
   - Select your cloud provider and region (closest to you)
   - Click "Create Cluster"

3. **Setup Database Access**
   - Click "Database Access" in left menu
   - Click "Add New Database User"
   - Choose "Password" authentication
   - Username: `hustleuser`
   - Password: Click "Autogenerate Secure Password" and **SAVE IT**
   - Database User Privileges: "Read and write to any database"
   - Click "Add User"

4. **Setup Network Access**
   - Click "Network Access" in left menu
   - Click "Add IP Address"
   - Click "Allow Access from Anywhere" (for development)
   - Click "Confirm"

5. **Get Connection String**
   - Click "Database" in left menu
   - Click "Connect" on your cluster
   - Click "Connect your application"
   - Copy the connection string (looks like):
   ```
   mongodb+srv://hustleuser:<password>@cluster0.xxxxx.mongodb.net/?retryWrites=true&w=majority
   ```

6. **Update Your .env File**
   - Open `backend/.env`
   - Replace `<password>` with the password you saved
   - Add database name at the end:
   ```env
   MONGODB_URI=mongodb+srv://hustleuser:YourPassword123@cluster0.xxxxx.mongodb.net/hustle?retryWrites=true&w=majority
   ```

7. **Test It**
   ```powershell
   cd backend
   node seed.js
   ```

✅ **Done!** Your cloud database is ready.

---

## Option 2: Install MongoDB Locally

### For Windows:

1. **Download MongoDB Community Server**
   - Go to https://www.mongodb.com/try/download/community
   - Select Version: 7.0 or latest
   - Package: msi
   - Click "Download"

2. **Install**
   - Run the downloaded `.msi` file
   - Choose "Complete" setup type
   - Check "Install MongoDB as a Service"
   - Keep default settings
   - Click "Install"

3. **Verify Installation**
   ```powershell
   mongod --version
   ```

4. **Start MongoDB Service**
   ```powershell
   net start MongoDB
   ```

5. **Update .env**
   ```env
   MONGODB_URI=mongodb://localhost:27017/hustle
   ```

6. **Test It**
   ```powershell
   cd backend
   node seed.js
   ```

---

## Option 3: Use Docker (Advanced)

If you have Docker installed:

```powershell
docker run -d -p 27017:27017 --name mongodb mongo:latest
```

Then use:
```env
MONGODB_URI=mongodb://localhost:27017/hustle
```

---

## 🆘 Troubleshooting

### "Connection refused" error
- **Atlas**: Check if IP address is whitelisted (0.0.0.0/0 for anywhere)
- **Local**: Make sure MongoDB service is running: `net start MongoDB`
- **Docker**: Check if container is running: `docker ps`

### "Authentication failed" error
- Double-check username and password in connection string
- Make sure user has read/write permissions

### "Network timeout" error
- Check your internet connection (for Atlas)
- Try different region in Atlas

### Still not working?
- Option 1 (Atlas) is the easiest - try that first
- Make sure you copied the entire connection string
- Replace `<password>` with your actual password (no < > brackets)

---

## 🎯 Next Steps After MongoDB is Running

1. **Seed the database**:
   ```powershell
   cd backend
   node seed.js
   ```

2. **Start the backend server**:
   ```powershell
   npm start
   ```

3. **You should see**:
   ```
   ✅ MongoDB connected successfully
   🚀 Server is running on port 3000
   ```

4. **Test the API**:
   Open browser: http://localhost:3000/api/health

---

## 💡 Recommendation

For this project, **use MongoDB Atlas (Option 1)**:
- ✅ No installation needed
- ✅ Works immediately
- ✅ Free forever (M0 tier)
- ✅ Can access from anywhere
- ✅ Production-ready
- ✅ Automatic backups
- ✅ Easy to scale

---

Need help? Check the main README.md or open an issue.
