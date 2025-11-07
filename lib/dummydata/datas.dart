List<Map<String,dynamic>> organizationWiseData=[];

List<String> list = [
  "NURSERY",
  "LKG",
  "UKG",
  "GRADE-1",
  "GRADE-2",
  "GRADE-3",
  "GRADE-4",
  "GRADE-5",
  "GRADE-6",
  "GRADE-7",
  "DAY CARE",
  "GRADE 8 STATE SYLLABUS",
  "GRADE 7 STATE SYLLABUS",
];

List<String> nursery = [
  "S BHAVAGNA",
  "K Y HANVITH",
  "JUAN JOJI",
  "M ARSHA",
  "MOKSHITH REDDY SADDALA",
  "S PRANITHA",
  "ZAIN KHAN",
];

List<String> lkg = [
  "AAV GUPTA",
  "AARUSH KIRAN BELGAV",
  "ABHI SAHANI",
  "AFIYA MARIYAM",
  "K AMOGH",
  "MOHAMMED FAIZAN",
  "D NIRVANA",
  "RIYAZ ANSARI",
  "TEJASWINI",
  "A YUVAN",
  "S ZAYAN PASHA",

];

List<String> ukg = [
  "AKSHATHA SANTHOSH SALIMATH",
  "ANUSHKA SUTHAR",
  "CHHAVI HEMRAJ KALAL",
  "N DHANVIKA SHREE SHREEB N",
  "P JENNIFER",
  "K MAHASWIN",
  "MOHAMMED DANISH KHAN",
  "NALI DEVISH REDDY",
  "NESHIKA NAGARAJ GOSAVI",
  "PALAK SEERVI",
];
List<String> grade1 = [
  "AADYA ANGEL",
  "ADARSH SAHANI",
  "ATHIKA",
  "L N BHARAGAVAN RAMAN",
  "K DEVYANSHI",
  "DEVSHARAN REDDY EDDLA",
  "DRUVESHA",
  "M HAMSA",
];
List<String> grade2 = [
  "ALEX YADAV",
  "ANANYA RANI",
  "ANKUSH KUMAR",
  "ARUSH DAS",
  "BHUMIKA",
  "P S CHERISH",
  "DHEERAN ABHISHEK",
  "GAUTHAM RAO",

];
List<String> grade3 = [
  "ARADHAYA YADAV",
  "ABDUL REHMAN",
  "ABDUL AHAD",
  "DIKSHITA",
];
List<String> grade4 = [
  "K R ADVI",
  "AYUB ANSARI",
  "AYUSH",
  "D R BALASHIVARAMA",
  "K BHAGATH",
  "N DHANUSH",
  "B GAHAN",
];
List<String> grade5 = [
  "ABHI",
  "DIGVIJAY RAO",
  "KEERTHI",
  "K VINOD",
  "K L UDITH",
  "MOHAMMED UMAR KHAN",

];
List<String> grade6 = [
"L N BHAGAWAN",
"K DHAVAN",
"K BINDHU SRI",
"LAKSHITH RAM BHATI",
"MANIYA",
"PRIEOTOM BOSE",
];
List<String> grade7 = [
  "S AISHWARYA",
  "A AKSHA",
  "E YEKSHITHA REDDY",
  "R RAMYA",
  "UMA PRAJAPATH",
  "S VINAY",
  "ZOYA TANISHA",
];
List<String> grade8State = [
  "R MADHAN",
  "MOHAMMED AYAAN",

];
List<String> daycare = [
  'M HAVISHA REDDY'
];
List <String> grade7State=[
  "V S SUJAN"
];
Map<String, List<String>> classStudents = {
  "NURSERY": nursery,
  "LKG": lkg,
  "UKG": ukg,
  "GRADE-1": grade1,
  "GRADE-2": grade2,
  "GRADE-3": grade3,
  "GRADE-4": grade4,
  "GRADE-5": grade5,
  "GRADE-6": grade6,
  "GRADE-7": grade7,
  "DAY CARE": daycare,
  "GRADE 8 STATE SYLLABUS": grade8State,
  "GRADE 7 STATE SYLLABUS": grade7State,
};
List<String> staffNames = [
  "Monica Geller",
 " Chandler Bing",
  "Rachel Green",
  "Shlok Agnihotri",
  "Aastha",
  "Naira Goenka",
  "Anika",
  "Gauri Sharma"
];

List<String> feeTypes = [
  "SCHOOL FEE",
  "DEVELOPMENT FEE",
  "LAB FEE",
  "LIBRARY FEE",
];

