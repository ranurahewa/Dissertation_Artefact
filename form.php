<?php 
require_once("db.php");
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Identity Card Application</title>
    <style>
      /* Reset default browser styles */
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }

      /* Apply some basic styling to the body */
      body {
        font-family: Arial, sans-serif;
        background-color: #f5f5f5;
        margin: 0;
        padding: 0;
      }

      /* Style the container */
      .container {
        max-width: 600px;
        margin: 0 auto;
        padding: 20px;
        background-color: #fff;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        overflow-y: auto; /* Enable vertical scrolling if needed */
        height: 100vh; /* Set maximum height to 100% of viewport height */
      }

      /* Style the caption */
      .caption {
        font-size: 24px;
        margin-bottom: 20px;
        text-align: center;
        color: #007bff;
      }

      /* Style form labels */
      label {
        display: block;
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
      }

      /* Style text inputs and selects */
      input[type='text'],
      input[type='tel'],
      input[type='date'],
      input[type='email'],
      select {
        width: 100%;
        padding: 12px;
        margin-bottom: 15px;
        border: 1px solid #ccc;
        border-radius: 3px;
        font-size: 16px;
        transition: border-color 0.3s;
      }

      /* Style inputs on focus */
      input[type='text']:focus,
      input[type='tel']:focus,
      input[type='date']:focus,
      input[type='email']:focus,
      select:focus {
        border-color: #007bff;
      }

      /* Style submit button */
      input[type='submit'] {
        background-color: #007bff;
        color: #fff;
        padding: 12px 20px;
        border: none;
        border-radius: 3px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
      }

      /* Style submit button on hover */
      input[type='submit']:hover {
        background-color: #0056b3;
      }

      /* Style links */
      a {
        color: #007bff;
        text-decoration: none;
        margin-bottom: 10px;
        display: block;
        text-align: right;
        font-size: 14px;
      }

      /* Add some spacing to fieldsets */
      fieldset {
        margin-bottom: 20px;
        border: 1px solid #ccc;
        padding: 15px;
        border-radius: 5px;
      }

      /* Apply special styles to the read-only input */
      input[readonly] {
        background-color: #f5f5f5;
        cursor: not-allowed;
      }

      /* Style the legend of fieldsets */
      legend {
        font-weight: bold;
        font-size: 18px;
        color: #007bff;
      }

      /* Add spacing between form sections */
      hr {
        border: none;
        border-top: 1px solid #ccc;
        margin: 20px 0;
      }
    </style>
  </head>
  <body>		

      <form action="form_data.php" method="post" style="width: 40%; margin: 20px auto;">
		  
	    <h2 style="text-transform: uppercase; text-align: center; color: blue; margin-bottom: 20px;">Identity Card Application</h2>
		  
		  <?php if(isset($_GET['added_success'])){ ?><div style="padding: 10px; background-color: green; color: white; text-align: center; margin-bottom: 10px;">Record added success!</div><?php } ?>
		  
        <!-- Service Type -->
        <label for="service-type">Service Type:</label>
        <select name="service_type" required="required" id="service_type">
			<option value="" hidden="yes">Select</option>
          <option value="normal">Normal</option>
          <option value="one-day">One Day</option>
        </select>

        <!-- District -->
        <label for="district">District:</label>
        <select name="district" required="required" id="district" style="text-transform: capitalize;">
			<option value="" hidden="yes">Select</option>
			<?php 
			$d_qury=mysqli_query($connection,"SELECT * FROM distric ORDER BY d_text ASC");
			while($d_resalt=mysqli_fetch_assoc($d_qury)){
			?>
			<option value="<?php echo $d_resalt['d_id']; ?>"><?php echo $d_resalt['d_text']; ?></option>
			<?php } ?>
        </select>

        <!-- DS Division -->
        <label for="ds_division">D.S. Division:</label>
        <select id="ds_division" name="ds_division">
			<option value="" hidden="yes">Select</option>
          <option value="colombo-west">Colombo West</option>
          <option value="colombo-east">Colombo East</option>
          <option value="kandy-central">Kandy Central</option>
          <option value="kandy-north">Kandy North</option>
          <option value="galle-city">Galle City</option>
        </select>

        <!-- GN Number and Division -->
        <label for="gn_number">G.N. Number and Division:</label>
        <select id="gn_number" name="gn_number">
          <option value="gn001">GN 001 - Division 1</option>
          <option value="gn002">GN 002 - Division 2</option>
          <option value="gn003">GN 003 - Division 3</option>
          <option value="gn004">GN 004 - Division 4</option>
          <option value="gn005">GN 005 - Division 5</option>
        </select>

        <!-- Grama Niladari/Referee Name -->
        <label for="referee_name">Grama Niladari/Referee Name:</label>
        <input type="text" id="referee_name" name="referee_name" />

        <!-- Grama Niladari/Referee Telephone No -->
        <label for="referee-phone">Grama Niladari/Referee Telephone No:</label>
        <input type="tel" id="referee-phone" name="referee-phone" />

        <!-- Family Name, Name, Surname -->
        <label for="family-name">Family Name:</label>
        <input type="text" id="family-name" name="family-name" />
        <label for="given-name">Name:</label>
        <input type="text" id="given-name" name="given-name" />
        <label for="surname">Surname:</label>
        <input type="text" id="surname" name="surname" />

        <!-- Sex -->
        <label for="sex">Sex:</label>
        <select id="sex" name="sex">
          <option value="male">Male</option>
          <option value="female">Female</option>
          <option value="other">Other</option>
        </select>

        <!-- Civil Status -->
        <label for="civil-status">Civil Status:</label>
        <select id="civil-status" name="civil-status">
          <option value="single">Single</option>
          <option value="married">Married</option>
          <option value="divorced">Divorced</option>
          <option value="widowed">Widowed</option>
        </select>

        <!-- Profession/Occupation/Designation -->
        <label for="occupation">Profession/Occupation/Designation:</label>
        <input type="text" id="occupation" name="occupation" />

        <!-- Photo Studio Reference No -->
        <label for="photo-studio-ref">Photo Studio Reference No:</label>
        <input type="text" id="photo-studio-ref" name="photo-studio-ref" />

        <!-- Date of Birth -->
        <label for="dob">Date of Birth:</label>
        <input type="date" id="dob" name="dob" />

        <!-- Birth Certificate No -->
        <label for="birth-cert-no">Birth Certificate No:</label>
        <input type="text" id="birth-cert-no" name="birth-cert-no" />

        <!-- Place of Birth -->
        <label for="place-of-birth">Place of Birth:</label>
        <input type="text" id="place-of-birth" name="place-of-birth" />

        <!-- Division -->
        <label for="birth-division">Division:</label>
        <select id="birth-division" name="birth-division">
          <option value="division1">Division 1</option>
          <option value="division2">Division 2</option>
          <option value="division3">Division 3</option>
          <option value="division4">Division 4</option>
          <option value="division5">Division 5</option>
        </select>

        <!-- District -->
        <label for="birth-district">District:</label>
        <select id="birth-district" name="birth-district">
          <option value="colombo">Colombo</option>
          <option value="kandy">Kandy</option>
          <option value="galle">Galle</option>
          <option value="matara">Matara</option>
          <option value="kurunegala">Kurunegala</option>
        </select>

        <!-- If born outside of Sri Lanka -->
        <fieldset>
          <legend>If born outside of Sri Lanka</legend>
          <!-- Country of Birth -->
          <label for="country-of-birth">Country of Birth:</label>
          <select id="country-of-birth" name="country-of-birth">
            <option value="sri-lanka">Sri Lanka</option>
            <option value="india">India</option>
            <option value="usa">USA</option>
            <option value="canada">Canada</option>
            <option value="uk">UK</option>
          </select>

          <!-- City -->
          <label for="city">City:</label>
          <input type="text" id="city" name="city" />

          <!-- Certificate No -->
          <label for="certificate-no">Certificate No:</label>
          <input type="text" id="certificate-no" name="certificate-no" />
        </fieldset>

        <!-- Permanent Address -->
        <fieldset>
          <legend>Permanent Address</legend>
          <!-- Road/Street/Lane/Place/Garden -->
          <label for="permanent-address">Road/Street/Lane/Place/Garden:</label>
          <input type="text" id="permanent-address" name="permanent-address" />

          <!-- Village/City -->
          <label for="permanent-city">Village/City:</label>
          <input type="text" id="permanent-city" name="permanent-city" />

          <!-- Postal Code -->
          <label for="permanent-postal">Postal Code:</label>
          <input type="text" id="permanent-postal" name="permanent-postal" />
        </fieldset>

        <!-- Postal Address -->
        <fieldset>
          <legend>Postal Address</legend>
          <!-- Road/Street/Lane/Place/Garden -->
          <label for="postal-address">Road/Street/Lane/Place/Garden:</label>
          <input type="text" id="postal-address" name="postal-address" />

          <!-- Village/City -->
          <label for="postal-city">Village/City:</label>
          <input type="text" id="postal-city" name="postal-city" />

          <!-- Postal Code -->
          <label for="postal-postal">Postal Code:</label>
          <input type="text" id="postal-postal" name="postal-postal" />
        </fieldset>

        <!-- Details of Citizenship Certificate/Dual Citizenship Certificate -->
        <fieldset>
          <legend>
            Details of Citizenship Certificate/Dual Citizenship Certificate
          </legend>
          <!-- Certificate Number -->
          <label for="certificate-number">Certificate Number:</label>
          <input
            type="text"
            id="certificate-number"
            name="certificate-number"
          />

          <!-- Date of issue of Certificate -->
          <label for="certificate-issue-date"
            >Date of issue of Certificate:</label
          >
          <input
            type="date"
            id="certificate-issue-date"
            name="certificate-issue-date"
          />
        </fieldset>

        <!-- Purpose of Application -->
        <label for="purpose">Purpose of application:</label>
        <select id="purpose" name="purpose">
          <option value="lost">If the Identity Card is lost</option>
          <option value="changes">To make changes to the Identity Card</option>
          <option value="renew">To renew the period of validity</option>
          <option value="damaged">
            If the Identity card is damaged/defaced/illegible
          </option>
        </select>

        <!-- Lost or last obtained Identity Card Number -->
        <label for="lost-card-number"
          >Lost or last obtained Identity Card Number:</label
        >
        <input type="text" id="lost-card-number" name="lost-card-number" />

        <!-- Date of the issue of the Identity Card -->
        <label for="issue-date">Date of the issue of the Identity Card:</label>
        <input type="date" id="issue-date" name="issue-date" />

        <!-- Details of the police report or other document pertaining to the lost Identity Card -->
        <label for="police-report-details"
          >Details of the police report or other document pertaining to the lost
          Identity Card:</label
        >
        <input
          type="text"
          id="police-report-details"
          name="police-report-details"
        />

        <!-- Name of the Police Station -->
        <label for="police-station">Name of the Police Station:</label>
        <select id="police-station" name="police-station">
          <option value="police-station-1">Police Station 1</option>
          <option value="police-station-2">Police Station 2</option>
          <option value="police-station-3">Police Station 3</option>
          <option value="police-station-4">Police Station 4</option>
          <option value="police-station-5">Police Station 5</option>
        </select>

        <!-- Date of the issue of the Police report -->
        <label for="police-report-date"
          >Date of the issue of the Police report:</label
        >
        <input type="date" id="police-report-date" name="police-report-date" />

        <!-- Telephone Numbers -->
        <label for="telephone">Telephone No:</label>
        <input type="tel" id="telephone" name="telephone" />
        <label for="mobile">Mobile:</label>
        <input type="tel" id="mobile" name="mobile" />

        <!-- Email -->
        <label for="email">E-mail:</label>
        <input type="email" id="email" name="email" />

        <!-- Application Date (display only) -->
        <label for="application-date">Application Date:</label>
		  <input type="date" readonly="readonly" value="<?php echo date("Y-m-d"); ?>">
        <!-- Link to Upload Document (no need to work) -->
        <a href="#" id="upload-link">Link to Upload Document</a>

        <!-- Link to Payment (If one-day service) -->
        <a href="#" id="payment-link">Link to Payment (If one-day service)</a>

        <!-- Submit Button -->
        <input type="submit" value="Submit" name="sub_btn" />
      </form>

</body>
</html>
<?php mysqli_close($connection); ?>