class @CategoryBuilder

  @__id_count = 0
  @new_id: ->
    @__id_count += 1
    return @__id_count

  # -- ID string creators --

  @field_id: (i) ->
    'field' + i

  @field_name_id: (i) ->
    @field_id(i) + '_name'

  @field_optional_id: (i) ->
    @field_id(i) + '_is_optional'

  @field_selectable_id: (i) ->
    @field_id(i) + '_is_selectable'

  @field_selectables_wrap_id: (i) ->
    @field_id(i) + '_selectables'

  @field_selectables_list_id: (i) ->
    @field_id(i) + '_selectables_list'

  @field_selectable_item_id: (fieldi, itemi) ->
    @field_id(fieldi) + '_s' + itemi

  @field_selectable_item_text_id: (fieldi, itemi) ->
    @field_id(fieldi) + '_s' + itemi + '_text'

  # -------------------------

  # -- Element creation methods --

  # Create initial visible form. Anchor it to an
  # element with id #category_builder_form_anchor
  @create_form: () ->
    html = "
    <div class='category_builder_form'>
      <label for='cat_name'>Name: </label>
      <input id='cat_name'
             type='text' value=''
             name='cat_name'>
      </input>
      <p>Fields:</p>
      <div id='fields'>
      </div>
      <a onclick='CategoryBuilder.add_field_container();'
           href='javascript:void(0);'>Add field</a>
    </div>
    "
    $('#category_builder_form_anchor').append(html)

    name = $('#category_name').val()
    fieldsjson = $('#category_fields').val()

    if name != ''
      $('#cat_name').val(name)
    if fieldsjson != ''
      obj = $.parseJSON(fieldsjson)
      for k,v of obj
        fieldi = @add_field_container()
        $('#'+@field_name_id(fieldi)).val(k)
        if 'optional' of v
          $('#'+@field_optional_id(fieldi)).prop('checked', v['optional']);

        if 'select' of v
          $('#'+@field_selectable_id(fieldi)).prop('checked', true);
          $('#'+@field_selectables_wrap_id(fieldi)).show()
          for s in v['select']
            itemi = @add_empty_selectable_to(fieldi)
            $('#'+@field_selectable_item_text_id(fieldi, itemi)).val(s)

  # Add a field container to the category
  @add_field_container: ->
    i = @new_id()
    html = "<div id='#{@field_id(i)}'>
        <p>Name:
            <input class='name_box'
                   id='#{@field_name_id(i)}'
                   name='name'
                   type='text'
                   value='Type' />
        </p>
        <p>Optional:
            <input checked='checked'
                   class='optional_box'
                   id='#{@field_optional_id(i)}'
                   name='optional'
                   type='checkbox'
                   value='Optional' />
        </p>
        <p>Select from a list:
            <input id='#{@field_selectable_id(i)}'
                   name='selectable'
                   onclick='CategoryBuilder.toggle_selectable(#{i});'
                   type='checkbox'
                   value='Selectable' />
        </p>
        <div id=#{@field_selectables_wrap_id(i)} style='display: none;'>
          <div id=#{@field_selectables_list_id(i)}></div>
          <a onclick='CategoryBuilder.add_empty_selectable_to(#{i});'
               href='javascript:void(0);'>Add item</a>
        </div>
        <a onclick='CategoryBuilder.remove_field_container(#{i});'
           href='javascript:void(0);'>remove field</a>
        </div>
        "
    $('#fields').append(html)
    return i

  # Remove the field container with the given id
  @remove_field_container: (i) ->
    $('#'+@field_id(i)).remove()

  # When a selectable checkbox is toggled, do the correct action
  @toggle_selectable: (i) ->
    if $('#'+@field_selectable_id(i)).is ':checked'
      $('#'+@field_selectables_wrap_id(i)).show()
      @add_empty_selectable_to(i)
    else
      $('#'+@field_selectables_list_id(i)).empty()
      $('#'+@field_selectables_wrap_id(i)).hide()


  # Add another blank item to a selectables list
  @add_empty_selectable_to: (i) ->
    selectables_list = $('#'+@field_selectables_list_id(i))
    c = @new_id()
    selectables_list.append("
        <p id='#{@field_selectable_item_id(i, c)}'>
        <input id='#{@field_selectable_item_text_id(i, c)}'
               class='selectable_item'
               type='text' value=''
               name='item'>
        </input>
        <a onclick='CategoryBuilder.remove_sel_item(#{i}, #{c});'
           href='javascript:void(0);'>remove</a>
        </p>"
    )
    return c

  # Remove the selectable with the given id
  @remove_sel_item: (i, id) ->
    # count items in selection set
    selectables_list = $('#'+@field_selectables_list_id(i))
    if selectables_list.children().length > 1
      $('#'+@field_selectable_item_id(i, id)).remove()
    else
      alert 'Cannot have an empty selection list.'

  # -------------------------------

  # -- Saving and Filling methods --
  @generate_params: ->
    name = $('#cat_name').val().trim()
    if name == ''
        alert 'Cannot save blank category name'
        return false

    fieldsdict = {}
    $('#fields').children().each (index, element) =>
      field = $(element)
      i = field.attr('id').substring(5)
      n = $('#'+@field_name_id(i)).val().trim()
      o = $('#'+@field_optional_id(i)).is ':checked'

      if n == ''
        alert 'Cannot save blank field names'
        return false

      fieldsdict[n] = {}
      fieldsdict[n]['optional'] = o

      s = $('#'+@field_selectable_id(i)).is ':checked'
      if s
        slist = []
        $('#'+@field_selectables_list_id(i)).children().each (index2, element2) =>
          t = $('#' + $(element2).attr('id') + '_text').val().trim()
          if t != ''
            slist.push $('#' + $(element2).attr('id') + '_text').val()

        if slist.length == 0
          alert 'Selection list must contain text items!'
          return false

        fieldsdict[n]['select'] = slist

    json = JSON.stringify(fieldsdict)

    # apply values to form fields
    $('#category_name').val(name)
    $('#category_fields').val(json)

    return true

  @save: ->
    r = @generate_params()
    if r
      frm = $('#form_wrapper').children('form')[0]
      frm.submit()
