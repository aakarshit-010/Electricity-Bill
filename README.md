# Electricity Bill Calculator

A simple Java web application that calculates an electricity bill using slab-wise pricing.

## Overview

The user enters the number of electricity units consumed, and the application calculates the bill with a breakdown for each slab.

## Features

- Clean JSP-based user interface
- Servlet-based bill calculation
- Slab-wise pricing logic
- Responsive layout with Bootstrap styling

## Tech Stack

- Java 17
- JSP and Servlets
- Maven
- Tomcat 9

## Project Structure

- `src/main/java` - servlet logic
- `src/main/webapp` - JSP pages and web resources
- `pom.xml` - Maven build configuration

## Build

```bash
mvn clean package
```

This creates a WAR file in the `target/` folder.

## Run

1. Deploy the WAR file to Tomcat 9.
2. Start Tomcat.
3. Open the application in a browser.

## Note

This project uses `javax.servlet` APIs, so Tomcat 9 is the right runtime.
