@IsTest(SeeAllData=true)
public with sharing class ubLaunchPaymentBuffer_Test {
    @isTest
    private static void  myTest(){
        test.startTest();
        ubLaunchPaymentBuffer.launch();
        test.stopTest();
    }
}