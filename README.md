# NextapTask

Sample project that reads the [Steller.co](https://steller.co) API.

## Build Instructions

1. Download or clone the project

    ```bash
    git clone https://github.com/jaimeeee/NextapTask.git
    ````

2. Open NextapTask.xcodeproj

### Dependencies

All dependencies are managed by Swift Package Manager.

#### [Kingfisher](https://github.com/onevcat/Kingfisher)

Kingfisher is used to help downloading images and handle their cache.

#### [Nimble](https://github.com/Quick/Nimble)

Nimble is used as a matcher framework for Unit Testing.

---

#### [SwiftLint](https://github.com/realm/SwiftLint) (Optional)

SwiftLint is used to enforce Swift conventions, and runs when building the project if the tool is installed.
It is not required to run the project.

### Project Description & Structure

The project uses the VIPER+Coordinators architecture, which replaces the Router for Coordinations to handle the app's navigation.

The folder structure is organized by:

| **Folder**       | **Description**                                      |
|------------------|------------------------------------------------------|
| **App**          | UIApplication delegates and dependencies             |
| **Coordinators** | The coordinators that handle the app's navigation    |
| **Entities**     | The project's models.                                |
| **Extensions**   | UIKit helpers and extensions                         |
| **Managers**     | Data managers                                        |
| **Modules**      | Each presented screen as independent VIPER's modules |
| **Protocols**    | Global protocols                                     |
| **Network**      | API models                                           |
| **Resources**    | Xcode files                                          |
| **Services**     | The project's services                               |
