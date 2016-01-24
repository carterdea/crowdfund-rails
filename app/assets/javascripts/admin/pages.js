$(function () {
  if ( $( "#editor" ).length ) {
    var editor = ace.edit("editor");
    editor.setTheme("ace/theme/monokai");
    var HTMLMode = ace.require("ace/mode/html").Mode;
    editor.session.setMode(new HTMLMode());
    
    // updates editor with existing code
    var original_textarea_value = $('#page_body').val();
    editor.setValue(original_textarea_value);
    
    editor.getSession().setUseWrapMode(true);
    editor.getSession().setUseSoftTabs(true);
    editor.getSession().setTabSize(2);
    editor.setShowPrintMargin(false);
    
    // updates textarea as editor is updated  
    editor.on("change", function() {
      var editor_value = editor.getValue();
      $('#page_body').val(editor_value);
    });
  }
});
