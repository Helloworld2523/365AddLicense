#คอนเน็ค เพื่อขอ user และ สิทธิในการจัดการข้อมูล 
# Get-Credential
# $M365credentials = Get-Credentail
# Connect-AzureAD -Credential $M365credentials
# Connect-MsolService -Credential $M365credentials
Connect-AzureAD 
Connect-MsolService
#อ่านข้อมูลจาก csv ในกรณีนี้จะให้ python ทำการ โหลดข้อมูลมาไว้ใน โฟลเดอร์ที่จัดเตรียมไว้ โดยการ อ่านข้อมูลมาจาก ฐานข้อมูลและสร้างเป็น csv
$Users = Import-Csv "C:\Users\Helloworld-PC\Desktop\365AddLicense\input.csv"
# Group ID ที่ผมทดสอบ คือ AutoImport24H
$GroupObjectID = "3b6156c5-6e2e-4b41-a253-2854e8e4e2f2"

Foreach($User in $Users){

    $UsersEmail = $User.email
    #ลบสิทธิที่มีอยู่ใน STANDARDWOFFPACK_FACULTY 
    Set-MsolUserLicense -UserPrincipalName  $UsersEmail -RemoveLicenses "ramkhamhaeng:STANDARDWOFFPACK_FACULTY"
    #Get ObjectID ออกมาจาก username ที่เป็น ชื่อ email
    $UserObjectID = (Get-AzureADUser -ObjectId $UsersEmail).objectid
    #ทำการ แอดเข้ากลุ่ม AutoImport24H
    Add-AzureADGroupMember -ObjectId $GroupObjectID -RefObjectId $UserObjectID

}

#Remove-AzureADGroupMember -ObjectId 3b6156c5-6e2e-4b41-a253-2854e8e4e2f2 -MemberId (Get-AzureADUser -ObjectId "myworld@ru.ac.th").ObjectID
#Set-MsolUserLicense -UserPrincipalName  myworld@ru.ac.th -RemoveLicenses "ramkhamhaeng:M365EDU_A3_FACULTY"
# Revoke-AzureADUserAllRefreshToken -ObjectId "3b6156c5-6e2e-4b41-a253-2854e8e4e2f2"