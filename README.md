# Installation Steps

These installation steps are for all versions of .net

1. Add provided “paytm.dll” as a “Reference” in your project.
2. Import namespace “paytm” in your project/solution with statement “using paytm”.
3. The Generate CheckSum and Verify CheckSum methods are given below. Their respective usage is given in the next few points.
```sh
string return method CheckSum.generateCheckSum(String merchantKey, Dictionary<String, String> parameters)
Boolean return method CheckSum.verifyCheckSum(String merchantKey, Dictionary<String, String> parameters, String checkSum)
```
4. For Generating CheckSum, use the following code snippet. **Note:** Replace all the values with the respective values provided by Paytm at the time of registration.
```sh
String merchantKey = “merchantKey value” ;
Dictionary<string, string> parameters = new Dictionary<string, string>();
parameters.Add("MID", "mid value");
parameters.Add("CHANNEL_ID", "channel id value");
parameters.Add("INDUSTRY_TYPE_ID","industry value");
parameters.Add("WEBSITE", "website value");
parameters.Add("EMAIL", "email value");
parameters.Add("MOBILE_NO", "mobile value");
parameters.Add("CUST_ID", "cust id");
parameters.Add("ORDER_ID", "order id");
parameters.Add("TXN_AMOUNT","amount");
parameters.Add("CALLBACK_URL","url"); //This parameter is not mandatory. Use this to pass the callback url dynamically.

string checksum = CheckSum.generateCheckSum(merchantKey, parameters);
```
5. Define the Staging server Url here. Replace this with the Production server Url once you move to the production setup.
```sh
string paytmURL = "https://pguat.paytm.com/oltp-web/processTransaction?orderid=" + orderid;
```
6. Use the following code snippet to make a form post. This will redirect the request to PG.
```sh
string outputHTML = "<html>";
outputHTML += "<head>";
outputHTML += "<title>Merchant Check Out Page</title>";
outputHTML += "</head>";
outputHTML += "<body>";
outputHTML += "<center><h1>Please do not refresh this page...</h1></center>";
outputHTML += "<form method='post' action='" + paytmURL + "' name='f1'>";
outputHTML += "<table border='1'>";
outputHTML += "<tbody>";
foreach (string key in parameters.Keys)
{
    outputHTML += "<input type='hidden' name='" + key + "' value='" + parameters[key] + "'>";
}
outputHTML += "<input type='hidden' name='CHECKSUMHASH' value='" + checksum + "'>";
outputHTML += "</tbody>";
outputHTML += "</table>";
outputHTML += "<script type='text/javascript'>";
outputHTML += "document.f1.submit();";
outputHTML += "</script>";
outputHTML += "</form>";
outputHTML += "</body>";
outputHTML += "</html>";
Response.Write(outputHTML);
```
7. Use the following code snippet to Get the response and verify the checksumhash. 
```sh
String merchantKey = “merchantKey value” ; // Replace the with the Merchant Key provided by Paytm at the time of registration.
Boolean success = CheckSum.verifyCheckSum(merchantKey, parameters, checkSum);
Dictionary<string, string> parameters = new Dictionary<string, string>();
string paytmChecksum = "";
foreach (string key in Request.Form.Keys)
{
    parameters.Add(key.Trim(), Request.Form[key].Trim());
}

if (parameters.ContainsKey("CHECKSUMHASH"))
{
    paytmChecksum = parameters["CHECKSUMHASH"];
    parameters.Remove("CHECKSUMHASH");
}

if (CheckSum.verifyCheckSum(merchantKey, parameters, paytmChecksum))
{
    Response.Write("Checksum Matched");
}
else
{
    Response.Write("Checksum MisMatch");
}
```
