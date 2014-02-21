class @AdvertStageOneBuilder
  @next: (i) ->
    $('#advert_category_id').val(i)
    frm = $('#form_wrapper').children('form')[0]
    frm.submit()
