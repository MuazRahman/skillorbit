# SkillOrbit - Screen Documentation

## Table of Contents
1. [Splash Screen](#splash-screen)
2. [Authentication Screens](#authentication-screens)
   - [Login Screen](#login-screen)
   - [Signup Screen](#signup-screen)
   - [Forgot Password Screen](#forgot-password-screen)
3. [Main Application Screens](#main-application-screens)
   - [Dashboard Screen](#dashboard-screen)
   - [Home Screen](#home-screen)
   - [My Course Screen](#my-course-screen)
   - [Profile Screen](#profile-screen)
4. [Course Related Screens](#course-related-screens)
   - [Course Details Screen](#course-details-screen)
   - [Enrolled Course Screen](#enrolled-course-screen)
   - [Subtopics Screen](#subtopics-screen)
   - [Subtopic Details Screen](#subtopic-details-screen)
   - [Topic Details Screen](#topic-details-screen)
5. [Quiz Screens](#quiz-screens)
   - [Subtopic Quiz Screen](#subtopic-quiz-screen)
   - [Quiz Screen](#quiz-screen)
6. [Profile Management Screens](#profile-management-screens)
   - [Edit Profile Screen](#edit-profile-screen)
   - [Enhanced Achievements Screen](#enhanced-achievements-screen)

## Splash Screen

**File**: [lib/screens/splash_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/splash_screen.dart)

### Functionality
The splash screen is the first screen users see when launching the application. It serves multiple purposes:
- Initializes the application and loads necessary data
- Displays an animated logo with progress indicator
- Checks user authentication status
- Loads course data in the background
- Navigates to the appropriate screen based on authentication state

### Key Features
- **Animated Logo**: Features a scaling and fading app logo with shadow effects
- **Progress Animation**: Custom animated progress bar with shimmer effect
- **Data Loading**: Asynchronously loads courses from Firestore
- **User Data Loading**: Loads user enrolled courses and achievements if logged in
- **Navigation**: Automatically navigates to Dashboard after initialization

### UI Components
- Animated app logo with circular background
- App name with typography effects
- Subtitle text ("Learn. Grow. Succeed.")
- Custom animated progress bar with pulse effect

### Technical Implementation
- Uses AnimationController for logo scaling and fading
- Implements Future.delayed for minimum splash screen display time
- Handles Firebase authentication state checking
- Loads course data in background without blocking UI

## Authentication Screens

### Login Screen

**File**: [lib/screens/auth/login_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/auth/login_screen.dart)

### Functionality
The login screen allows existing users to access their accounts using email and password authentication.

### Key Features
- **Email/Password Authentication**: Secure login using Firebase Authentication
- **Form Validation**: Real-time validation for email format and password length
- **Password Visibility Toggle**: Show/hide password functionality
- **Error Handling**: User-friendly error messages for various login failures
- **Navigation Options**: Links to signup and forgot password screens
- **Loading State**: Visual feedback during authentication process

### UI Components
- Gradient background with brand colors
- App logo display
- Email input field with validation
- Password input field with visibility toggle
- "Forgot Password" link
- Login button with loading indicator
- "Don't have an account?" signup link

### Technical Implementation
- Uses GetX for state management and navigation
- Implements form validation with GetUtils for email validation
- Handles various Firebase authentication errors
- Provides direct navigation to signup screen for new users

### Login Flow
1. User enters email and password
2. Form validation ensures proper format
3. Authentication request sent to Firebase
4. Success: Navigate to Dashboard
5. Failure: Display appropriate error message

### Error Handling
- Invalid email format
- Incorrect password
- User not found
- Network connectivity issues
- Firebase configuration errors

### Login Screen

### Signup Screen

**File**: [lib/screens/auth/signup_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/auth/signup_screen.dart)

### Functionality
The signup screen allows new users to create accounts with email, password, username, and optional profile picture.

### Key Features
- **User Registration**: Create new account with email and password
- **Profile Information**: Collect username and optional profile picture
- **Password Confirmation**: Verify password matching
- **Image Selection**: Profile picture upload from device gallery
- **Form Validation**: Comprehensive validation for all fields
- **Loading State**: Visual feedback during registration process

### UI Components
- Gradient background with brand colors
- App logo display
- Username input field
- Email input field with validation
- Password input field with visibility toggle
- Confirm password field
- Profile picture picker with preview
- Signup button with loading indicator
- "Already have an account?" login link

### Technical Implementation
- Uses ImagePicker for profile picture selection
- Implements base64 encoding for image storage
- Handles Firebase user creation and automatic login
- Validates all form fields with appropriate error messages
- Supports optional profile picture upload

### Signup Flow
1. User fills in required information
2. Optional profile picture selection
3. Form validation ensures all requirements met
4. Registration request sent to Firebase
5. Success: Account created and user logged in automatically
6. Failure: Display appropriate error message

### Error Handling
- Weak password requirements
- Email already in use
- Invalid email format
- Username too short
- Image selection errors
- Network connectivity issues

### Forgot Password Screen

**File**: [lib/screens/auth/forgot_password_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/auth/forgot_password_screen.dart)

### Functionality
The forgot password screen allows users to reset their password by sending a reset link to their email address.

### Key Features
- **Password Reset Request**: Send reset link to user's email
- **Email Validation**: Ensure valid email format
- **User Feedback**: Clear messaging about email delivery
- **Navigation**: Easy return to login screen
- **Loading State**: Visual feedback during request processing

### UI Components
- Gradient background with brand colors
- Lock reset icon
- "Forgot Password?" title
- Instructional subtitle text
- Email input field with validation
- "Send Reset Link" button with loading indicator
- Informational card about spam folder
- "Back to Login" navigation button

### Technical Implementation
- Uses Firebase Authentication password reset functionality
- Implements form validation for email format
- Provides clear success/error messaging
- Automatically navigates back to login after success
- Handles various Firebase authentication errors

### Password Reset Flow
1. User enters email address
2. Form validation ensures proper email format
3. Password reset request sent to Firebase
4. Success: Email sent notification and automatic navigation to login
5. Failure: Display appropriate error message

### Error Handling
- Invalid email format
- Email not found in system
- Network connectivity issues
- Firebase configuration errors

## Main Application Screens

### Dashboard Screen

**File**: [lib/screens/dashboard_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/dashboard_screen.dart)

### Functionality
The dashboard serves as the main navigation hub for the application, providing access to all major sections.

### Key Features
- **Bottom Navigation**: Tab-based navigation between main sections
- **Screen Management**: Uses IndexedStack for efficient screen switching
- **AppBar Integration**: Consistent app bar across all screens
- **Theme Support**: Adapts to light/dark theme preferences

### UI Components
- Custom AppBar with theme support
- Bottom navigation bar with three destinations
- Screen container with rounded top corners
- Home, My Course, and Profile screen placeholders

### Technical Implementation
- Uses IndexedStack for tab navigation to preserve screen state
- Implements GetX for state management
- Integrates with ThemeController for theme switching
- Uses DashBoardController for tracking current tab

### Navigation Tabs
1. **Home**: [HomeScreen](#home-screen) - Main dashboard with course overview
2. **My Course**: [MyCourseScreen](#my-course-screen) - User's enrolled courses
3. **Profile**: [ProfileScreen](#profile-screen) - User profile and settings

### Dashboard Screen

### Home Screen

**File**: [lib/screens/home_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/home_screen.dart)

### Functionality
The home screen serves as the main dashboard, displaying user progress, enrolled courses, and available courses.

### Key Features
- **User Welcome**: Personalized greeting with username
- **Progress Tracking**: Visual indicators for enrolled course progress
- **Course Discovery**: Grid view of all available courses
- **Enrollment Status**: Clear indication of enrolled vs. available courses
- **Responsive Design**: Adapts to different screen sizes

### UI Components
- Welcome message with user's name
- Progress cards for enrolled courses
- "Available Courses" section with grid layout
- Course cards with icons and enrollment status
- Loading indicators for data fetching

### Technical Implementation
- Uses GetX observables for reactive UI updates
- Implements lazy loading for course data
- Calculates progress based on completed subtopics
- Handles both detailed and simple course structures
- Supports SVG and PNG course icons

### Content Sections
1. **Header**: Welcome message and user identification
2. **Enrolled Courses Progress**: Progress cards for each enrolled course
3. **Available Courses**: Grid of all courses in the system

### Home Screen

### My Course Screen

**File**: [lib/screens/my_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/my_course_screen.dart)

### Functionality
The My Course screen displays all courses the user has enrolled in, with options to access course content or remove enrollments.

### Key Features
- **Enrolled Courses Display**: Grid view of user's enrolled courses
- **Course Management**: Edit mode for removing courses
- **Refresh Capability**: Pull-to-refresh for updating course data
- **Empty State**: Friendly message when no courses are enrolled
- **Course Access**: Direct navigation to enrolled course content

### UI Components
- "My Courses" header with edit toggle
- Grid layout of enrolled course cards
- Course icons with name display
- Remove button in edit mode
- Empty state illustration and messaging
- Refresh indicator for data updates

### Technical Implementation
- Uses GetX observables for reactive course list updates
- Implements pull-to-refresh for data synchronization
- Supports edit mode for course removal
- Handles course icon display (SVG, PNG, or fallback)
- Integrates with CourseController for enrollment management

### Content Sections
1. **Header**: "My Courses" title with edit toggle
2. **Course Grid**: Visual representation of enrolled courses
3. **Empty State**: Message and illustration when no courses enrolled

### My Course Screen

### Profile Screen

**File**: [lib/screens/profile_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/profile_screen.dart)

### Functionality
The profile screen displays user information, statistics, enrolled courses, and achievements.

### Key Features
- **User Information**: Display of username, email, and profile picture
- **Statistics Overview**: Summary of enrolled courses and achievements
- **Course Management**: Quick access to enrolled courses
- **Achievement Display**: Grid view of earned achievements
- **Profile Editing**: Direct navigation to edit profile screen
- **Theme Support**: Adapts to light/dark theme preferences

### UI Components
- Profile header with gradient background
- User avatar with edit overlay
- Username and email display
- Premium member badge
- Statistics cards (enrolled courses, achievements)
- Course grid with icons
- Achievement grid with earned badges
- Empty state messages for courses and achievements

### Technical Implementation
- Uses GetX observables for reactive user data updates
- Implements lazy loading for user data
- Supports various image formats (base64, network URLs)
- Integrates with multiple controllers (Auth, Course, Dashboard)
- Handles navigation to related screens

### Content Sections
1. **Profile Header**: User information with gradient background
2. **Statistics**: Enrolled courses and achievements overview
3. **My Courses**: Grid of enrolled courses
4. **Achievements**: Grid of earned achievements

### Profile Screen

## Course Related Screens

### Course Details Screen

**File**: [lib/screens/course_details_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/course_details_screen.dart)

### Functionality
The course details screen provides comprehensive information about a specific course and allows users to enroll.

### Key Features
- **Course Information**: Detailed description of course content
- **Topic Overview**: List of topics covered in the course
- **Enrollment Management**: Enroll in courses or view enrollment status
- **Authentication Gate**: Requires login for enrollment
- **Visual Appeal**: Attractive course header with icons

### UI Components
- Course header with gradient background
- Course icon display
- Course name and description
- "What you'll learn" section with topic grid
- "Enroll Now" button with visual feedback
- Login requirement messaging

### Technical Implementation
- Checks authentication status before enrollment
- Prevents duplicate course enrollment
- Uses CourseController for enrollment operations
- Supports various icon formats (SVG, PNG, fallback)
- Provides clear user feedback for all actions

### Content Sections
1. **Header**: Course name and icon with gradient background
2. **Description**: Detailed course information
3. **Topics**: Grid of topics covered in the course
4. **Enrollment**: Call-to-action button for course enrollment

### Course Details Screen

### Enrolled Course Screen

**File**: [lib/screens/enrolled_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enrolled_course_screen.dart)

### Functionality
The enrolled course screen displays detailed information about a specific enrolled course and provides access to its content.

### Key Features
- **Course Overview**: Header with course information and topic count
- **Topic Navigation**: List of course topics with content status
- **Content Access**: Direct navigation to subtopics or topic details
- **Coming Soon Indicators**: Visual cues for topics without content
- **Responsive Design**: Adapts to different screen sizes

### UI Components
- Course header with gradient background
- Course icon display
- Course name and topic count
- Topics list with navigation arrows
- "Coming Soon" badges for incomplete topics
- Empty state handling

### Technical Implementation
- Dynamically determines navigation path based on topic structure
- Checks for content availability before navigation
- Uses GetX for state management
- Supports both detailed topics with subtopics and simple topics
- Provides user feedback for unavailable content

### Content Sections
1. **Header**: Course information with gradient background
2. **Topics**: List of course topics with navigation options
3. **Content Status**: Visual indicators for available content

### Enrolled Course Screen

### Subtopics Screen

**File**: [lib/screens/enrolled_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enrolled_course_screen.dart)

### Functionality
The subtopics screen displays all subtopics within a specific topic, allowing users to access detailed content.

### Key Features
- **Topic Context**: Clear indication of parent topic and course
- **Subtopic List**: Grid or list view of all subtopics
- **Content Status**: Visual indicators for available content
- **Navigation**: Direct access to subtopic details
- **Coming Soon Indicators**: Visual cues for subtopics without content

### UI Components
- Header with course name context
- Subtopic count display
- Subtopics list with navigation arrows
- "Coming Soon" badges for incomplete subtopics
- Empty state handling

### Technical Implementation
- Dynamically builds subtopic list from topic data
- Checks for content availability before navigation
- Uses GetX for state management
- Provides user feedback for unavailable content
- Supports responsive layout for different screen sizes

### Content Sections
1. **Header**: Course context information
2. **Subtopics**: List of subtopics with navigation options
3. **Content Status**: Visual indicators for available content

### Subtopics Screen

### Subtopic Details Screen

**File**: [lib/screens/enrolled_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enrolled_course_screen.dart)

### Functionality
The subtopic details screen provides comprehensive information about a specific subtopic, including description, video content, tutorial links, and quiz access.

### Key Features
- **Subtopic Information**: Header with subtopic, topic, and course context
- **Description**: Detailed explanation of subtopic content
- **Video Content**: Embedded video player for tutorial videos
- **Tutorial Links**: External resources for additional learning
- **Quiz Access**: Direct navigation to subtopic quiz
- **Responsive Design**: Adapts to different screen sizes

### UI Components
- Subtopic header with gradient background
- Context information (topic name, course name)
- Description section with styled text
- Video player widget for YouTube content
- Tutorial link with clickable interface
- "Take Quiz" button with visual feedback

### Technical Implementation
- Integrates with YouTube player for video content
- Uses url_launcher for external tutorial links
- Handles various video URL formats
- Provides clear navigation to quiz screen
- Supports responsive layout for different screen sizes

### Content Sections
1. **Header**: Subtopic context with gradient background
2. **Description**: Detailed subtopic information
3. **Video Content**: Embedded tutorial videos
4. **Tutorial Links**: External learning resources
5. **Quiz Access**: Call-to-action for subtopic quiz

### Subtopic Details Screen

### Topic Details Screen

**File**: [lib/screens/enrolled_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enrolled_course_screen.dart)

### Functionality
The topic details screen provides information about topics that don't have subtopics, including description, tutorial links, and quiz access.

### Key Features
- **Topic Information**: Header with topic and course context
- **Description**: Detailed explanation of topic content
- **Tutorial Links**: External resources for additional learning
- **Quiz Access**: Direct navigation to topic quiz
- **Responsive Design**: Adapts to different screen sizes

### UI Components
- Topic header with course context
- Description section with styled text
- Tutorial link with clickable interface
- "Take Quiz" button with visual feedback

### Technical Implementation
- Handles topics without subtopics in course structure
- Uses url_launcher for external tutorial links
- Provides clear navigation to quiz screen
- Supports responsive layout for different screen sizes

### Content Sections
1. **Header**: Topic context with course information
2. **Description**: Detailed topic information
3. **Tutorial Links**: External learning resources
4. **Quiz Access**: Call-to-action for topic quiz

### Topic Details Screen

## Quiz Screens

### Subtopic Quiz Screen

**File**: [lib/screens/enrolled_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enrolled_course_screen.dart)

### Functionality
The subtopic quiz screen presents questions related to a specific subtopic, tracks user answers, and provides results upon completion.

### Key Features
- **Question Navigation**: Progress through multiple questions
- **Answer Selection**: Radio button interface for answer selection
- **Progress Tracking**: Visual indicators for quiz progress
- **Results Display**: Score calculation and performance feedback
- **Achievement Recording**: Automatic recording of completed subtopics

### UI Components
- Progress bar showing current question
- Question text display
- Answer options with radio button selection
- Navigation buttons (Previous, Next, Submit)
- Results screen with score and feedback
- "Complete Subtopic" action button

### Technical Implementation
- Manages user answers with state tracking
- Calculates scores based on correct answers
- Integrates with CourseController for achievement recording
- Provides visual feedback for user interactions
- Handles navigation between questions and results

### Quiz Flow
1. Display questions one by one
2. Track user answer selections
3. Allow navigation between questions
4. Calculate final score upon submission
5. Display results with performance feedback
6. Record achievement for completed subtopic

### Subtopic Quiz Screen

### Quiz Screen

**File**: [lib/screens/enrolled_course_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enrolled_course_screen.dart)

### Functionality
The quiz screen presents questions related to a topic (for topics without subtopics), tracks user answers, and provides results upon completion.

### Key Features
- **Question Navigation**: Progress through multiple questions
- **Answer Selection**: Radio button interface for answer selection
- **Progress Tracking**: Visual indicators for quiz progress
- **Results Display**: Score calculation and performance feedback
- **Achievement Recording**: Automatic recording of completed topics

### UI Components
- Progress bar showing current question
- Question text display
- Answer options with radio button selection
- Navigation buttons (Previous, Next, Submit)
- Results screen with score and feedback
- "Complete Topic" action button

### Technical Implementation
- Manages user answers with state tracking
- Calculates scores based on correct answers
- Integrates with CourseController for achievement recording
- Provides visual feedback for user interactions
- Handles navigation between questions and results

### Quiz Flow
1. Display questions one by one
2. Track user answer selections
3. Allow navigation between questions
4. Calculate final score upon submission
5. Display results with performance feedback
6. Record achievement for completed topic

### Quiz Screen

## Profile Management Screens

### Edit Profile Screen

**File**: [lib/screens/edit_profile_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/edit_profile_screen.dart)

### Functionality
The edit profile screen allows users to update their profile information, including username, profile picture, and password.

### Key Features
- **Profile Information**: Update username and profile picture
- **Password Management**: Secure password change functionality
- **Image Selection**: Profile picture upload from device gallery
- **Form Validation**: Comprehensive validation for all fields
- **Visual Feedback**: Clear success/error messaging

### UI Components
- Profile picture preview with camera overlay
- "Change Profile Picture" button
- Username input field with validation
- "Update Profile" action button
- Password change section with toggle
- Current, new, and confirm password fields
- "Change Password" action button

### Technical Implementation
- Uses ImagePicker for profile picture selection
- Implements form validation for all input fields
- Handles password change with Firebase Authentication
- Provides base64 encoding for image storage
- Supports various image formats (network URLs, base64)

### Edit Profile Sections
1. **Profile Picture**: Preview and change functionality
2. **Username**: Edit field with validation
3. **Password Change**: Toggle section with password fields

### Edit Profile Screen

### Enhanced Achievements Screen

**File**: [lib/screens/enhanced_achievements_screen.dart](file:///D:/Flutter/skillorbit/lib/screens/enhanced_achievements_screen.dart)

### Functionality
The enhanced achievements screen provides detailed tracking of user progress across all enrolled courses, with visual indicators and achievement history.

### Key Features
- **Overall Progress**: Visual representation of total learning progress
- **Course-wise Tracking**: Detailed progress for each enrolled course
- **Achievement Timeline**: Chronological display of earned achievements
- **Progress Visualization**: Circular and linear progress indicators
- **Detailed Statistics**: Subtopic completion tracking

### UI Components
- Header with overall progress display
- Circular progress indicator with percentage
- Course progress cards with detailed metrics
- Achievement timeline with chronological sorting
- Empty state messaging for no achievements
- Detailed achievement view with modal display

### Technical Implementation
- Calculates progress based on completed subtopics
- Groups achievements by course for organized display
- Implements custom progress visualization components
- Uses GetX for reactive achievement updates
- Provides detailed achievement information in modal views

### Content Sections
1. **Header**: Overall progress with circular indicator
2. **Course Progress**: Detailed cards for each course
3. **Achievement Timeline**: Chronological list of achievements
4. **Detailed Views**: Modal displays for achievement information

### Enhanced Achievements Screen