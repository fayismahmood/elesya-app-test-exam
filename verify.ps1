$headers = @{ "Content-Type" = "application/json" }

Write-Host "Creating Normal Exam..."
$body1 = @{
    type = "normal"
    subject = "Mathematics"
    maxScore = 100
    scoreDistributions = @(
        @{ section_name = "Section A"; allocated_score = 40 },
        @{ section_name = "Section B"; allocated_score = 60 }
    )
    scoreMappings = @(
        @{ min_score = 0; max_score = 39; status = "Fail" },
        @{ min_score = 40; max_score = 100; status = "Pass" }
    )
} | ConvertTo-Json -Depth 3
Invoke-RestMethod -Uri "http://localhost:3000/exams" -Method Post -Headers $headers -Body $body1
Write-Host "`n"

Write-Host "Creating Continuous Exam..."
$body2 = @{
    type = "continuous"
    subject = "Science"
    maxScore = 50
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/exams" -Method Post -Headers $headers -Body $body2
Write-Host "`n"

Write-Host "Getting All Exams..."
Invoke-RestMethod -Uri "http://localhost:3000/exams" -Method Get
Write-Host "`n"

Write-Host "Creating Result..."
$body3 = @{
    examId = 1
    studentId = "STD001"
    obtainedScore = 85
    metadata = @{ section_a = 35; section_b = 50 }
} | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:3000/results" -Method Post -Headers $headers -Body $body3
Write-Host "`n"

Write-Host "Getting All Results..."
Invoke-RestMethod -Uri "http://localhost:3000/results" -Method Get
Write-Host "`n"
