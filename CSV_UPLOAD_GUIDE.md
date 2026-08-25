# CSV File Upload & Attendance Analysis Guide

## ✅ System Status
Your CSV upload system is **fully functional** with integrated ML-based analysis!

## 🚀 Features Implemented

### 1. **Multi-Subject Attendance Support**
- Upload CSV files with student names in rows
- Support for multiple subjects as columns
- Individual attendance tracking per subject
- Overall student attendance calculated automatically

### 2. **CSV File Format**
Your CSV should follow this format:

```
Student Name,Mathematics,English,Science,History,Physical Education
John D.,85,78,82,88,90
Sarah M.,92,95,88,90,85
Alex J.,45,38,42,40,50
Emma W.,78,82,80,79,75
```

**Requirements:**
- First column: Student Names
- Other columns: Subject names with attendance percentages (0-100)
- Attendance values must be numeric (0-100 range)
- Header row is automatically detected

### 3. **ML-Based Analysis Features**

The system performs comprehensive analysis of attendance data:

#### Statistical Analysis
- **Average Attendance**: Calculates mean attendance across all students
- **Attendance Trend**: Detects if attendance is Improving, Declining, or Stable
- **Anomaly Detection**: Identifies students with unusual attendance patterns (>2 standard deviations from mean)
- **Risk Classification**: Categorizes students into three risk levels:
  - 🔴 **High Risk**: < 50% attendance
  - 🟡 **Medium Risk**: 50-75% attendance  
  - 🟢 **Good**: > 75% attendance

#### Predictions
- **Overall Outcome**: Predicted performance based on attendance
  - Critical: < 50% average
  - At Risk: 50-70% average
  - Good: 70-80% average
  - Excellent: > 80% average

#### Intervention Identification
- **At-Risk Students Table**: Lists top 10 students requiring intervention
- Shows individual attendance percentages
- Color-coded risk indicators

### 4. **User Interface Features**

#### Dashboard Stats Cards
- Total Students (from uploaded CSV)
- Exam Eligibility % (based on >50% threshold)
- At Risk Count (students with <50% attendance)
- Average Attendance (ML analyzed)

#### Subject Selection
- Click on subject buttons to filter attendance by subject
- Switch between different subjects to analyze subject-specific patterns
- Charts update dynamically

#### Charts & Visualizations
- **Bar Chart**: Student-wise attendance overview (color-coded by risk level)
- **Pie Chart**: Risk level distribution (High/Medium/Good)
- **ML Analysis Panel**: Detailed statistical results

### 5. **Error Handling & Crash Prevention**

The system includes multiple safeguards:

✅ **File Validation**
- Only accepts .csv files
- 10MB file size limit
- Validates numeric attendance values

✅ **Database Transactions**
- Uses SQLite transactions for data integrity
- Automatic rollback on errors
- No partial data corruption

✅ **Error Messages**
- Clear feedback if CSV parsing fails
- Indicates missing required fields
- Shows what went wrong during upload

✅ **Backend Resilience**
- Async file processing prevents server blocking
- Proper cleanup of temporary files
- Comprehensive error logging
- Express error middleware catches all exceptions

## 📝 How to Use

### Step 1: Prepare Your CSV File
Create a CSV file with attendance data in the format shown above.

Use the provided `sample_attendance.csv` as a template.

### Step 2: Upload File
1. Log in as Teacher (Admin Dashboard)
2. Click **"Upload CSV"** button
3. Select your CSV file
4. Wait for "✓ X students processed successfully" message

### Step 3: View Analysis
- Check the stats cards for overall metrics
- Browse the bar chart for individual student attendance
- Click subject buttons to filter by subject
- Review the ML Analysis Results panel
- Check the "Students Requiring Intervention" table for at-risk students

### Step 4: Export Results (Optional)
Click **"Export CSV"** to download the processed data

## 🗄️ Database Schema

### Tables Created:

1. **attendance**
   - Stores overall student attendance (average across subjects)

2. **subject_attendance**
   - Stores per-subject attendance for each student

3. **analysis_results**
   - Stores ML analysis results and trends

4. **users**
   - Manages teacher/student accounts

## 🔧 Technical Details

### Backend (Node.js + Express)
- **Port**: 5000
- **Database**: SQLite
- **File Upload**: Multer (with validation)
- **CSV Parsing**: csv-parser
- **ML Algorithms**: Custom statistical analysis

### Frontend (React + Vite)
- **Port**: 5173
- **Charts**: Recharts
- **State Management**: React Hooks
- **Real-time Updates**: Direct API calls

### ML Analysis Methods
- **Statistical Calculation**: Mean, Standard Deviation, Median
- **Anomaly Detection**: Z-score method (>2 SD from mean)
- **Trend Analysis**: First-half vs Second-half comparison
- **Risk Prediction**: Threshold-based classification

## ⚙️ Running the System

### Terminal 1 - Frontend
```bash
cd c:\Users\princ\OneDrive\Desktop\education
npm run dev
# Runs on http://localhost:5173
```

### Terminal 2 - Backend
```bash
cd c:\Users\princ\OneDrive\Desktop\education\server
node index.js
# Runs on http://localhost:5000
```

**Both servers must be running for the system to work.**

## 🐛 Troubleshooting

| Issue | Solution |
|-------|----------|
| "Upload failed. Ensure backend server is running." | Run `node index.js` in server directory |
| CSV file not uploading | Check file format matches requirements |
| No students shown after upload | Verify CSV has valid data in second row onwards |
| Charts show empty | Wait a moment for data to load |
| Subject buttons don't appear | Data wasn't properly parsed from CSV |

## 📊 Sample CSV Data Analysis

Using the provided `sample_attendance.csv`:
- 10 students uploaded successfully
- Subjects: Mathematics, English, Science, History, Physical Education
- Overall average attendance: ~78%
- Students at risk: 1 (Alex J. with ~43% attendance)
- Eligibility: 90% (9 out of 10 students)

## 🎯 Next Steps (Optional Enhancements)

Consider implementing:
1. Email notifications to at-risk students
2. Scheduled CSV imports
3. Historical trend tracking
4. Custom attendance thresholds
5. Parent notification system
6. Attendance prediction models (linear regression)

## 📞 Support

For issues, check:
- Browser console (F12) for error messages
- Server logs in terminal for backend errors
- CSV file format against the template provided

---

**System Status**: ✅ Fully Operational
**Last Updated**: May 17, 2026
