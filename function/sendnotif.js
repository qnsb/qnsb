var admin = require("firebase-admin");

var serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount)
});

// This registration token comes from the client FCM SDKs.
var registrationToken = 'eXOaymyGSjul9fNLUB9ulI:APA91bEo56AeM_yc7Nfr-nsChKMw8ouInVeZ61vlyvBFfJ8ueV0hUeQp0wLbUTjSZNvoGJZQH8IcOoXPLl-0DhrgyI_OSQmNJbY_SUx7j1dMAbJH0L9jNR5HGDWt2iRvtGmrqN7kw3-5';

var message = {
  notification: {
    title: '850',
    body: '2:45'
  },
  // token: registrationToken
};

// Send a message to the device corresponding to the provided
// registration token.
admin.messaging().sendToTopic('Staff',message)
  .then((response) => {
    // Response is a message ID string.
    console.log('Successfully sent message:', response);
  })
  .catch((error) => {
    console.log('Error sending message:', error);
  });