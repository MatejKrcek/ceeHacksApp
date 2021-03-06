import {
  EventContext,
} from "firebase-functions";
import { firestore } from "firebase-admin";
import { UserRecord } from "firebase-functions/lib/providers/auth";
import { CallableContext } from "firebase-functions/lib/providers/https";

export async function prepareProfile(user: UserRecord, cont: EventContext) {
  const { uid } = user;
  await firestore()
    .collection("users")
    .doc(uid)
    .set({
      type: null,
    });
}

export async function changeUserType(data: any, context: CallableContext ) {
  const uid = context.auth?.uid;
  if (!uid) {
    throw Error("missing uid");
  } else {
    await firestore().collection("users").doc(uid).update({
      type: data.type,
    });
    return true;
  }
}

export async function setUserNotifToken(data: any, context: CallableContext) {
  const token = data['token'];
  const uid = context.auth?.uid;
  if (!uid) {
    throw Error("missing uid");
  } else {
    await firestore().collection("users").doc(uid).update({
      'token': token,
    })
  }
}