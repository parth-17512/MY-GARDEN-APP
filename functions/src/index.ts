import * as functions from "firebase-functions/v2";
import * as admin from "firebase-admin";

admin.initializeApp();

export const addCreatedAtTimestamp = functions.firestore
  .onDocumentCreated("plants/{plantId}", async (event) => {
    const snapshot = event.data;
    if (!snapshot) return;
    const createdAt = admin.firestore.FieldValue.serverTimestamp();
    await snapshot.ref.update({createdAt});
  });
