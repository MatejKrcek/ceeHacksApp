import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

import * as users from "./user";

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