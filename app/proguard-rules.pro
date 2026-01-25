	ISO 9001:2015, Quality management systems — Requirements
[2]	ISO 23462, Space systems — Guidelines to define the management framework for a space project
[3]	ISO 10789, Space systems — Programme management — Information and documentation management
[4]	ISO 10794, Space systems — Programme management — Material, mechanical parts and processes
[5]	ISO 11231, Space systems — Probabilistic risk assessment (PRA)
[6]	ISO 14620-1, Space systems — Safety requirements — Part 1: System safety
[7]	ISO 14621-1, Space systems — Electrical, electronic and electromechanical (EEE) parts — Part 1: Parts management
[8]	ISO 14621-2, Space systems — Electrical, electronic and electromechanical (EEE) parts — Part 2: Control programme requirements
[9]	ISO 15865, Space systems — Qualification assessment
[10]	ISO 16290, Space systems — Definition of the Technology Readiness Levels (TRLs) and their criteria of assessment
[11]	ISO 16404, Space systems — Programme management — Requirements management
[12]	ISO 16091, Space systems — Integrated logistic support
[13]	ISO 18676, Space systems — Guidelines for the management of systems engineering
[14]	ISO 21350, Space systems — Off-the-shelf item utilization
[15]	ISO 23461, Space systems — Programme management — Non-conformance control system
[16]	ISO 27025, Space systems — Programme management — Quality assurance requirements# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

-dontobfuscate
#-renamesourcefileattribute SourceFile
#-keepattributes SourceFile,LineNumberTable

# Temp fix for androidx.window:window:1.0.0-alpha09 imported by termux-shared
# https://issuetracker.google.com/issues/189001730
# https://android-review.googlesource.com/c/platform/frameworks/support/+/1757630
-keep class androidx.window.** { *; }
