jQuery ->
  Stripe.setPublishableKey($('meta[name="stripe-key"]').attr('content'))
  subscription.setupForm()

subscription =
  setupForm: ->
    $('body').on 'submit', '.card-form', ->
      $('.card-form input[type=submit]').attr('disabled', true)
      if $('#card_number').length
        subscription.processCard()
        false
      else
        true
  
  processCard: ->
    card =
      number: $('#card_number').val()
      cvc: $('#card_code').val()
      expMonth: $('#card_month').val()
      expYear: $('#card_year').val()
    Stripe.createToken(card, subscription.handleStripeResponse)
  
  handleStripeResponse: (status, response) ->
    if status == 200
      $('#user_owned_company_attributes_subscription_attributes_stripe_card_token').val(response.id)
      $('.card-form')[0].submit()
    else
      alert = "<div class='alert alert-danger'>" + response.error.message + "</div>"
      $('#stripe_error').html(alert)
      $(".alert-danger").delay(3000).fadeOut()
      $('input[type=submit]').attr('disabled', false)