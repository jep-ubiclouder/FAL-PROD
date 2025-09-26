({
    doInit: function (cmp,ev, helper) {
        helper.init(cmp);
    },

    handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");

        var rec = cmp.get("v.docIds");
        // Get the document id
        uploadedFiles.forEach(file => rec.push(file.documentId));
        cmp.set("v.docIds", rec);
        $A.enqueueAction(rec);
    }
})