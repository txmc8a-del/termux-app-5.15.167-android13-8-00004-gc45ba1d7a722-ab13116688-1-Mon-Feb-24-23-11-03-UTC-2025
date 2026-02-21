	package com.termux.terminal;
---
title: Test Cards
---

# Mastercard Test Cards

**Test Cards to Receive PAN Data**

| Card Number | Expiry Date | CVV |
| --- | --- | --- |
| 5186001700008785 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700009726 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700009908 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700008876 | _Any Future Date_ | _Any 3 digits_ |
| 5186001700001434 | _Any Future Date_ | _Any 3 digits_ |

**Test Cards to Receive Token Data**

| Card Number | Expiry Date | CVV |
| --- | --- | --- |
| 5120350100064537 | 03/2029 | 191 |
| 5120350100064545 | _Any Future Date_ | _Any 3 digits_ |
| 5120350100064552 | _Any Future Date_ | _Any 3 digits_ |
| 5120350100064560 | _Any Future Date_ | _Any 3 digits_ |
| 5120350100064578 | _Any Future Date_ | _Any 3 digits_ |

# Visa Test Cards

**Test Cards to Receive PAN Data or Token Data**

| Card Number | Expiry Date | CVV |
| --- | --- | --- |
| 4622943127011022 | 2029 / 12 | 667 |
| 4622943127011030 | 2029 / 12 | 627 |
| 4622943127011048 | 2029 / 12 | 991 |
| 4622943127011055 | 2029 / 12 | 323 |
| 4622943127011063 | 2029 / 12 | 665 |
| 4622943127011071 | 2029 / 12 | 839 |
| 4622943127011089 | 2029 / 12 | 572 |
| 4622943127010990 | 2029 / 12 | 725 |
| 4622943127011006 | 2029 / 12 | 222 |
| 4622943127011014 | 2029 / 12 | 771 |

> [!NOTE]
> 
> **Use the following Billing Address:**  
> 900 Metro Center Blvd, Foster City, CA 94404

# Amex Test Cards

**Test Cards to Receive PAN Data or Token Data**

Suitable Amex QA test accounts (xx - 37) with static one-time-password configuration for merchants are as follows:

| Card Number | Expiry Date | CVV | Email address |
| :--- | :--- | :--- | :--- |
| 373708623186001 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_1@mailinator.com](mailto:Masterpass_Merchant_SBX_1@mailinator.com) |
| 372280864074008 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_2@mailinator.com](mailto:Masterpass_Merchant_SBX_2@mailinator.com) |
| 377222581193005 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_3@mailinator.com](mailto:Masterpass_Merchant_SBX_3@mailinator.com) |
| 372399427875006 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_4@mailinator.com](mailto:Masterpass_Merchant_SBX_4@mailinator.com) |
| 371316662951004 | 2027 / 12 | 7777 | [Masterpass\_Merchant\_SBX\_5@mailinator.com](mailto:Masterpass_Merchant_SBX_5@mailinator.com) |

# Discover Test Cards

**Test Cards to Receive PAN Data or Token Data**

| Card Type | Card Number | Expiry Date | CVV |
| :--- | :--- | :--- | :--- |
| Green Card | 6011208800050000 | 2028 / 10 | 876 |
| Green Card | 6011300000080000 | 2028 / 09 | 324 |
| Green Card | 6011000000040125 | 2028 / 09 | 324 |
| Green Card | 6011308000010000 | 2028 / 10 | 123 |
| Green Card | 6011298600080000 | 2028 / 09 | 876 |

> [!NOTE]
> 
> There is a personal email address associated with each card, so they can be enrolled to any account. Discover does not use a hard coded OTP value, instead they will send a real OTP to a user’s email address.txmc8a@gmail.com
/**
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
