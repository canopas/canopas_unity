rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {


   match /paidLeaves/{document=**} {
     allow read, write : if request.auth != null;
   }

   function verifyFieldsForUpdateEmployee() {
       let required = ['name','email','uid'];
       let optional=  ['employee_id','role','designation','image_url','address','gender','date_of_birth','level','status','date_of_joining','phone'];
       let allAllowedFields = required.concat(optional);
   return request.resource.data.keys().hasAll(required) &&
      request.resource.data.keys().hasOnly(allAllowedFields)
      && !request.resource.data.diff(resource.data).affectedKeys().hasAny(['uid']);
   }



  function reviewFieldTypeForMember(docData){
    return    docData.uid is string &&
              docData.name is string &&
              docData.email is string &&
              (docData.employee_id is string ||!('employee_id' in docData.keys())) &&
              (docData.role is int || !('role' in docData.keys())) &&
              (docData.designation is string || !('designation' in docData.keys())) &&
              (docData.image_url is string || !('image_url' in docData.keys())) &&
              (docData.address is string || !('address' in docData.keys())) &&
              (docData.gender is int || !('gender' in docData.keys())) &&
              (docData.date_of_birth is int || !('date_of_birth' in docData.keys())) &&
              (docData.level is string || !('level' in docData.keys())) &&
              (docData.date_of_joining is int || !('date_of_joining' in docData.keys())) &&
              (docData.phone is int || !('phone' in docData.keys())) &&
              (docData.status is int || !('status' in docData.keys()));
  }


  function reviewFieldTypeForLeave(docData){
    return    docData.leave_id is string &&
              docData.uid is string &&
              docData.type is int &&
              docData.start_date is int &&
              docData.end_date is int &&
              docData.total is float &&
              docData.reason is string &&
              docData.status is int &&
              docData.applied_on is int &&
              docData.per_day_duration is list &&
              (docData.response is string || !('response' in docData.keys()));
}

  function reviewFieldTypeForSpace(docData){
    return    docData.name is string &&
              docData.created_at is int &&
              docData.owner_ids is list &&
              docData.paid_time_off is int &&
              (docData.id is string || !('id' in docData.keys())) &&
              (docData.domain is string || !('response' in docData.keys()))&&
              (docData.logo is string || !('logo' in docData.keys()));
  }

  function   requiredFieldsForCreateEmployee(){
    return request.resource.data.keys().hasAll(['uid','name','email']);
  }

  function requiredFieldsForCreateLeave(){
    return request.resource.data.keys().hasAll(['uid','leave_id','type','start_date','end_date','total','reason','status','applied_on','per_day_duration'])
  }

  function onlyChangesFields(fields) {
    return request.resource.data.diff(resource.data).affectedKeys().hasOnly(fields);
  }

  function onlyCreatesFields(fields) {
    return request.resource.data.keys().hasAll(fields);
  }

  function authenticated(){
    return request.auth != null ;
  }

  function isOwner(){
    return  authenticated()  && request.auth.uid in resource.data.owner_ids;
  }

  function isOwnerOfSpace(spaceID){
       let ownerIds= get(/databases/$(database)/documents/spaces/$(spaceID)).data.owner_ids;
    return authenticated() && request.auth.uid in ownerIds;
  }

  function isMember(workspaceId) {
    return authenticated() && exists(/databases/$(database)/documents/spaces/$(workspaceId)/members/$(request.auth.uid));
  }

  function hasRoleOfAdmin(workspaceId){
    return authenticated() && get(/databases/$(database)/documents/spaces/$(workspaceId)/members/$(request.auth.uid)).data.role == 1;
  }

  function hasRoleOfHR(workspaceId){
    return authenticated() && get(/databases/$(database)/documents/spaces/$(workspaceId)/members/$(request.auth.uid)).data.role == 2;
  }

  function isUser(){
    return authenticated() && request.auth.uid == resource.data.uid;
  }

  function hasOwnDoc(memberId){
    return authenticated() && request.auth.uid == memberId;
  }




  match /spaces/{spaceId} {
     allow read:   if isOwner() || isMember(spaceId);
     allow create: if  authenticated()  && onlyCreatesFields(['name','created_at','paid_time_off','owner_ids']) && reviewFieldTypeForSpace(request.resource.data);
     allow update: if  isOwner() && onlyChangesFields(['name','domain','logo','paid_time_off','id']) && reviewFieldTypeForSpace(request.resource.data) ;
      allow delete: if  isOwner();


   match /members/{memberId} {
      allow read:   if  isMember(spaceId);
      allow create: if  (hasRoleOfAdmin(spaceId)||hasRoleOfHR(spaceId)||isOwnerOfSpace(spaceId))&& requiredFieldsForCreateEmployee() && reviewFieldTypeForMember(request.resource.data);  
      allow update: if  (hasRoleOfAdmin(spaceId)||hasRoleOfHR(spaceId)|| hasOwnDoc(memberId)) &&verifyFieldsForUpdateEmployee() && reviewFieldTypeForMember(request.resource.data);
      allow delete: if  hasRoleOfAdmin(spaceId) || hasRoleOfHR(spaceId);
   }


   match /leaves/{leaveId} {
      allow read:   if  isMember(spaceId);
      allow create: if  isUser() && requiredFieldsForCreateLeave() && reviewFieldTypeForLeave(request.resource.data);
      allow update: if  (hasRoleOfAdmin(spaceId)||hasRoleOfHR(spaceId)) && onlyChangesFields(['status','response']);
      allow delete: if  isUser() || hasRoleOfAdmin(spaceId) || hasRoleOfHR(spaceId);
   }
}



  match /accounts/{docId} {
      allow read:   if  authenticated();
      allow update: if  authenticated() && onlyChangesFields(["spaces"]);
      allow create: if  authenticated() && onlyCreatesFields(["email", "spaces","uid"]) ;
      allow delete: if  false;
  }
 }
}