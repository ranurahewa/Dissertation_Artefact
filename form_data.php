<?php
require_once("db.php");

if(isset($_POST['sub_btn'])){
	
$service_type=mysqli_real_escape_string($connection,$_POST['service_type']);
$district=mysqli_real_escape_string($connection,$_POST['district']);
$ds_division=mysqli_real_escape_string($connection,$_POST['ds_division']);
$gn_number=mysqli_real_escape_string($connection,$_POST['gn_number']);
$referee_name=mysqli_real_escape_string($connection,$_POST['referee_name']);
$referee_phone=mysqli_real_escape_string($connection,$_POST['referee_phone']);
$family_name=mysqli_real_escape_string($connection,$_POST['family_name']);
$given_name=mysqli_real_escape_string($connection,$_POST['given_name']);
$surname=mysqli_real_escape_string($connection,$_POST['surname']);
$sex=mysqli_real_escape_string($connection,$_POST['sex']);
$civil_status=mysqli_real_escape_string($connection,$_POST['civil_status']);
$occupation=mysqli_real_escape_string($connection,$_POST['occupation']);
$photo_studio_ref=mysqli_real_escape_string($connection,$_POST['photo_studio_ref']);
$dob=mysqli_real_escape_string($connection,$_POST['dob']);
$birth_cert_no=mysqli_real_escape_string($connection,$_POST['birth_cert_no']);
$birth_division=mysqli_real_escape_string($connection,$_POST['birth_division']);
$birth_district=mysqli_real_escape_string($connection,$_POST['birth_district']);
$country_of_birth=mysqli_real_escape_string($connection,$_POST['country_of_birth']);
$city=mysqli_real_escape_string($connection,$_POST['city']);
$permanent_address=mysqli_real_escape_string($connection,$_POST['permanent_address']);
$permanent_city=mysqli_real_escape_string($connection,$_POST['permanent_city']);
$permanent_postal=mysqli_real_escape_string($connection,$_POST['permanent_postal']);
$postal_address=mysqli_real_escape_string($connection,$_POST['postal_address']);
$postal_city=mysqli_real_escape_string($connection,$_POST['postal_city']);
$postal_postal=mysqli_real_escape_string($connection,$_POST['postal_postal']);
$certificate_number=mysqli_real_escape_string($connection,$_POST['certificate_number']);
$certificate_issue_date=mysqli_real_escape_string($connection,$_POST['certificate_issue_date']);
$purpose=mysqli_real_escape_string($connection,$_POST['purpose']);
$lost_card_number=mysqli_real_escape_string($connection,$_POST['lost_card_number']);
$issue_date=mysqli_real_escape_string($connection,$_POST['issue_date']);
$police_report_details=mysqli_real_escape_string($connection,$_POST['police_report_details']);
$police_station=mysqli_real_escape_string($connection,$_POST['police_station']);
$police_report_date=mysqli_real_escape_string($connection,$_POST['police_report_date']);
$telephone=mysqli_real_escape_string($connection,$_POST['telephone']);
$mobile=mysqli_real_escape_string($connection,$_POST['mobile']);
$email=mysqli_real_escape_string($connection,$_POST['email']);


if(mysqli_query($connection,"INSERT INTO
applications (reg_id, service_type, district, ds_division, gn_number, referee_name, referee_phone, family_name, given_name, surname, sex, civil_status, occupation, photo_studio_ref, dob, birth_cert_no, place_of_birth, birth_division, birth_district, country_of_birth, city, certificate_no, permanent_address, permanent_city, permanent_postal, postal_address, postal_city, postal_postal, certificate_number, certificate_issue_date, purpose, lost_card_number, issue_date, police_report_details, police_station, police_report_date, telephone, mobile, email)
VALUES (NULL, '$service_type', '$district', '$ds_division', '$gn_number', '$referee_name', '$referee_phone', '$family_name', '$given_name', '$surname', '$sex', '$civil_status', '$occupation', '$photo_studio_ref', '$dob', '$birth_cert_no', '$place_of_birth', '$birth_division', '$birth_district', '$country_of_birth', '$city', '$certificate_no', '$permanent_address', '$permanent_city', '$permanent_postal', '$postal_address', '$postal_city', '$postal_postal', '$certificate_number', '$certificate_issue_date', '$purpose', '$lost_card_number', '$issue_date', '$police_report_details', '$police_station', '$police_report_date', '$telephone', '$mobile', '$email')")){
header("location:form.php?added_success");
}	
	
}
?>