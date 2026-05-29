//
//  README.md
//  ReflexTest
//
//  Created by Ploypan on 30/5/2569 BE.
//

# Reflex Test Application

## 1. Project Overview

Reflex Test เป็นแอปพลิเคชันเกมบนระบบปฏิบัติการ iOS ที่พัฒนาด้วยภาษา Swift และเฟรมเวิร์ก SwiftUI โดยมีวัตถุประสงค์เพื่อวัดความเร็วในการตอบสนอง (Reaction Time) ของผู้เล่นผ่านการสังเกตสีที่ปรากฏบนหน้าจอและแตะวงกลมให้ถูกต้องตามเงื่อนไขที่กำหนด

เกมนี้ถูกออกแบบให้แตกต่างจากเกม Reflex Test ทั่วไป โดยผู้เล่นจะต้องสังเกต “สีเป้าหมาย (Target Color)” ที่ระบบสุ่มขึ้นในแต่ละรอบ และรอให้สีดังกล่าวปรากฏบนวงกลมหลักของเกม เมื่อสีเป้าหมายปรากฏ ผู้เล่นจะต้องแตะวงกลมให้เร็วที่สุด หากแตะสีที่ไม่ใช่สีเป้าหมายจะถือว่าแพ้ทันที

ระบบยังสามารถบันทึกสถิติการเล่น รวมถึงเปิดโอกาสให้ผู้เล่นปรับแต่งจำนวนสีที่ใช้ในเกมได้ตามต้องการ เพื่อเพิ่มหรือลดระดับความยากของเกม

---

## 2. Objectives

1. เพื่อพัฒนาแอปพลิเคชันเกมบนระบบ iOS ด้วยภาษา Swift
2. เพื่อศึกษาแนวทางการพัฒนา User Interface ด้วย SwiftUI

---

## 3. Game Concept

เกม Reflex Test ใช้แนวคิดของการวัดความเร็วในการตอบสนองของมนุษย์ โดยผสมผสานการสังเกตสีและการตัดสินใจเข้าด้วยกัน

ในแต่ละรอบ ระบบจะสุ่มสีเป้าหมายขึ้นมา 1 สี จากกลุ่มสีที่ผู้เล่นกำหนดไว้ เช่น

* Blue
* Red
* Green
* Yellow
* Purple
* Orange
* Pink
* Cyan

หลังจากเริ่มเกม ระบบจะสุ่มแสดงสีต่าง ๆ บนวงกลมหลักของเกมทีละสี โดยแต่ละสีจะปรากฏเป็นระยะเวลาที่แตกต่างกัน

ผู้เล่นต้องรอจนกว่าสีเป้าหมายจะปรากฏ และแตะวงกลมภายในเวลาที่กำหนด

---

## 4. Gameplay Flow

### 4.1 Home Screen

หน้าหลักของเกมแสดงข้อมูลสำคัญดังนี้

* Best Time
* Average Time
* Number of Attempts
* Start Button

ผู้เล่นสามารถกดปุ่ม Start เพื่อเข้าสู่หน้าเกม

---

### 4.2 Ready Phase

เมื่อเข้าสู่หน้าเกม ระบบจะอยู่ในสถานะ Ready

หน้าจอจะแสดงข้อความ

READY?

และผู้เล่นต้องแตะวงกลม Ready เพื่อเริ่มเกม

เกมจะยังไม่เริ่มทำงานจนกว่าผู้เล่นจะกด Ready

---

### 4.3 Target Selection Phase

หลังจากผู้เล่นกด Ready

ระบบจะสุ่ม

Target Color

ขึ้นมา 1 สี จากชุดสีที่ผู้เล่นเลือกไว้

ตัวอย่าง

Target Color = BLUE

จากนั้นระบบจะแสดงสีเป้าหมายบนหน้าจอ

Target Color: BLUE

---

### 4.4 Running Phase

เมื่อเกมเริ่มทำงาน

ระบบจะสุ่มสีต่าง ๆ มาแสดงบนวงกลม

ตัวอย่าง

RED

YELLOW

PURPLE

BLUE

GREEN

ORANGE

