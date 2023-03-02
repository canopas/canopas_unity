//All types of firebaseAuthentication exception
const String firesbaseAuthError = 'error-firestore-exception';

//Exception when user trying to signin with different google account which is not exist in firestore or not added by HR
const String userNotFoundError = 'error-user-not-found';

//Exception when trying to update user data in firestore account with different data type in model
const String userDataNotUpdateError = 'error-update-user-data';

//Exception can be thrown by firestore while fetch data from firestore
const String firestoreFetchDataError = 'error-get-data-from-firestore';

//Exception When trying to signout from google is not succeed
const String signOutError = 'error-sign-out';

const String userAlreadyExists = 'error-user-exists';

//Format Exception Error
const String wrongNumInputError = "wrong-num-input";

//Exception:when the all fields of user input are not completed
const String fillDetailsError = 'fill-all-details';

//Exception:When leave request for less than 1 hr
const String applyMinimumHalfDay = 'apply-minimum-half-day';

//Exception: When user selected wrong leave date like end leave date is before start leavedate
const String invalidLeaveDateError = 'invalid-leave_date_error';

const String somethingWentWrongError = 'something-went-wrong';
