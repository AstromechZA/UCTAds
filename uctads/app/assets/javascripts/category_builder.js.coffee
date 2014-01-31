class @CategoryBuilder
  @toggle_selectable: (id) ->
    fieldbox = "#field#{id}"
    checkbox = "#{fieldbox}_is_selectable"
    selectables = "#{fieldbox}_selectables"
    if $(checkbox).is ':checked'
      $(fieldbox).append("<div id=field#{id}_selectables></div>")
      @add_empty_selectable(id)
    else
      $(selectables).remove()

  @add_empty_selectable: (id) ->
    fieldbox = "#field#{id}"
    selectables = "#{fieldbox}_selectables"
    $(selectables).append("
        <p>
        <input id='item' class='selectable_item' type='text' value='' name='item'>
        </input>
        </p>"
    )

  @add_field_container_of_id: (id) ->
    html = "<div class='field_container' id='field#{id}'>
        <p>Name:
            <input class='name_box' id='name' name='name' type='text' value='Type' />
        </p>
        <p>Optional:
            <input checked='checked' class='optional_box' id='optional' name='optional' type='checkbox' value='Optional' />
        </p>
        <p>Select from a list:
            <input id='field#{id}_is_selectable' name='selectable' onclick='CategoryBuilder.toggle_selectable(#{id});' type='checkbox' value='Selectable' />
        </p>"
    $('#fields').append(html)

  @add_field_container: ->
    i = $('.field_container').length + 1
    @add_field_container_of_id(i)

  @save: ->
    alert 'save'