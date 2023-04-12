rules_version = '2';
service cloud.firestore {
match /databases/{database}/documents {

  match /users/{document=**} {
     allow read, write : if request.auth != null; 
  }
    
  match /leaves/{document=**} {
    allow read, write : if request.auth != null; 
  }
    
  match /paidLeaves/{document=**} {
    allow read, write : if request.auth != null; 
  }
      
  function verifyFieldsForUpdateEmployee() {
     let required = ['role','name','email','employee_id','designation'];
     let optional=  ['image_url','address','gender','date_of_birth','level','joined_at','phone'];
     let allAllowedFields = required.concat(optional);
  return request.resource.data.keys().hasAll(required) &&
     request.resource.data.keys().hasOnly(allAllowedFields) && 
     !request.resource.data.diff(resource.data).affectedKeys().hasAny(['uid']);
  }
  
     
    
  function reviewFieldTypeForMember(docData){
  return    docData.uid is string &&
            docData.name is string &&
            docData.email is string &&
            docData.get('role','')is int &&
            docData.get('employee_id','')is int &&
            docData.get('designation','')is int &&
            docData.get('image_url','')is string &&
            docData.get('address','') is string &&
            docData.get('gender', '')is int &&
            docData.get('date_of_birth','') is int &&
            docData.get('level','')is string &&
            docData.get('joined_at','') is int &&
            docData.get('phone','') is int &&
            docData.get('status','') is int
    }
    
  function reviewFieldTypeForLeave(docData){
  return    docData.leave_id is string && 
            docData.type is int &&
            docData.start_date is int &&
            docData.end_date is int &&
            docData.total is int &&
            docData.reason is string &&
            docData.status is int &&
            docData.applied_on is int &&
            docData.per_day_duration is list &&
            docData.get('response','') is string
  }
       
  function reviewFieldTypeForSpace(docData){
  return    docData.name is string &&
            docData.created_at is int &&
            docData.owner_ids is list &&
            docData.paid_time_off is int &&
            docData.get('id','')is string &&
            docData.get('domain','') is string &&
            docData.get('logo','') is string
  }
          
  function   requiredFieldsForCreateEmployee(){
    return request.resource.data.keys.hasAll(['uid','role','name','email','employee_id','designation']); 
  }
     
  function requiredFieldsForCreateLeave(){
    return request.resource.data.keys().hasAll(['leave_id','type','start_date','end_date','total','reason','status','applied_on','per_day_duration'])
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
    
  function isUser(memberId){
    return authenticated() && request.auth.uid == memberId;
  }
    
  function createMemberByAdmin(spaceId){
    return hasRoleOfAdmin(spaceId) && reviewFieldTypeForMember(request.resource.data) && requiredFieldsForCreateEmployee();
  }
    
  function createMemberByHR(spaceId){ 
    return hasRoleOfHR(spaceId) && reviewFieldTypeForMember(request.resource.data) && requiredFieldsForCreateEmployee();
  }
 
  function updateEmployeeByAdmin(spaceId){
    return hasRoleOfAdmin(spaceId)&& verifyFieldsForUpdateEmployee() && reviewFieldTypeForMember(request.resource.data);
  }
    
  function updateEmployeeByHR(spaceId){
    return hasRoleOfHR(spaceId)&& verifyFieldsForUpdateEmployee() && reviewFieldTypeForMember(request.resource.data);
  }
     
  function updateEmployeeByUser(memberId){
    return isUser(memberId) && verifyFieldsForUpdateEmployee() && reviewFieldTypeForMember(request.resource.data);
  }
     
  function createLeaveByMember(memberId){
    return isUser(memberId) && requiredFieldsForCreateLeave() && reviewFieldTypeForLeave(request.resource.data);
  }
     
  function updateLeaveByAdmin(spaceId){
    return hasRoleOfAdmin(spaceId) && onlyChangesFields(['status','response']);
  }
   
  function updateLeaveByHR(spaceId){
    return hasRoleOfHR(spaceId) && onlyChangesFields(['status','response']);
  }
    
  
       

    
 match /spaces/{spaceId} {
        allow read:   if isOwner() || isMember(spaceId);
        allow create: if  authenticated()  && onlyCreatesFields(['name','created_at','paid_time_off','owner_ids']) && reviewFieldTypeForSpace(request.resource.data);
        allow update: if  isOwner() && onlyChangesFields(['name','domain','logo','paid_time_off','id']) && reviewFieldTypeForSpace(request.resource.data) ; 
        allow delete: if  isOwner();
      
        
  match /members/{memberId} {
         allow read:   if  isMember(spaceId);
         allow create: if  createMemberByAdmin(spaceId)||createMemberByHR(spaceId)||isOwnerOfSpace(spaceId);
         allow update: if  updateEmployeeByAdmin(spaceId) || updateEmployeeByHR(spaceId)|| updateEmployeeByUser(memberId);
         allow delete: if  hasRoleOfAdmin(spaceId) || hasRoleOfHR(spaceId);
         
         
   match /leaves/{leaveId} {
           allow read:   if  isMember(spaceId);
           allow create: if  createLeaveByMember(memberId);
           allow update: if  updateLeaveByAdmin(spaceId) || updateLeaveByHR(spaceId);
           allow delete: if  isUser(memberId) || hasRoleOfAdmin(spaceId) || hasRoleOfHR(spaceId);
            }
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