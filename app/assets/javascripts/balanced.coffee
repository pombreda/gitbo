jQuery ->
  marketplaceUri = "#{MARKETPLACE-URI}"
  $form = $("#bank-account-form")

  # collect the data from the form.
  bankAccountData =
    name: $form.find(".ba-name").val()
    account_number: $form.find(".ba-an").val()
    routing_number: $form.find(".ba-rn").val()
    type: $form.find("select").val()

  responseCallbackHandler = (response) ->
    switch response.status
      when 400
        
        # missing or invalid field - check response.error for details
        console.log response.error
      when 404
        
        # your marketplace URI is incorrect
        console.log response.error
      when 201
        
        # response.data.uri == URI of the bank account resource you
        # should store this bank account URI to later credit it
        console.log response.data
        $.post "your-marketplace.tld/bank_accounts", response.data