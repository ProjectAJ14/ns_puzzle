# Nonstop Puzzle

A collection of puzzle games built with Flutter, featuring a retro NES-style UI.

## Game 1: CAR-T Cell Therapy (River Crossing Puzzle)

A medical-themed river crossing puzzle that teaches CAR-T cell immunotherapy concepts.

### Objective

Transport 3 CAR-T cells and 3 cancer cells from the **Tumor Microenvironment** (right) to the **Lymph Node** (left) using a boat that carries at most 2 cells at a time.

### Rules

- The boat can carry a maximum of 2 cells per trip
- At least 1 cell must be on the boat to move it
- If cancer cells outnumber CAR-T cells on either side, the patient relapses (game over)
- You have 100 seconds to complete the puzzle — score decreases by 1 each second

### Screens

- **Sign In** — Google authentication
- **Game** — Main puzzle gameplay with animated cells and boat
- **Leaderboard** — High scores stored in Firebase Firestore
- **Winner / Game Over** — Victory confetti or loss summary with replay option

## Game 2: Coming Soon

## Tech Stack

- **Flutter** with **GetX** for state management and routing
- **NES UI** for retro pixel-art styled components
- **Firebase** (Auth + Firestore) for sign-in and leaderboard
- **Press Start 2P** font for the retro theme

## Getting Started

```bash
# Clone the repo
git clone <repo-url>
cd ns_puzzle

# Install dependencies
flutter pub get

# Run
flutter run
```

Requires a configured Firebase project with Google Sign-In enabled.

## Project Structure

```
lib/
  app/            # App init, services, dependency injection
  data/models/    # Data models (CARTCell, CancerCell, User)
  game_engine/    # Game logic and kill conditions
  ui/screens/     # Screens (home, sign_in, game, leaderboard)
assets/
  images/         # Game images (cells, boat, terrain, background)
  icons/          # App icons
  fonts/          # Press Start 2P font
```

## Asset Optimization

Game images have been resized to match their on-screen display sizes (accounting for 3x high-DPI screens), reducing total image assets from ~12MB to ~1.8MB with no visible quality loss.
