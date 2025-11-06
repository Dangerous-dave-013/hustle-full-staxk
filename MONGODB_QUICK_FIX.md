# 🚀 Quick Fix: MongoDB Setup in 2 Minutes

## Your Issue
```
❌ Error: connect ECONNREFUSED 127.0.0.1:27017
```

**Translation:** MongoDB is not installed or not running.

---

## ⚡ FASTEST SOLUTION (2 minutes)

### Use MongoDB Atlas (Free Cloud Database)

**Step 1:** Go to https://www.mongodb.com/cloud/atlas/register
- Sign up (free, no credit card)

**Step 2:** Create Free Cluster
- Click "Build a Database"
- Choose **FREE** M0 tier
- Click "Create"

**Step 3:** Create Database User
- Click "Database Access"
- Add New User
- Username: `hustleuser`
- Password: Auto-generate and **COPY IT**

**Step 4:** Allow Network Access
- Click "Network Access"
- Add IP: **0.0.0.0/0** (allow from anywhere)

**Step 5:** Get Connection String
- Click "Database" → "Connect"
- "Connect your application"
- **Copy the connection string**

**Step 6:** Update Your `.env` File

Open: `C:\Users\sandra\Desktop\mini project\new v3\backend\.env`

Change this line:
```env
MONGODB_URI=mongodb+srv://hustleuser:YOUR_PASSWORD_HERE@cluster0.xxxxx.mongodb.net/hustle?retryWrites=true&w=majority
```

**Replace:**
- `YOUR_PASSWORD_HERE` with the password you copied
- `cluster0.xxxxx.mongodb.net` with your actual cluster address

**Step 7:** Run Seed Again
```powershell
cd "C:\Users\sandra\Desktop\mini project\new v3\backend"
node seed.js
```

✅ **Should work now!**

---

## 📝 Example

Your connection string should look like:
```
mongodb+srv://hustleuser:Abc123XyZ@cluster0.mongodb.net/hustle?retryWrites=true&w=majority
```

**NOT like:**
```
mongodb+srv://hustleuser:<password>@cluster0...  ❌ (keep the <>)
```

---

## 🆘 Still Having Issues?

### Option 1: Check Your Connection String
- No `<` or `>` brackets in the password
- Password has no special characters like `@`, `#`, `/`
- If it does, URL encode them or regenerate

### Option 2: Check Network Access
- Make sure you allowed **0.0.0.0/0**
- Wait 1-2 minutes for changes to apply

### Option 3: Try Again
```powershell
cd backend
node seed.js
```

---

## ✅ Success Looks Like:

```
✅ MongoDB connected
🗑️  Cleared existing data
👥 Created sample users
📚 Created sample courses

✅ Database seeded successfully!

📝 Test Credentials:
   Email: test@example.com
   Password: password123
```

---

## 🎯 Next Commands After Success:

```powershell
# Start backend
npm start

# In another terminal, run Flutter app
cd ..
flutter run
```

---

Need the full guide? Check **MONGODB_SETUP.md**
