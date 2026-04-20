#!/bin/bash

# YouTube-like Cassandra Application Runner
# This script builds and runs the application

set -e

PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
JAR_FILE="$PROJECT_DIR/target/lab3_3-1.0-SNAPSHOT.jar"

echo "=================================="
echo "YouTube Cassandra App - Lab 3.3"
echo "=================================="
echo ""

# Check if Java is installed
if ! command -v java &> /dev/null; then
    echo "❌ Java is not installed. Please install Java 21 or higher."
    exit 1
fi

JAVA_VERSION=$(java -version 2>&1 | head -n 1)
echo "✓ Java found: $JAVA_VERSION"
echo ""

# Build the project if JAR doesn't exist or if source files are newer
if [ ! -f "$JAR_FILE" ]; then
    echo "Building project (JAR not found)..."
    cd "$PROJECT_DIR"
    mvn clean package -q
    echo "✓ Project built successfully"
    echo ""
elif [ "$(find "$PROJECT_DIR/src/main/java" -newer "$JAR_FILE" 2>/dev/null | wc -l)" -gt 0 ]; then
    echo "Source files have changed, rebuilding..."
    cd "$PROJECT_DIR"
    mvn clean package -q
    echo "✓ Project rebuilt successfully"
    echo ""
fi

# Check if Cassandra is running
echo "Checking Cassandra connection..."
if timeout 2 bash -c "echo > /dev/tcp/127.0.0.1/9042" 2>/dev/null; then
    echo "✓ Cassandra is running on localhost:9042"
else
    echo "⚠️  Warning: Cannot connect to Cassandra on localhost:9042"
    echo "   Make sure Cassandra is running before executing the application."
    read -p "   Continue anyway? (y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 1
    fi
fi
echo ""

# Run the application
echo "Starting application..."
echo "=================================="
echo ""

java -jar "$JAR_FILE"

echo ""
echo "=================================="
echo "Application finished"
echo "=================================="

