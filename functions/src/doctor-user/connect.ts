import { firestore } from "firebase-admin";
import { CallableContext } from "firebase-functions/lib/providers/https";

export async function connect(body: any, res: CallableContext ) {
  const uidDoctor = body['uidDoctor'];
  const uidPacient = body['uidPacient'];
  if (uidPacient == null || uidDoctor == null){
    throw Error("some uid is missing");
  }
  await firestore().collection('users').doc(uidDoctor).collection('pacients').doc(uidPacient).set({connected: true,});
  await firestore().collection('users').doc(uidPacient).collection('doctors').doc(uidDoctor).set({connected: true,});
  return "connected";
}