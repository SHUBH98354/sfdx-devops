@IsTest
public with sharing class HelloWorldTest {
    @TestSetup
    static void makeData(){
        System.debug('HI');
    }
    @isTest
    static void testSuccess(){
        Test.startTest();
            HelloWorld obj=new HelloWorld();
            System.assertEquals(obj.Hello(),'SUCCESS','Invalid Result');
        Test.stopTest();
    }
}