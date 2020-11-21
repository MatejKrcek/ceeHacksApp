import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

import * as users from "./user";
import * as doctor from "./doctor";
import * as doctorUser from './doctor-user';

/**
 * Generate profile of user
 */
export const userProfileGeneration = functions.auth
.user()
.onCreate(async (user, cont) => await users.prepareProfile(user, cont));

/**
 * Change typ of user
 */
export const userChangeType = functions.https.onCall(async (data, cont) => await users.changeUserType(data, cont));

/**
 * Verify doctor
 */
export const doctorVerify = functions.https.onCall(async (req, cont) => await doctor.verify(req, cont))

/**
 * Connected doctor with user
 */
export const doctorUserConnect = functions.https.onCall(async (req, cont) => await doctorUser.connect(req, cont));