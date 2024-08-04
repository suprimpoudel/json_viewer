```markdown
# JSON Viewer

A Flutter-based web application that allows users to paste JSON strings, validate them, and view the data in a structured format.

## Live Demo

You can view the live demo of the application at: [https://json-viewer-online.firebaseapp.com/](https://json-viewer-online.firebaseapp.com/)

## Features

- JSON string validation
- Structured JSON data visualization
- Easy-to-use interface

## Dependencies

The project uses the following dependencies:

- `cupertino_icons: ^1.0.6`
- `dio: ^5.5.0+1`
- `equatable: ^2.0.5`
- `file_picker: ^8.0.6`
- `firebase_core: ^3.3.0`
- `flutter_bloc: ^8.1.6`
- `flutter_simple_treeview: ^3.0.2`
- `get_it: ^7.7.0`
- `universal_html: ^2.2.4`

## Setup and Run Locally

To run this project locally, follow these steps:

1. Clone the repository:

   ```bash
   git clone https://github.com/suprimpoudel/json_viewer
   cd json_viewer
   ```

2. Set up your Firebase project and configure environment variables.

3. Run the Flutter web app locally:

   ```bash
   flutter run -d chrome
   ```

## Deployment

To deploy the web app to Firebase, use the provided `build.sh` script:

1. Ensure you have Firebase CLI installed and configured.

2. Create a `build.sh` file in the root directory with the following content:

   ```bash
   #!/bin/bash

   # Set the values for the environment variables
   API_KEY=""
   APP_ID=""
   MESSAGING_SENDER_ID=""
   PROJECT_ID=""
   AUTH_DOMAIN="."
   STORAGE_BUCKET=""
   MEASUREMENT_ID=""

   # Build the Flutter web app with the environment variables
   flutter build web --release \
     --dart-define=API_KEY="$API_KEY" \
     --dart-define=APP_ID="$APP_ID" \
     --dart-define=MESSAGING_SENDER_ID="$MESSAGING_SENDER_ID" \
     --dart-define=PROJECT_ID="$PROJECT_ID" \
     --dart-define=AUTH_DOMAIN="$AUTH_DOMAIN" \
     --dart-define=STORAGE_BUCKET="$STORAGE_BUCKET" \
     --dart-define=MEASUREMENT_ID="$MEASUREMENT_ID"

   # Deploy to Firebase
   firebase deploy
   ```

3. Run the `build.sh` script:

   ```bash
   bash build.sh
   ```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```