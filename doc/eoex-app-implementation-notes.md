# EOEX Store App – Recent Changes & Bug Fixes (December 2025)

## Summary
This document details the latest changes, bug fixes, and workflow improvements for the EOEX Store app, focusing on the Netflix-style splash and home screens for both web and Android platforms.

---

## 1. Splash & Home Screen Fixes
- Located and verified `SplashScreen` and `HomeScreen` in both `frontend` and `frontend-old`.
- Migrated splash/home logic into Expo Router structure (`app/(tabs)/index.tsx`) for web.
- Ensured the splash screen appears first, then transitions to the home screen after a delay.
- Confirmed correct wiring in `App.js`, `AppNavigator.js`, and Expo Router.

## 2. Web Browser Launch Fixes
- Fixed Expo web preview always opening in Opera by:
  - Setting `web.browser` to `chrome` in `app.json`.
  - Updating the `web` script in `package.json` to use `BROWSER=google-chrome`.
- Now, `npm run web` always opens the app in Google Chrome.

## 3. JSON & Config Corrections
- Fixed malformed `app.json` (removed duplicate/nested objects, ensured valid JSON).

## 4. Workflow & Save Script
- All changes are committed and pushed using the save workflow script.

## 5. Next Steps (Android)
- The same splash and home screen logic will be applied to the Android emulator.
- Testing and restart instructions included in the workflow.

---

## Bash Save Workflow

```bash
#!/bin/bash
# save-and-push.sh – Save and push all changes for EOEX Store app

git add .
git commit -m "fix: splash/home screens for web, force Chrome, config cleanup, doc update"
git push
```

---

## Testing
- Web: Confirmed splash and home screens render in Chrome.
- Android: [Pending in next steps]

---

*Last updated: 17 December 2025*
