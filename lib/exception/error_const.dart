//Exception thrown when trying to login with google account which doesn't exist in google
const String userAccountNotFoundError = 'error-user-account-not-found';

//All types of firebaseAuthentication exception
const String firesbaseAuthError = 'error-firestore-exception';

//Exception when user trying to signin with different google account which is not exist in firestore or not added by HR
const String userNotFoundError = 'error-user-not-found';

//Exception when trying to update user data in firestore account with different data type in model
const String userDataNotUpdateError = 'error-update-user-data';

//Exception can be thrown by firestore while fetch data from firestore
const String firestoreFetchDataError = 'error-get-data-from-firestore';

//Exception thrown by flutter exception And the exception which is not caught
const String undefinedError = 'error-Undefined';

//Exception When trying to signout from google is not succeed
const String signOutError = 'error-sign-out';

const String userAlreadyExists = 'error-user-exists';

//Format Exception Error
const String wrongNumInputError = "wrong-num-input";
