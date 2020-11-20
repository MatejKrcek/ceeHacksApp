import {
  EventContext,
} from "firebase-functions";
import { firestore } from "firebase-admin";
import { UserRecord } from "firebase-functions/lib/providers/auth";
import { CallableContext } from "firebase-functions/lib/providers/https";

export async function prepareProfile(user: UserRecord, cont: EventContext) {
  const { uid, email, displayName, photoURL } = user;
  await firestore()
    .collection("users")
    .doc(uid)
    .set({
      email: email,
      name: displayName || null,
      photo: photoURL || null,
      type: null
    });
}

export async function changeUserType(data: any, context: CallableContext ) {
  if (context.auth?.uid == null) {
    throw Error("missing uid");
  }
  await firestore().collection("user").doc(context.auth?.uid).update({
    type: data.type
  });
}