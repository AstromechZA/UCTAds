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

  # -------------------------

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

  # Add another field to the category builder
  @add_field_container_of_id: (i) ->
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
        </p></div>
        "
    $('#fields').append(html)

  # When a selectable checkbox is toggled, do the correct action
  @toggle_selectable: (i) ->
    if $('#'+@field_selectable_id(i)).is ':checked'
      $('#'+@field_id(i)).append(@make_selectables_list_html(i))
      @add_empty_selectable_to(i)
    else
      $('#'+@field_selectables_wrap_id(i)).remove()

  # Generate html for selectables list
  @make_selectables_list_html: (i) ->
    "<div id=#{@field_selectables_wrap_id(i)}>
        <div id=#{@field_selectables_list_id(i)}></div>
        <a onclick='CategoryBuilder.add_empty_selectable_to(#{i});'
           href='javascript:void(0);'>Add item</a>
    </div"

  # Add another blank item to a selectables list
  @add_empty_selectable_to: (i) ->
    selectables_list = $('#'+@field_selectables_list_id(i))
    c = @new_id()
    selectables_list.append("
        <p id='#{@field_selectable_item_id(i, c)}'>
        <input id='item'
               class='selectable_item'
               type='text' value=''
               name='item'>
        </input>
        <a onclick='CategoryBuilder.remove_sel_item(#{i}, #{c});'
           href='javascript:void(0);'>remove</a>
        </p>"
    )

  # Add a field container to the category
  @add_field_container: ->
    @add_field_container_of_id(@new_id())

  # Remove the field container with the given id
  @remove_field_container: (i) ->
    $('#'+@field_id(i)).remove()

  @generate_params: ->
    name = $('#cat_name').val()
    alert n

  @save: ->
    @generate_params()
    alert 'save'

  @remove_sel_item: (i, id) ->
    # count items in selection set
    selectables_list = $('#'+@field_selectables_list_id(i))
    if selectables_list.children().length > 1
      $('#'+@field_selectable_item_id(i, id)).remove()
    else
      alert 'Cannot have an empty selection list.'