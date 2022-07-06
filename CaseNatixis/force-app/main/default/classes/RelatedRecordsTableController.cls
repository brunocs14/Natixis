public with sharing class RelatedRecordsTableController {   
    @AuraEnabled(cacheable=true)
    public static List<recordSummary> getRecordList(Id recId) {
        System.debug('recordId==> ' + recId);
        List<recordSummary> returnList = new List<recordSummary>();
        
        List<Object_B__c> objBList =  [SELECT Id, Name, CreatedDate,
                                      (select Id, Name, CreatedDate from Cs__r) FROM Object_B__c WHERE Object_A__c =: recId];
        
        for (Object_B__c itemB : objBList) {                   
            recordSummary tt = new recordSummary(itemB.Id, itemB.Name, itemB.createdDate);
            if(!returnList.contains(tt)) returnList.add(tt);
            
            for (Object_C__c ctt : itemB.Cs__r) {
                recordSummary newCtt = new recordSummary(ctt.Id, ctt.Name, ctt.createdDate);
                if(!returnList.contains(newCtt)) returnList.add(newCtt);
            }
        }
       // System.debug('return list:  ');
       // System.debug(JSON.serialize(returnList));
        return returnList;
    }  
    
    public class recordSummary {
        @AuraEnabled public Id recordId {get; set;}
        @AuraEnabled public String recordName {get; set;}
        @AuraEnabled public Datetime createdDate {get; set;}
        
        public recordSummary(Id recordId, String accountName, Datetime createdDate){
            this.recordId = recordId;
            this.recordName = accountName;
            this.createdDate = createdDate;            
        }
    }
    
}