({
    init: function (cmp) {
        let rec = cmp.get("v.etatFile");
        if (rec == 2) {
          cmp.set("v.iconName", "utility:check");
          cmp.set("v.iconVariant", "success");
          cmp.set("v.disabled", true);
        } 
        else if (rec == 1) {
          cmp.set("v.iconName", "utility:warning");
          cmp.set("v.iconVariant", "warning");
          cmp.set("v.disabled", false);
        } 
        else {
          cmp.set("v.iconName", "utility:error");
          cmp.set("v.iconVariant", "error");
          cmp.set("v.disabled", false);
        }
      },
});