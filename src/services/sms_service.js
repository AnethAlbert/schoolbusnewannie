const axios = require("axios");

const content_type = "application/json";
const accepted = "application/json";
const token ="amF5Y29kZTpAQmFCYTYySmpKag==";
 

function _formatPhone(phone) {
  if (phone.charAt(0) == '0') {
    console.log(phone);
    return '255' + phone.substring(1);
  } else if (phone.charAt(0) == '+') {
    console.log(phone);
    return phone.substring(1);
  } else if (phone.charAt(0) == '2') {
    console.log(phone);
    return phone;
  } else {
    console.log(phone);
    return phone;
  }
}



  async function sendSms(receiverPhone, message) {
    await axios
    .post(
      "https://messaging-service.co.tz/api/sms/v1/text/single",
      {
        "from": "NEXTSMS", 
        "to": _formatPhone(receiverPhone), 
        "text": message, 
        "reference":"xaefcgt"
      },
      {
        headers: {
          "Content-Type": content_type,
          "Accept": accepted,
          Authorization: "Basic " + token,
        },
      }
    )
    .then(
      (res) => {
        console.log(res.status, res.statusText);
        console.log("NEXT SMS RESPONSE DATA:", res.data);
        console.log("NEXT SMS RESPONSE DATA STATUS:", res.data.messages[0].status);
      },
      (error) => {
        console.log("NEXT SMS ERROR: " + error);
      }
    );
  }


  module.exports = { sendSms }