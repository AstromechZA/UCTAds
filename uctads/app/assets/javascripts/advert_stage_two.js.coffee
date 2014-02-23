class @AdvertStageTwoBuilder

  @submit: ->
    fieldvals = {}
    $('.field-value-input').each (index, element) ->
      field = element.name
      value = element.value
      fieldvals[field] = value

    json = JSON.stringify(fieldvals)
    $('#advert_fieldvalues').val(json)

    frm = $('#form-wrapper').children('form')[0]
    frm.submit()

  @fillvalues: ->
    fieldvalsjson = $('#advert_fieldvalues').val()
    if fieldvalsjson != ''
      fieldvals = $.parseJSON(fieldvalsjson)
      for k,v of fieldvals
        name = '#field_' + k.replace(' ','__')
        $(name).val(v)

  @updatePriceField: ->
    $('#advert_price').prop('disabled', $('#advert_price_type').val() != 'Exact Price')
    $('#advert_price').val('')

$(document).ready ->
  moneyfield = $('input[data-role=money]')
  moneyfield.autoNumeric('init')

  moneyfield.keydown (event) ->
    if event.keyCode == 13
      $(this).autoNumeric('set', $(this).autoNumeric('get'))

  AdvertStageTwoBuilder.fillvalues()
  AdvertStageTwoBuilder.updatePriceField()