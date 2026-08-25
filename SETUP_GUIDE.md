# Quick Start Guide - EduPlatform

## Prerequisites
- Node.js (v18+)
- npm or yarn
- Python 3 (for Ollama - optional)

## Installation Steps

### 1. Install Dependencies

```bash
# Install frontend dependencies
npm install

# Install backend dependencies
cd server
npm install
cd ..
```

### 2. Configure Environment Variables

```bash
cd server
cp .env.example .env
```

Edit `server/.env` and configure:
- Email settings (Gmail with App Password)
- AI settings (HuggingFace or Ollama)

### 3. Set Up AI (Choose one option)

#### Option A: Ollama (Recommended - Local & Free)
```bash
# Download from https://ollama.ai
# After installation:
ollama serve
# In another terminal:
ollama pull neural-chat
```

#### Option B: HuggingFace (Cloud-based)
1. Sign up at https://huggingface.co
2. Create API token from https://huggingface.co/settings/tokens
3. Add to `server/.env`: `HUGGINGFACE_API_KEY=your_token`

### 4. Gmail Setup for Email Notifications

1. Enable 2-Factor Authentication: https://myaccount.google.com/security
2. Create App Password: https://myaccount.google.com/apppasswords
3. Add to `server/.env`:
   ```
   EMAIL_USER=your-email@gmail.com
   EMAIL_PASSWORD=your-app-password
   ```

### 5. Start Development Servers

**Terminal 1 - Backend:**
```bash
cd server
npm start
# Output: ✓ Server running on http://localhost:5000
```

**Terminal 2 - Frontend:**
```bash
npm run dev
# Output: ✓ local: http://localhost:5173/
```

### 6. Test the Application

- Frontend: http://localhost:5173
- Backend Health Check: http://localhost:5000/api/health
- API will automatically proxy through `/api` from frontend

## Features Now Available

✓ **Authentication**: Register/Login with SQL Database
✓ **CSV Upload**: Upload attendance data with automatic analysis
✓ **Low Attendance Alerts**: Auto-send emails to students below 50%
✓ **Video Upload**: Admins can upload course videos in real-time
✓ **AI Chat**: ChatGPT alternative with free APIs (Ollama or HuggingFace)
✓ **Note Summarization**: AI-powered summary of study notes
✓ **Dashboard**: Real-time attendance analytics and visualizations
✓ **Responsive Design**: Works on desktop and mobile

## Troubleshooting

### Localhost not working
- Check if both servers are running (ports 5000 and 5173)
- Run `npm run dev` in root and `npm start` in server folder

### Videos not uploading
- Check file size (max 500MB)
- Ensure `server/videos/` folder exists
- Check file format (mp4, webm, mpeg supported)

### Emails not sending
- Verify Gmail App Password is set correctly (not regular password)
- Check 2FA is enabled on Gmail account
- Try sending test email

### AI not responding
- If using Ollama: make sure `ollama serve` is running
- If using HuggingFace: check API key and rate limits
- See server logs for detailed error messages

## Database

SQLite database automatically created at `server/database.sqlite`

Tables:
- `users`: Student/Teacher accounts
- `student_subjects`: Attendance data
- `videos`: Course videos
- `chat_history`: AI chat conversations
- `subjects_list`: List of subjects
- `upload_metadata`: CSV upload history

## CSV File Format

Your CSV should look like:
```
Name,Mathematics,Science,English
Alice,85,92,88
Bob,45,60,72
Charlie,95,88,91
```

Upload at: `/admin` → "Upload Attendance Data"

## Power BI Integration (Optional)

To connect Power BI:
1. Use SQL Server as data source
2. Point to your SQLite database
3. Create queries for:
   - Student attendance by subject
   - Low attendance alerts
   - Performance trends
   - Subject analytics

## Production Deployment

Before deploying:
- Use environment variables for all secrets
- Set up proper HTTPS
- Configure database backups
- Use production-grade email service (SendGrid, AWS SES)
- Enable proper authentication/authorization
- Add rate limiting and security headers
- Set up logging and monitoring

