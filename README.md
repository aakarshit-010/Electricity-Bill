# ⚡ Electricity Bill Calculator

> A simple and responsive Java web application that calculates an electricity bill based on slab-wise unit consumption.

## 📌 Overview

Enter the number of electricity units consumed, and the application will calculate the payable amount with a clear breakdown for each slab.

## 🖼️ Screenshot

Upload your project screenshot to the repo as `screenshots/electricity-bill-screenshot.png`, then keep this line in the README:

```md
![Electricity Bill Calculator](screenshots/electricity-bill-screenshot.png)
```

## ✨ Features

- Clean JSP-based user interface
- Servlet-powered bill calculation
- Slab-wise pricing logic
- Responsive Bootstrap styling
- Easy-to-use and beginner-friendly layout

## 🛠️ Tech Stack

- Java 17
- JSP
- Servlets
- Maven
- Tomcat 9

## 📁 Project Structure

- `src/main/java` - servlet logic
- `src/main/webapp` - JSP pages and web resources
- `pom.xml` - Maven build configuration

## 🚀 How to Build

```bash
mvn clean package
```

This creates a WAR file in the `target/` folder.

## ▶️ How to Run

1. Deploy the WAR file to Tomcat 9.
2. Start the Tomcat server.
3. Open the application in your browser.

## 📝 Note

This project uses `javax.servlet` APIs, so Tomcat 9 is the correct runtime.
