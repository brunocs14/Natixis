@isTest
public with sharing class RelatedRecordsTableControllerTest {
    @TestSetup
    static void createTestData() {
        Object_A__c objA = new Object_A__c();
        objA.Name = 'Item 1';
        insert objA;
        
        Object_A__c objA2 = new Object_A__c();
        objA2.Name = 'Item 2';
        insert objA2;
        
        Object_B__c objB = new Object_B__c();
        objB.Name = 'Item B-1';
        objB.Object_A__c = objA.Id;
        insert objB;
        
        Object_B__c objB2 = new Object_B__c();
        objB2.Name = 'Item B-1';
        objB2.Object_A__c = objA.Id;
        insert objB2;
        
        List<Object_C__c> objCList = new List<Object_C__c>();
        
        Object_C__c objC = new Object_C__c();
        objC.Name = 'Item c-1';
        objC.Object_B__c = objB.Id;
        objCList.add(objC);
        
        Object_C__c objC2 = new Object_C__c();
        objC2.Name = 'Item c-2';
        objC2.Object_B__c = objB.Id;
        objCList.add(objC2);
        
        Object_C__c objC3 = new Object_C__c();
        objC3.Name = 'Item c-3';
        objC3.Object_B__c = objB.Id;
        objCList.add(objC3);
        
        insert objCList;
        
    }
    
    static testMethod void validateGetRecords() {
        Object_A__c itemA = [SELECT Id FROM Object_A__c LIMIT 1];
        
        List<RelatedRecordsTableController.recordSummary> resultList = new List<RelatedRecordsTableController.recordSummary>();
        
        Test.startTest();
        resultList = RelatedRecordsTableController.getRecordList(itemA.Id);        
        Test.stopTest();
        
        System.assertEquals(false, resultList.isEmpty(), 'A lista está vazia');
    }    
}