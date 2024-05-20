plugins {
    id("java")
}

group = "ru.medoedoed"
version = "1.0-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation("org.postgresql:postgresql:42.7.3")
    implementation("org.knowm.xchart:xchart:3.2.2")
}

tasks.test {
    useJUnitPlatform()
}