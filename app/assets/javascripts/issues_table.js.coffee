jQuery ->
  $("#issues_table").dataTable
    "sDom": "<'row-fluid'<'span6'l><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>"
    sPaginationType: "bootstrap"
    # sPaginationType: "full_numbers"
    bJQueryUI: true
    # bProcessing: true
    # bServerSide: true
    # sAjaxSource: $('#issues').data('source')
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [0]}
    ]
    "iDisplayLength": 25,
    "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
  $("#issues_table").show()
  # $.extend( $.fn.dataTableExt.oStdClasses, {
  #   "sWrapper": "dataTables_wrapper form-inline"
  # });
