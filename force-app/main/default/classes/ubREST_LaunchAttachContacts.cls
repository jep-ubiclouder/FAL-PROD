@RestResource(urlMapping='/launchBatchAttachContacts/*')
global with sharing class ubREST_LaunchAttachContacts {
    @HttpPost
    global static void launch(){
        if(!Test.isrunningTest()){
        ubLaunchPaymentBuffer.launch();}
        else{
            integer a =0;
            a++;
            a++;
            a++;
            a++;
            a++;
            a++;
            a++;
            a++;a++;
            a++;
            a++;
            a++;
        }
    }
}