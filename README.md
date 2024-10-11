
# Pomodoro Timer

A simple Pomodoro timer app built with SwiftUI for macOS. The app follows the 20-20-20 rule: after every 20 minutes of work, you get a random rest period between 1 to 5 minutes. It also includes sound notifications when the work or rest period ends.

## Features

- Start a 20-minute work session.
- Automatic transition to a rest session (random between 1 to 5 minutes) after work.
- Sound notification at the end of each session (work and rest).
- Pause, resume, and reset functionality.
- Coffee pouring animation during the work session.
- Simple and user-friendly interface.

## Requirements

- macOS 11.0 or later
- Xcode 12 or later
- Swift 5.0 or later

## How to Use

1. Clone the repository:

   ```bash
   git clone https://github.com/amirrmonfared/pomodro.git
   ```

2. Open the project in Xcode:

   ```bash
   cd pomodoro
   open PomodoroTimer.xcodeproj
   ```

3. Add a sound file to the project. Make sure it is named `notification.mp3` and placed in the project directory.
   
4. Build and run the project in Xcode.

## How It Works

- **Start Button**: Starts a 20-minute work session.
- **Stop Button**: Pauses the current session.
- **Resume Button**: Resumes the session from where it was paused.
- **Reset Button**: Resets the timer to its initial state.
- **Sound Notification**: A sound will play when a work or rest session ends.

## Customization

You can modify the app by changing:
- The work session duration (`workTimeRemaining`).
- The rest period range (`restTimeRemaining` is randomly selected between 60 and 300 seconds).
- The sound file (`notification.mp3`) for the notification at the end of a session.


## Contributions

Contributions are welcome! If you would like to contribute, feel free to fork the repository and submit a pull request.

