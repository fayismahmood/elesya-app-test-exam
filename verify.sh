#!/bin/bash

echo "Creating Normal Exam..."
curl -X POST http://localhost:3000/exams \
  -H "Content-Type: application/json" \
  -d '{
    "type": "normal",
    "subject": "Mathematics",
    "maxScore": 100,
    "scoreDistributions": [
      { "section_name": "Section A", "allocated_score": 40 },
      { "section_name": "Section B", "allocated_score": 60 }
    ],
    "scoreMappings": [
      { "min_score": 0, "max_score": 39, "status": "Fail" },
      { "min_score": 40, "max_score": 100, "status": "Pass" }
    ]
  }'
echo -e "\n"

echo "Creating Continuous Exam..."
curl -X POST http://localhost:3000/exams \
  -H "Content-Type: application/json" \
  -d '{
    "type": "continuous",
    "subject": "Science",
    "maxScore": 50
  }'
echo -e "\n"

echo "Getting All Exams..."
curl http://localhost:3000/exams
echo -e "\n"

echo "Creating Result..."
curl -X POST http://localhost:3000/results \
  -H "Content-Type: application/json" \
  -d '{
    "examId": 1,
    "studentId": "STD001",
    "obtainedScore": 85,
    "metadata": { "section_a": 35, "section_b": 50 }
  }'
echo -e "\n"

echo "Getting All Results..."
curl http://localhost:3000/results
echo -e "\n"
