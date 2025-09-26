global class CreateTaskEmail implements Messaging.InboundEmailHandler {
    
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email, Messaging.InboundEnvelope envelope) {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        String buffer;
        Lead insertLead;
        for(Messaging.InboundEmail.BinaryAttachment attach : email.binaryAttachments){
            if (attach.fileName == 'Lead.json'){
                
                buffer = attach.body.toString();
                insertLead = (Lead)JSON.deserialize(buffer, Lead.class);
                insertLead.company='Voluteers';
                insert insertLead;
            }
        }
         return result;
}
}