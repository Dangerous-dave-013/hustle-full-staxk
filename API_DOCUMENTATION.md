# Backend API Documentation

## Base URL
```
http://localhost:3000/api
```

## Authentication

All protected routes require a JWT token in the Authorization header:
```
Authorization: Bearer <token>
```

---

## Auth Endpoints

### Register User
**POST** `/auth/register`

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "_id": "60d5ec49f1b2c72b8c8e4f1a",
    "name": "John Doe",
    "email": "john@example.com",
    "profileImage": null,
    "enrolledCourses": [],
    "isInstructor": false,
    "createdAt": "2023-06-25T10:30:00.000Z"
  }
}
```

### Login
**POST** `/auth/login`

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**Response:** Same as register

### Get Profile
**GET** `/auth/profile` 🔒

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "user": {
    "_id": "60d5ec49f1b2c72b8c8e4f1a",
    "name": "John Doe",
    "email": "john@example.com",
    "enrolledCourses": ["60d5ec49f1b2c72b8c8e4f1b"]
  }
}
```

---

## Course Endpoints

### Get All Courses
**GET** `/courses`

**Query Parameters:**
- `category` (optional): Filter by category (Development, Business, Design, Marketing, Photography)
- `search` (optional): Search in title and description
- `limit` (optional): Limit results (default: 50)

**Example:**
```
GET /courses?category=Development&search=flutter&limit=10
```

**Response:**
```json
{
  "courses": [
    {
      "_id": "60d5ec49f1b2c72b8c8e4f1b",
      "title": "Complete Flutter Development",
      "description": "Learn Flutter...",
      "thumbnail": "https://...",
      "price": 49.99,
      "instructor": "60d5ec49f1b2c72b8c8e4f1a",
      "instructorName": "John Doe",
      "instructorImage": null,
      "lessons": [...],
      "category": "Development",
      "level": "Beginner",
      "enrolledCount": 1234,
      "rating": 4.8,
      "reviewCount": 567,
      "requirements": [...],
      "learningOutcomes": [...],
      "createdAt": "2023-06-25T10:30:00.000Z",
      "updatedAt": "2023-06-25T10:30:00.000Z"
    }
  ]
}
```

### Get Course by ID
**GET** `/courses/:id`

**Response:** Single course object (same structure as above)

### Get Enrolled Courses
**GET** `/courses/enrolled` 🔒

**Headers:**
```
Authorization: Bearer <token>
```

**Response:**
```json
{
  "courses": [...]
}
```

### Create Course (Instructor Only)
**POST** `/courses` 🔒

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "title": "New Course Title",
  "description": "Course description",
  "thumbnail": "https://...",
  "price": 49.99,
  "category": "Development",
  "level": "Beginner",
  "requirements": ["Requirement 1", "Requirement 2"],
  "learningOutcomes": ["Outcome 1", "Outcome 2"],
  "lessons": [
    {
      "title": "Lesson 1",
      "videoUrl": "https://...",
      "duration": 15,
      "order": 1,
      "description": "Lesson description"
    }
  ]
}
```

**Response:** Created course object

---

## Payment Endpoints

### Create Payment Intent
**POST** `/payment/create-intent` 🔒

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "courseIds": ["60d5ec49f1b2c72b8c8e4f1b", "60d5ec49f1b2c72b8c8e4f1c"]
}
```

**Response:**
```json
{
  "clientSecret": "pi_xxx_secret_xxx",
  "paymentIntentId": "pi_xxx",
  "amount": 99.98
}
```

### Confirm Payment
**POST** `/payment/confirm` 🔒

**Headers:**
```
Authorization: Bearer <token>
```

**Request Body:**
```json
{
  "paymentIntentId": "pi_xxx",
  "courseIds": ["60d5ec49f1b2c72b8c8e4f1b", "60d5ec49f1b2c72b8c8e4f1c"]
}
```

**Response:**
```json
{
  "success": true,
  "message": "Payment confirmed and courses enrolled",
  "enrolledCourses": [...]
}
```

---

## Error Responses

### 400 Bad Request
```json
{
  "message": "Invalid input"
}
```

### 401 Unauthorized
```json
{
  "message": "No token, authorization denied"
}
```

### 404 Not Found
```json
{
  "message": "Resource not found"
}
```

### 500 Internal Server Error
```json
{
  "message": "Server error"
}
```

---

## Stripe Test Cards

For testing payments:

**Success:**
- Card: 4242 4242 4242 4242
- Expiry: Any future date
- CVC: Any 3 digits

**Decline:**
- Card: 4000 0000 0000 0002

More test cards: https://stripe.com/docs/testing
