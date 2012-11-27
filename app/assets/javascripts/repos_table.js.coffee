jQuery ->
  $("#repos_table").dataTable
    sPaginationType: "full_numbers"
    bJQueryUI: true
    # bProcessing: true
    # bServerSide: true
    # sAjaxSource: $('#issues').data('source')
    "aoColumnDefs": [
      { "bSortable": false, "aTargets": [ 0 ] }
    ]
    "iDisplayLength": 10,
    "aLengthMenu": [[10, 25, 50, 100, -1], [10, 25, 50, 100, "All"]]
  $("#repos_table").show()