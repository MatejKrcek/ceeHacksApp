import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

import * as users from "./user";
import * as doctor from "./doctor";
import * as doctorUser from './doctor-user';
import * as drug from './drugs';

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
 
/**
 * Drug search
 */
export const drugSearch = functions.https.onCall(async (req, cont) => drug.search(req, cont));

/**
 * Set user token
 */
export const userNotificationToken = functions.https.onCall(async (data, cont) => users.setUserNotifToken(data, cont));
