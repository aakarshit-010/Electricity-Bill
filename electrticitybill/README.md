# Electricity Bill Calculator

A simple Java web application that calculates an electricity bill based on unit slabs.

## What is included

- Maven WAR project
- Servlet controller for bill calculation
- JSP front end
- `web.xml` configured for Tomcat 9 / Java EE servlet APIs

## Files you should keep in git

- `pom.xml`
- `src/main/java`
- `src/main/webapp`
- `README.md`
- `.gitignore`

## Files you should not commit

- `.classpath`
- `.project`
- `.settings/`
- `target/`
- `apache-tomcat-9.0.100/`
- screenshot or log files that are only local editor output

## How to build

You need:

- JDK 17
- Apache Maven 3.8 or newer
- Apache Tomcat 9.x

Then from the project root run:

```bash
mvn clean package
```

This creates a WAR file under `target/`.

## How to run

1. Copy the generated WAR file from `target/` into Tomcat's `webapps` folder.
2. Start Tomcat.
3. Open the app in a browser.

If you want to run it from an IDE, import it as a Maven project and deploy it to Tomcat 9.

## Notes

- The app uses `javax.servlet` APIs, so Tomcat 9 is the correct runtime.
- Do not mix this project with Tomcat 10+ unless the code is migrated to `jakarta.servlet`.