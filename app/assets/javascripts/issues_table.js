

jQuery.extend( jQuery.fn.dataTableExt.oSort, {
    "num-html-pre": function ( a ) {
        var x = a.replace( /<.*?>/g, "" );
        if (x.indexOf("Post a bounty") != -1) {
          x = 0
        }
        else {
          x = x.replace("$", "");
        }
        return parseFloat( x );
    },
 
    "num-html-asc": function ( a, b ) {
        return ((a < b) ? -1 : ((a > b) ? 1 : 0));
    },
 
    "num-html-desc": function ( a, b ) {
        return ((a < b) ? 1 : ((a > b) ? -1 : 0));
    }
} );






// # jQuery ->
// #   $("#issues_table").dataTable
// #     aoColumns: [null, null, null, null, sType: "formatted-num"]
// #     "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
// #     sPaginationType: "bootstrap"
// #     # sPaginationType: "full_numbers"
// #     bJQueryUI: true
// #     # bProcessing: true
// #     # bServerSide: true
// #     # sAjaxSource: $('#issues').data('source')
// #     "aoColumnDefs": [
// #       { "bSortable": false, "aTargets": [0]}
// #     ]
// #     "iDisplayLength": 25,
// #     "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
// #   $("#issues_table").show()
// #   # $.extend( $.fn.dataTableExt.oStdClasses, {
// #   #   "sWrapper": "dataTables_wrapper form-inline"
// #   # });


jQuery(function() {
  $("#issues_table").dataTable({
    "aoColumns": [
      null, null, null, null, {
        "sType": "num-html"
      }, null
    ],
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",
    sPaginationType: "bootstrap",
    bJQueryUI: true,
    "aoColumnDefs": [
      {
        "bSortable": false,
        "aTargets": [0]
      }
    ],
    "iDisplayLength": 25,
    "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
  });
  return $("#issues_table").show();
});
