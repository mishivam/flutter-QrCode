const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

var msgData;

exports.offerTrigger = functions.firestore.collection(
    'qrCodes'
        .document(uid.emailId)
        .collection('HistorybyTime')).onCreate((snapshot, context) => {
            msgData = snapshot.data();
            const querySnapshot = await qrCode
                .document(uid.emailId)
                .collection('HistorybyTime')
                .get();
            return admin.firestore.collection('users').document().get().then((snapshots) => {
                var tokens = [];
                if (snapshots.empty) {
                    console.log('no devices !!')
                } else {
                    for (var token of snapshots.docs) {
                        tokens.push(token.data().userToken);
                    }
                    var payload = {
                        "notification": {
                            "title": "From" + msgData.Date,
                            "body": "offer" + msgData.Time,
                            "sound": "default"
                        },
                        "data": {
                            "sendername": msgData.Date,
                            "message": msgData.Time,
                        }

                    }

                    return admin.messaging().sendToDevice(tokens, payload).then((response) => {
                        console.log("pushed them all");
                    }).catch((err) => {
                        console.log(err);
                    })

                }
            })
        })