List<String> year = [
  "2015-16",
  "2016-17",
  "2017-18",
  "2018-19",
  "2019-20",
  "2020-21",
  "2021-22",
  "2022-23",
  "2023-24",
  "2024-25",
  "2025-26",
];
Map<String, List<Map<String, dynamic>>> classStudentFees = {
  "NURSERY": [
    {"name": "S BHAVAGNA", "total": 3500, "paid": 2500, "concession": 500},
    {"name": "K Y HANVITH", "total": 3500, "paid": 2000, "concession": 300},
    {"name": "JUAN JOJI", "total": 3500, "paid": 3500, "concession": 0},
  ],
  "LKG": [
    {"name": "AAV GUPTA", "total": 4000, "paid": 3000, "concession": 200},
    {"name": "AARUSH KIRAN BELGAV", "total": 4000, "paid": 3500, "concession": 100},
    {"name": "ABHI SAHANI", "total": 4000, "paid": 4000, "concession": 0},
  ],
  "UKG": [
    {"name": "AKSHATHA SANTHOSH SALIMATH", "total": 4500, "paid": 4000, "concession": 200},
    {"name": "ANUSHKA SUTHAR", "total": 4500, "paid": 4500, "concession": 0},
    {"name": "CHHAVI HEMRAJ KALAL", "total": 4500, "paid": 3500, "concession": 500},
  ],
  "GRADE-1": [
    {"name": "AADYA ANGEL", "total": 5000, "paid": 4500, "concession": 200},
    {"name": "ADARSH SAHANI", "total": 5000, "paid": 4000, "concession": 500},
    {"name": "ATHIKA", "total": 5000, "paid": 5000, "concession": 0},
  ],
  "GRADE-2": [
    {"name": "ALEX YADAV", "total": 5500, "paid": 5000, "concession": 200},
    {"name": "ANANYA RANI", "total": 5500, "paid": 4500, "concession": 500},
    {"name": "ANKUSH KUMAR", "total": 5500, "paid": 5500, "concession": 0},
  ],
  "GRADE-3": [
    {"name": "ARADHAYA YADAV", "total": 6000, "paid": 5500, "concession": 200},
    {"name": "ABDUL REHMAN", "total": 6000, "paid": 5000, "concession": 500},
    {"name": "ABDUL AHAD", "total": 6000, "paid": 6000, "concession": 0},
  ],
  "GRADE-4": [
    {"name": "K R ADVI", "total": 6500, "paid": 6000, "concession": 300},
    {"name": "AYUB ANSARI", "total": 6500, "paid": 5000, "concession": 500},
    {"name": "AYUSH", "total": 6500, "paid": 6500, "concession": 0},
  ],
  "GRADE-5": [
    {"name": "ABHI", "total": 7000, "paid": 6500, "concession": 300},
    {"name": "DIGVIJAY RAO", "total": 7000, "paid": 7000, "concession": 0},
    {"name": "KEERTHI", "total": 7000, "paid": 6000, "concession": 500},
  ],
  "GRADE-6": [
    {"name": "L N BHAGAWAN", "total": 7500, "paid": 7000, "concession": 200},
    {"name": "K DHAVAN", "total": 7500, "paid": 7500, "concession": 0},
  ],
  "GRADE-7": [
    {"name": "S AISHWARYA", "total": 8000, "paid": 7000, "concession": 500},
    {"name": "A AKSHA", "total": 8000, "paid": 8000, "concession": 0},
  ],
  "DAY CARE": [
    {"name": "M HAVISHA REDDY", "total": 3000, "paid": 2500, "concession": 200},
  ],
  "GRADE 8 STATE SYLLABUS": [
    {"name": "R MADHAN", "total": 8500, "paid": 8000, "concession": 300},
  ],
  "GRADE 7 STATE SYLLABUS": [
    {"name": "V S SUJAN", "total": 8000, "paid": 7500, "concession": 200},
  ],
};
List<String> subjects = [
  "ENGLISH",
  "KANNADA",
  "HINDI",
  "MATHS",
  "EVS",
  "S.S",
  "SCIENCE",
  "COMPUTER",
  "G.K",
  "SENSORIAL",
  "ORAL",
  "LOGICAL REASON",
];
List<String> exams = [
"UNIT TEST-1",
"MIDTERM-1",
"UNIT-3",
"UNIT-4",
"FINAL EXAM",
];
List<String> month = [
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December",
];
List<String> teachers = [
  "Jerry",
  "Faneesha",
  "Marry",
  "April",
  "Manya",
  "June",
  "Jennifer",
  "Arya",
  "Seema",
  "Kavya",
  "Nevin",
  "Dileep",
];
