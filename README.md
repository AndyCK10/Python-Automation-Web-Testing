# Python Automation Web Testing (Robot Framework)

โปรเจคตัวอย่างสำหรับฝึกเขียน Automation Test ด้วย **Robot Framework + SeleniumLibrary** ครอบคลุมตั้งแต่พื้นฐานภาษา Robot ไปจนถึงการทำ **Data-Driven Testing** ด้วยไฟล์ Excel โดยใช้เว็บเครื่องคิดเลขสินเชื่อ (Bankrate Loan Calculator) และเครื่องคิดเลขอัตราสิ้นเปลืองน้ำมัน (calculator.net) เป็นระบบที่ใช้ทดสอบ

## สิ่งที่ต้องมี

- Python 3.10+
- Google Chrome (Selenium 4 จะจัดการ ChromeDriver ให้อัตโนมัติ)
- ไฟล์ Excel ใน `testdata/` ต้อง **ปิดโปรแกรม Excel** ก่อนรันเทส เพราะเทสจะเขียนผลกลับลงไฟล์

## การติดตั้ง

```powershell
python -m venv env
env\Scripts\activate
pip install robotframework robotframework-seleniumlibrary openpyxl
```

## วิธีรัน

```powershell
# รันทั้งไฟล์
robot labtest03_excel.robot

# รันเฉพาะ test case
robot -t TC002_LoanCalculator labtest03_excel.robot

# รันตาม tag
robot -i UAT labtest02_selenium.robot

# เก็บผลลัพธ์ไว้ในโฟลเดอร์แยก
robot -d result labtest03_excel.robot
```

ผลลัพธ์ที่ได้: `output.xml`, `log.html`, `report.html` (ถูกใส่ไว้ใน `.gitignore` แล้ว)

## โครงสร้างโปรเจค

```
.
├── labtest.robot               # พื้นฐาน: ตัวแปร, list, dict, IF/ELSE, FOR
├── labtest01.robot             # พื้นฐานเช่นเดียวกับ labtest.robot (เวอร์ชันสั้น)
├── labtest02_selenium.robot    # Selenium: Gas Mileage Calculator + Tags + Keyword
├── labtest_selenium.robot      # Selenium เวอร์ชันแรก (ดูหมายเหตุด้านล่าง)
├── labtest03_excel.robot       # Data-Driven: Loan Calculator อ่าน/เขียน Excel (เวอร์ชันล่าสุด)
├── labtest_excel.robot         # Data-Driven เวอร์ชันแรก
├── library/
│   ├── ExcelLib.py             # Custom library อ่าน/เขียน Excel ด้วย openpyxl
│   └── KeywordsDocument.html   # เอกสาร keyword ของ ExcelLib
└── testdata/
    ├── LoanCalculator.xlsx     # ข้อมูลทดสอบ Loan Calculator
    └── BMR_Calculator.xlsx     # ข้อมูลทดสอบ BMR (ยังไม่มี test case ใช้งาน)
```

## รายละเอียดแต่ละไฟล์

| ไฟล์ | เนื้อหา |
|---|---|
| `labtest.robot`, `labtest01.robot` | ฝึกตัวแปร `${}`, `@{}`, `&{}`, `Evaluate`, `Set Global Variable`, `IF/ELSE`, `FOR ... IN RANGE`, `Exit For Loop If` (`TC005_Demo5` ตั้งใจให้ **FAIL** เพื่อสาธิต `Fail`: 50+3 ≠ 55) |
| `labtest02_selenium.robot` | กรอกฟอร์ม Gas Mileage Calculator แล้วอ่านผลลัพธ์ ใช้ `Test Setup`, `[Tags]` (UAT, SIT, Regression, Functional) และ user keyword ที่รับ argument |
| `labtest03_excel.robot` | `TC001` ทดสอบอ่าน/เขียน Excel, `TC002` วนอ่านข้อมูลจาก sheet `TestData` กรอกลงเว็บ Bankrate เทียบค่า monthly payment กับ `ExpectResult` แล้วเขียน `ActualResult` / `TestStatus` กลับลงไฟล์ |

### รูปแบบข้อมูลใน `LoanCalculator.xlsx` (sheet `TestData`)

| คอลัมน์ | ความหมาย |
|---|---|
| A `LoanAmount` | ยอดเงินกู้ |
| B `LoanTermInYear` | ระยะเวลา (ปี) |
| C `InterestRatePerYear` | อัตราดอกเบี้ยต่อปี (%) |
| D `ExpectResult` | ค่างวดที่คาดหวัง |
| E `RunStatus` | `Yes` = รัน, อย่างอื่น = ข้าม |
| F `ActualResult` | ผลจริง (เทสเขียนให้) |
| G `TestStatus` | `Pass` / `Fail` (เทสเขียนให้) |

## ExcelLib keywords

`Open Excel`, `Open Excel Formula`, `Save Excel`, `Close Excel`, `Read Cell Data`, `Read Cell Data By Name`, `Write Cell Data`, `Write Cell Data By Name`, `Clear Cell Data`, `Clear Cell Data By Name`, `Get Row Count`, `Get Column Count`, `Get Sheets Count`, `Get Sheets Name`, `Get Sheets Name By Index`, `Add Workbook`, `Add Worksheet`, `Insert Row`, `Delete Row`, `Set Font Bold`, `Set Font Color`

ดูตัวอย่างการใช้งานได้ใน `library/KeywordsDocument.html`

## ข้อควรระวัง / ปัญหาที่ทราบ

- Locator ของเว็บ Bankrate ใหม่ใช้ id ที่ React สร้างขึ้น (`:r0:`, `:r1:`, `:r4:`) ซึ่งอาจเปลี่ยนเมื่อเว็บอัปเดต ถ้าเทสพังให้ตรวจ locator เป็นอันดับแรก
- เว็บภายนอกอาจมี CAPTCHA/โฆษณา ทำให้เทสไม่เสถียร
- `Open Excel` โหลดไฟล์แบบ `data_only=True` ดังนั้นการ `Save Excel` จะแทนที่สูตรในไฟล์ด้วยค่าที่คำนวณไว้ ถ้าต้องการรักษาสูตรให้ใช้ `Open Excel Formula`
- `Write Cell Data` บันทึกค่าเป็นข้อความ (string) เสมอ

## ผู้พัฒนา

AndyCK10
