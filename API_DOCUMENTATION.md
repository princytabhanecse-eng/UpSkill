# API Documentation - Attendance Analysis System

## Endpoints

### 1. GET /api/dashboard/stats
**Purpose**: Fetch all students and subject attendance data

**Response**: 
```json
{
  "success": true,
  "data": [
    {
      "name": "John D.",
      "attendance": 85,
      "Mathematics": 85,
      "English": 78,
      "Science": 82,
      "History": 88,
      "Physical Education": 90
    }
  ],
  "subjects": {
    "Mathematics": [85, 92, 45, ...],
    "English": [78, 95, 38, ...]
  }
}
```

---

### 2. POST /api/upload/csv
**Purpose**: Upload CSV file with multi-subject attendance data

**Request**: 
- Method: `POST`
- Content-Type: `multipart/form-data`
- Body: File upload with key `file`

**CSV Format**:
```
Student Name,Subject1,Subject2,Subject3
John Doe,85,90,78
Jane Smith,92,88,95
```

**Response**: 
```json
{
  "success": true,
  "message": "✓ 10 students processed successfully",
  "data": [ /* student data */ ],
  "subjects": { /* subject attendance arrays */ },
  "analysis": {
    "avgAttendance": 78.5,
    "riskLevels": {
      "high": 2,
      "medium": 3,
      "good": 5
    },
    "trend": "Improving",
    "anomalies": 1,
    "atRiskStudents": [
      { "name": "Alex J.", "attendance": 45 }
    ],
    "predictions": {
      "outcome": "Good",
      "confidence": 95.2
    }
  }
}
```

**Error Responses**:
```json
/* No file uploaded */
{ "success": false, "message": "No file uploaded" }

/* Invalid file type */
{ "success": false, "message": "Only CSV files are allowed" }

/* File too large */
{ "success": false, "message": "File too large" }

/* No valid data in CSV */
{ "success": false, "message": "No valid data found in CSV" }

/* Database error */
{ "success": false, "message": "Database error", "error": "..." }
```

---

### 3. POST /api/auth/google
**Purpose**: User authentication with Google OAuth

**Request**:
```json
{ "token": "google_id_token" }
```

**Response**:
```json
{
  "success": true,
  "user": {
    "id": 1,
    "google_id": "...",
    "email": "user@example.com",
    "name": "User Name",
    "role": "teacher" | "student"
  }
}
```

---

## Database Schema

### attendance table
```sql
CREATE TABLE attendance (
  id INTEGER PRIMARY KEY,
  name TEXT UNIQUE,
  attendance REAL DEFAULT 0
);
```

### subject_attendance table
```sql
CREATE TABLE subject_attendance (
  id INTEGER PRIMARY KEY,
  student_name TEXT,
  subject TEXT,
  attendance REAL,
  UNIQUE(student_name, subject)
);
```

### analysis_results table
```sql
CREATE TABLE analysis_results (
  id INTEGER PRIMARY KEY,
  timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
  avg_attendance REAL,
  trend TEXT,
  anomalies INTEGER,
  data JSON
);
```

---

## ML Analysis Functions

### calculateStatistics(values: number[])
Calculates mean, standard deviation, and median

**Parameters**:
- `values`: Array of attendance numbers (0-100)

**Returns**:
```javascript
{
  mean: 78.5,
  stdDev: 12.3,
  median: 80
}
```

---

### detectAnomalies(values, mean, stdDev): number
Finds students with attendance >2 standard deviations from mean

**Returns**: Count of anomalous students

---

### analyzeTrend(values): string
Compares first half vs second half of attendance data

**Returns**: "Improving", "Declining", or "Stable"

---

### classifyRiskLevel(attendance: number): string
Categorizes attendance into risk levels

- `high`: < 50%
- `medium`: 50-75%
- `good`: > 75%

---

## Error Handling

All endpoints include:
- Try-catch blocks
- Database transaction support
- Automatic temp file cleanup
- Detailed error messages
- Status code validation
- Input sanitization

### File Upload Safeguards
- File size limit: 10MB
- Allowed mime types: `text/csv`
- Extension validation: `.csv` only
- Malformed CSV handling with fallback

### Database Safeguards
- SQL injection prevention (parameterized queries)
- Transaction rollback on errors
- Connection pooling
- Timeout handling
- Graceful error recovery

---

## Rate Limiting & Performance

**Recommendations**:
- Max file size: 10MB (supports ~5000+ students)
- Processing time: ~100-500ms per file upload
- Concurrent uploads: Handled asynchronously
- Database queries: Indexed on student_name, subject

---

## Usage Examples

### Using Fetch (Frontend)
```javascript
// Upload CSV
const formData = new FormData();
formData.append('file', csvFile);

const response = await fetch('http://localhost:5000/api/upload/csv', {
  method: 'POST',
  body: formData
});

const result = await response.json();
console.log(result.analysis);
```

### Using curl (CLI)
```bash
curl -X POST \
  -F "file=@attendance.csv" \
  http://localhost:5000/api/upload/csv
```

### Using Node.js
```javascript
const FormData = require('form-data');
const fs = require('fs');

const form = new FormData();
form.append('file', fs.createReadStream('attendance.csv'));

form.submit('http://localhost:5000/api/upload/csv', (err, res) => {
  if (err) throw err;
  console.log(res.json());
});
```

---

## Response Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 400 | Bad request (invalid file/data) |
| 401 | Unauthorized (invalid token) |
| 500 | Server error |

---

## Version
**API Version**: 1.0  
**Last Updated**: May 17, 2026  
**Status**: ✅ Production Ready
