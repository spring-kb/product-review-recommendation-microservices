
#!/bin/bash

# First, we create the settings.gradle file, which describes what projects Gradle should build
cat <<EOF > settings.gradle
include ':microservices:product-service'
include ':microservices:review-service'
include ':microservices:recommendation-service'
include ':microservices:product-composite-service'
EOF
#  Next, we copy the Gradle executable files that were generated from one of the projects so that we can reuse them for the multi-project builds:
cp -r microservices/product-service/gradle .
cp microservices/product-service/gradlew .
cp microservices/product-service/gradlew.bat .
cp microservices/product-service/.gitignore .
# We no longer need the generated Gradle executable files in each project, so we can remove them with the following commands:
find microservices -depth -name "gradle" -exec rm -rfv "{}" \;
find microservices -depth -name "gradlew*" -exec rm -fv "{}" \;
