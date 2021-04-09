Connect-AzureAD 
Connect-MsolService
#อ่านข้อมูลจาก csv ในกรณีนี้จะให้ python ทำการ โหลดข้อมูลมาไว้ใน โฟลเดอร์ที่จัดเตรียมไว้ โดยการ อ่านข้อมูลมาจาก ฐานข้อมูลและสร้างเป็น csv
$Users = Import-Csv "C:\Users\Helloworld-PC\Desktop\365AddLicense\input.csv"
# Group ID ที่ผมทดสอบ คือ AutoImport24H
$GroupObjectID = "3b6156c5-6e2e-4b41-a253-2854e8e4e2f2"

Foreach($User in $Users){

    $UsersEmail = $User.email
    #Get ObjectID ออกมาจาก username ที่เป็น ชื่อ email
    $UserObjectID = (Get-AzureADUser -ObjectId $UsersEmail).objectid
    #ทำการให้ออก จากกลุ่ม AutoImport24H
    Remove-AzureADGroupMember -ObjectId $GroupObjectID -MemberId (Get-AzureADUser -ObjectId $UsersEmail).ObjectID

}