โดยแต่ละสีจะมีระยะเวลาการแสดงผลแตกต่างกัน

---

### 4.5 Correct Tap

หากผู้เล่นแตะวงกลมขณะที่สีเป้าหมายปรากฏอยู่

เช่น

Target Color = BLUE

Current Color = BLUE

ระบบจะ

* หยุดเวลา
* คำนวณผลลัพธ์
* บันทึกสถิติ
* แสดง Result Screen

---

### 4.6 Wrong Tap

หากผู้เล่นแตะวงกลมในขณะที่สีที่แสดงไม่ใช่สีเป้าหมาย

เช่น

Target Color = BLUE

Current Color = RED

ระบบจะถือว่า Fail

และแสดงข้อความ

FAILED

จากนั้นรอประมาณ 1.2 วินาที ก่อนเข้าสู่หน้าผลลัพธ์

---

### 4.7 Missed Target

หากสีเป้าหมายปรากฏขึ้นแต่ผู้เล่นไม่แตะภายในเวลาที่กำหนด

ระบบจะถือว่าผู้เล่นพลาดโอกาสในรอบนั้น

และนำระยะเวลาที่พลาดทั้งหมดไปรวมในการคำนวณผลลัพธ์

ตัวอย่าง

Target Color รอบแรก

BLUE 1.0 วินาที

ผู้เล่นไม่กด

Target Color รอบที่สอง

BLUE 0.8 วินาที

ผู้เล่นกดหลังจากปรากฏ 0.2 วินาที

ผลลัพธ์

Missed Time = 1.0 วินาที

Reaction Time = 0.2 วินาที

This Round = 1.2 วินาที

---

## 5. Result Screen

หลังจบเกม ระบบจะแสดงผลลัพธ์

### Success

* Best Time
* This Round
* Missed Time

### Fail

* FAIL
* Best Time
* Missed Time

พร้อมปุ่ม

* Play Again
* Back To Home

---

## 6. Settings System

ผู้เล่นสามารถกำหนดสีที่ใช้ภายในเกมได้

ตัวอย่าง

เปิดใช้งาน

* Blue
* Red
* Green
* Yellow

หรือ

* Blue
* Purple
* Orange
* Cyan
* Pink

ระบบจะสุ่มสีเป้าหมายและสีที่แสดงจากสีที่เปิดใช้งานเท่านั้น

ข้อกำหนด

* ต้องมีอย่างน้อย 2 สี
* สามารถเลือกได้สูงสุด 8 สี
* สามารถ Reset กลับค่าเริ่มต้นได้

---

## 7. Application Architecture

โครงสร้างโปรเจกต์แบ่งตามหน้าที่ดังนี้

### Models

GameColor.swift

ใช้เก็บข้อมูลสีของเกม

GamePhase.swift

ใช้กำหนดสถานะของเกม

* Ready
* Running
* Success
* Failed

GameSettings.swift

ใช้เก็บค่าการตั้งค่าของเกม

---

### Managers

GameManager.swift

จัดการ

* Best Time
* Average Time
* Attempts

SettingsManager.swift

จัดการ

* สีที่เลือก
* บันทึก UserDefaults
* โหลดการตั้งค่า

GameEngine.swift

จัดการ Logic หลักของเกม

* สุ่มสี
* สุ่มเวลา
* ตรวจจับการกด
* คำนวณผลลัพธ์

AppNavigationManager.swift

จัดการการเปลี่ยนหน้าและ Tab Navigation

---

### Views

HomeView.swift

หน้าแรกของแอป

GameView.swift

หน้าเล่นเกม

ResultView.swift

หน้าแสดงผลลัพธ์

SettingsView.swift

หน้าตั้งค่า

---

### Components

AnimatedColorCircle.swift

วงกลมหลักของเกม

ColorSelectionButton.swift

ปุ่มเลือกสี

ResultRow.swift

แถวแสดงข้อมูลผลลัพธ์

StatRow.swift

แถวแสดงสถิติ

---

## 8. Technologies Used

* Swift
* SwiftUI
* Combine
* UserDefaults
* Xcode
* Git
* GitHub

---
