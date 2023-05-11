rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {

    function verifyFieldsForUpdateEmployee() {
         let required = ['name','email','uid','role','date_of_joining'];
         let optional=  ['employee_id','designation','image_url','address','gender','date_of_birth','level','status','phone'];
         let allAllowedFields = required.concat(optional);
      return request.resource.data.keys().hasAll(required) &&
             request.resource.data.keys().hasOnly(allAllowedFields) && 
             !request.resource.data.diff(resource.data).affectedKeys().hasAny(['uid']);
    }



    function reviewFieldTypeForMember(docData){
        return    docData.uid is string &&
                  docData.name is string &&
                  docData.email is string &&
                  docData.role is int &&
                  docData.date_of_joining is int &&
                 (docData.employee_id is string ||!('employee_id' in docData.keys())) &&
                 (docData.designation is string || !('designation' in docData.keys())) &&
                 (docData.image_url is string || !('image_url' in docData.keys())) &&
                 (docData.address is string || !('address' in docData.keys())) &&
                 (docData.gender is int || !('gender' in docData.keys())) &&
                 (docData.date_of_birth is int || !('date_of_birth' in docData.keys())) &&
                 (docData.level is string || !('level' in docData.keys())) &&
                 (docData.phone is string || !('phone' in docData.keys())) &&
                 (docData.status is int || !('status' in docData.keys()));
    }


    function reviewFieldTypeForLeave(docData){
        return   docData.leave_id is string &&
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
                (docData.domain is string || !('domain' in docData.keys()))&&
                (docData.logo is string || !('logo' in docData.keys()));
    }

     function reviewFieldTypeForInvitation(docData){
        return    docData.id is string &&
                  docData.space_id is string &&
                  docData.sender_id is string &&
                  docData.receiver_email is string

    }

    function reviewFieldTypeForAccount(docData){
       return    docData.uid is string &&
                 docData.email is string &&
                (docData.name is string || !('name' in docData.keys())) &&
                docData.spaces is list &&
                docData.spaces.size()==0;

    }


    function   requiredFieldsForCreateEmployee(){
      return request.resource.data.keys().hasAll(['uid','name','email','role', 'date_of_joining']);
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
       return authenticated() && request.auth.uid == request.resource.data.uid;
    }

     function hasOwnDoc(docID){
        return authenticated() && request.auth.uid == docID;
    }

    function updateAccountSpaces(){
        let spaceId= resource.data.spaces.removeAll(request.resource.data.spaces)[0];
      return authenticated() &&
               (hasRoleOfHR(spaceId)||hasRoleOfAdmin(spaceId)|| isOwnerOfSpace(spaceId))
    }










    match /spaces/{spaceId} {
      allow read:   if isOwner() || isMember(spaceId)||authenticated();
      allow create: if  authenticated()  && onlyCreatesFields(['name','created_at','paid_time_off','owner_ids']) && reviewFieldTypeForSpace(request.resource.data);
      allow update: if  isOwner() && onlyChangesFields(['name','domain','logo','paid_time_off','id']) && reviewFieldTypeForSpace(request.resource.data) ;
      allow delete: if  isOwner();


          match /members/{memberId} {
             allow read:   if  isMember(spaceId);
             allow create: if  (hasRoleOfAdmin(spaceId)||hasRoleOfHR(spaceId)||isUser()||isOwnerOfSpace(spaceId))&& requiredFieldsForCreateEmployee() && reviewFieldTypeForMember(request.resource.data);  
             allow update: if  (hasRoleOfAdmin(spaceId)||hasRoleOfHR(spaceId)|| hasOwnDoc(memberId)) &&verifyFieldsForUpdateEmployee() && reviewFieldTypeForMember(request.resource.data);
             allow delete: if  hasRoleOfAdmin(spaceId) || hasRoleOfHR(spaceId);
          } 

          match /leaves/{leaveId} {
             allow read:   if  isMember(spaceId);
             allow create: if  isUser() && requiredFieldsForCreateLeave() && reviewFieldTypeForLeave(request.resource.data);
             allow update: if  (hasRoleOfAdmin(spaceId)||hasRoleOfHR(spaceId))&& onlyChangesFields(['status','response']);
             allow delete: if  isUser() || hasRoleOfAdmin(spaceId) || hasRoleOfHR(spaceId);
          }
     }


     match /invitations/{docId} {
        allow list:   if  authenticated();
        allow update: if  false;
        allow create: if  (hasRoleOfAdmin(request.resource.data.space_id)||hasRoleOfHR(request.resource.data.space_id))&& reviewFieldTypeForInvitation(request.resource.data) && onlyCreatesFields(["receiver_email", "space_id","sender_id",'id']) ;
        allow delete: if  authenticated();
     }


     match /accounts/{docId} {
         allow get:   if   hasOwnDoc(docId);;
         allow update: if  (hasOwnDoc(docId)||updateAccountSpaces()) && onlyChangesFields(["spaces"]); 
         allow create: if  authenticated() && onlyCreatesFields(["email", "spaces","uid"])  && reviewFieldTypeForAccount(request.resource.data);
         allow delete: if  false;

        match /session/{docId} {
           allow read:   if  authenticated();
           allow update: if  authenticated() ; 
           allow create: if  authenticated()  ;
           allow delete: if  false;
        }
    }

}
}