/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
const admin = require("firebase-admin");
admin.initializeApp();

const db = admin.firestore();

exports.sendReminderNotification = async (req, res) => {
  try {
    const snapshot = await db.collection('Users').where('reminder', '==', true).get();
    const tokens = [];
    
    snapshot.forEach(doc => {
      const data = doc.data();
      console.log('User:', data);
      if (data.fcmToken) {
        tokens.push(data.fcmToken);
      }
    });

    if (tokens.length > 0) {
      const message = {
        notification: {
          title: 'Reminder!',
          body: 'This is your reminder notification.',
        },
        tokens: tokens, 
      };

      const response = await admin.messaging().sendMulticast(message);
      console.log("Notifications sent successfully:", response);
    } else {
      console.log("No users with reminder flag found.");
    }
    res.status(200).send("Notifications sent successfully.");
  } catch (error) {
    console.error("Error sending notifications:", error);
    res.status(500).send("Error sending notifications.");
  }
};

