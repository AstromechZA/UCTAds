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